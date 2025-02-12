#![allow(dead_code)]
#![allow(unused_variables)]

use crate::bus::Bus;
use crate::bus::Io;
use crate::registers::Registers;
use crate::registers::Regs;

pub struct Cpu {
    pub bus: Bus,
    pub registers: Registers,
    pub alternate: Registers,

    pub reset: bool,
    pub hard_reset: bool,

    pub iorq: bool,

    pub im: u8,
    pub nmi: bool,
    pub halt: bool,
    pub interrupts_enabled: bool,

    pub iff1: bool,
    pub iff2: bool,
}

enum Type {
    Direct(u16),
    Register(Regs),
    Immediate(u8),
}

impl Cpu {
    /// Create new Cpu instance
    ///
    /// Create a new Cpu instance, need `bus` as a parameter which
    /// is an instance of [Bus]
    pub fn new(bus: Bus) -> Self {
        Self {
            bus,
            registers: Registers::new(),
            alternate: Registers::new(),
            reset: false,
            hard_reset: true,
            iorq: false,
            im: 0,
            nmi: false,
            halt: false,
            interrupts_enabled: true,
            iff1: false,
            iff2: false,
        }
    }

    fn get_value(&self, t: &Type) -> u8 {
        match t {
            Type::Direct(addr) => self.bus.read_mem(*addr),
            Type::Register(reg) => self.get_register_value(reg),
            Type::Immediate(value) => *value,
        }
    }

    fn get_register_value(&self, reg: &Regs) -> u8 {
        match reg {
            Regs::A => self.registers.reg_a,
            Regs::B => self.registers.reg_b,
            Regs::C => self.registers.reg_c,
            Regs::D => self.registers.reg_d,
            Regs::E => self.registers.reg_e,
            Regs::H => self.registers.reg_h,
            Regs::L => self.registers.reg_l,
            _ => 0,
        }
    }

    fn set_value(&mut self, t: &Type, value: u8) {
        match t {
            Type::Direct(addr) => self.bus.write_mem(*addr, value),
            Type::Register(reg) => self.set_register_value(reg, value),
            Type::Immediate(_) => (),
        }
    }

    fn set_register_value(&mut self, reg: &Regs, value: u8) {
        match reg {
            Regs::A => self.registers.reg_a = value,
            Regs::B => self.registers.reg_b = value,
            Regs::C => self.registers.reg_c = value,
            Regs::D => self.registers.reg_d = value,
            Regs::E => self.registers.reg_e = value,
            Regs::H => self.registers.reg_h = value,
            Regs::L => self.registers.reg_l = value,
            _ => (),
        }
    }

    fn abs(value: u8) -> u8 {
        if value & 0x80 == 0x80 {
            ((0x100 - value as u16) & 0x007f) as u8
        } else {
            value
        }
    }

    fn daa(&mut self) {
        let mut t = 0;

        if self.registers.reg_f.h || (self.registers.reg_a & 0x0f) > 9 {
            t += 1;
        }

        if self.registers.reg_f.c || self.registers.reg_a > 0x99 {
            t += 2;
            self.registers.reg_f.c = true;
        }

        if self.registers.reg_f.n && !self.registers.reg_f.h {
            self.registers.reg_f.h = false;
        } else if self.registers.reg_f.n && self.registers.reg_f.h {
            self.registers.reg_f.h = (self.registers.reg_a & 0x0f) < 6;
        } else {
            self.registers.reg_f.h = (self.registers.reg_a & 0x0f) >= 0x0a;
        }

        match t {
            1 => {
                self.registers.reg_a = if self.registers.reg_f.n {
                    self.registers.reg_a.wrapping_sub(0xfa)
                } else {
                    self.registers.reg_a.wrapping_add(6)
                };
            }
            2 => {
                self.registers.reg_a = if self.registers.reg_f.n {
                    self.registers.reg_a.wrapping_sub(0xa0)
                } else {
                    self.registers.reg_a.wrapping_add(0x60)
                };
            }
            3 => {
                if self.registers.reg_f.n {
                    self.registers.reg_a = self.registers.reg_a.wrapping_sub(0x9a);
                } else {
                    self.registers.reg_a = self.registers.reg_a.wrapping_add(0x66);
                }
            }
            _ => {}
        }

        self.registers.reg_f.s = (self.registers.reg_a as i8) < 0;
        self.registers.reg_f.z = self.registers.reg_a == 0;
        self.registers.reg_f.p = self.registers.reg_a.count_ones() & 1 == 0;
    }

    fn inc(&mut self, r1: u8) -> u8 {
        let value = r1.wrapping_add(1);
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (r1 & 0x0f) + 1 > 0x0f;
        self.registers.reg_f.p = r1 == 0x7f;
        self.registers.reg_f.n = false;
        value
    }

    fn dec(&mut self, r1: u8) -> u8 {
        let value = r1.wrapping_sub(1);
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.p = r1 == 0x80;
        self.registers.reg_f.h = ((r1 & 0x0f) as i8) < 1;
        self.registers.reg_f.n = true;
        value
    }

    fn add(&mut self, r1: u8) {
        let a = self.registers.reg_a;
        let value = a.wrapping_add(r1);
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (value & 0x0f) + (a & 0x0f) > 0x0f;
        self.registers.reg_f.c = u16::from(a) + u16::from(r1) > 0xff;
        self.registers.reg_f.p = (a as i8).overflowing_add(value as i8).1;
        self.registers.reg_f.n = false;
        self.registers.reg_a = value;
    }

    fn adc(&mut self, r1: u8) {
        let carry = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        let a = self.registers.reg_a;
        let value = a.wrapping_add(r1).wrapping_add(carry);
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (value & 0x0f) + (a & 0x0f) + carry > 0x0f;
        self.registers.reg_f.c = u16::from(a) + u16::from(r1) + u16::from(carry) > 0xff;
        self.registers.reg_f.p = (a as i8).overflowing_add(value.wrapping_add(carry) as i8).1;
        self.registers.reg_f.n = false;
        self.registers.reg_a = value;
    }

    fn add16(&mut self, r1: u16, r2: u16) -> u16 {
        let v = r1.wrapping_add(r2);
        self.registers.reg_f.c = u32::from(r1) + u32::from(r2) > 0xffff;
        self.registers.reg_f.h = (r1 & 0x0fff) + (r2 & 0x0fff) > 0x0fff;
        self.registers.reg_f.n = false;
        v
    }

    fn adc16(&mut self, r1: u16, r2: u16) -> u16 {
        let c = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        let value = r1.wrapping_add(r2).wrapping_add(c);
        self.registers.set_hl(value);
        self.registers.reg_f.s = (value as i16) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (value & 0x0fff) + (r1 & 0x0fff) + c > 0x0fff;
        self.registers.reg_f.c = u32::from(r1) + u32::from(r2) + u32::from(c) > 0xffff;
        self.registers.reg_f.p = (value as i16).overflowing_add((r1 + c) as i16).1;
        self.registers.reg_f.n = false;
        value
    }

    /// Substract `r1` from register A
    ///
    /// r1: Register to substract from A
    fn sub(&mut self, r1: u8) {
        let a = self.registers.reg_a;
        let value = a.wrapping_sub(r1);
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (a as i8 & 0x0f) < (value as i8 & 0x0f);
        self.registers.reg_f.c = u16::from(a) < u16::from(r1);
        self.registers.reg_f.p = (a as i8).overflowing_sub(value as i8).1;
        self.registers.reg_f.n = true;
        self.registers.reg_a = value;
    }

    fn sbc(&mut self, r1: u8) {
        let carry: u8 = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        let a = self.registers.reg_a;
        let value = a.wrapping_sub(r1.wrapping_add(carry));
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (a as i8 & 0x0f) < (value as i8 & 0x0f).wrapping_add(carry as i8);
        self.registers.reg_f.c = u16::from(a) < (u16::from(r1) + u16::from(carry));
        self.registers.reg_f.p = (a as i8).overflowing_sub(value.wrapping_add(carry) as i8).1;
        self.registers.reg_f.n = true;
        self.registers.reg_a = value;
    }

    fn sbc16(&mut self, r1: u16) {
        let carry: u16 = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        let hl = self.registers.get_hl();
        let value = hl.wrapping_sub(r1).wrapping_sub(carry);
        self.registers.set_hl(value);
        self.registers.reg_f.s = (value as i16) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (hl & 0x0fff) < (r1 & 0x0fff) + carry;
        self.registers.reg_f.p = (hl as i16).overflowing_sub((value + carry) as i16).1;
        self.registers.reg_f.n = true;
        self.registers.reg_f.c = hl < r1 + carry;
    }

    fn and(&mut self, t: Type) {
        let r1 = self.get_value(&t);
        let a = self.registers.reg_a;
        let value = a & r1;
        self.registers.reg_a = value;
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = false;
        self.registers.reg_f.p = value.count_ones() & 1 == 0;
        self.registers.reg_f.n = false;
        self.registers.reg_f.c = false;
    }

    fn or(&mut self, t: Type) {
        let r1 = self.get_value(&t);
        let a = self.registers.reg_a;
        let value = a | r1;
        self.registers.reg_a = value;
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = false;
        self.registers.reg_f.p = value.count_ones() & 1 == 0;
        self.registers.reg_f.n = false;
        self.registers.reg_f.c = false;
    }

    fn xor(&mut self, t: Type) {
        let r1 = self.get_value(&t);
        let a = self.registers.reg_a;
        let value = a ^ r1;
        self.registers.reg_a = value;
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = false;
        self.registers.reg_f.p = value.count_ones() & 1 == 0;
        self.registers.reg_f.n = false;
        self.registers.reg_f.c = false;
    }

    /// Compare register A with r1
    ///
    /// r1: Register to compare
    /// Flags are set based on the result
    fn cp(&mut self, r1: u8) {
        let a = self.registers.reg_a;
        self.sub(r1);
        self.registers.reg_a = a;
    }

    fn pop_stack(&mut self) {
        self.registers.reg_pc = self.bus.read_mem_u16(self.registers.reg_sp);
        // self.registers.reg_sp += 2;
        self.registers.reg_sp = self.registers.reg_sp.wrapping_add(2);
    }

    fn push_stack(&mut self, value: u16) {
        // self.registers.reg_sp -= 2;
        self.registers.reg_sp = self.registers.reg_sp.wrapping_sub(2);
        self.bus.write_mem_u16(self.registers.reg_sp, value);
    }

    /// Rotate left carry direct
    fn rlc(&mut self, t: Type) {
        let carry = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        let r1 = self.get_value(&t);
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.set_value(&t, r1 << 1 | carry >> 7);
    }

    fn rrc(&mut self, t: Type) {
        let carry = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        let r1 = self.get_value(&t);
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.set_value(&t, r1 >> 1 | carry << 7);
    }

    fn rl(&mut self, t: Type) {
        let carry = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        let r1 = self.get_value(&t);
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.set_value(&t, r1 << 1 | carry);
    }

    fn rr(&mut self, t: Type) {
        let carry = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        let r1 = self.get_value(&t);
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.set_value(&t, r1 >> 1 | carry);
    }

    fn sla(&mut self, t: Type) {
        let r1 = self.get_value(&t);
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.set_value(&t, r1 << 1);
    }

    fn sll(&mut self, t: Type) {
        let r1 = self.get_value(&t);
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.set_value(&t, r1 << 1 | 1);
    }

    fn sra(&mut self, t: Type) {
        let r1 = self.get_value(&t);
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.set_value(&t, r1 >> 1 | r1 & 0x80);
    }

    fn srl(&mut self, t: Type) {
        let r1 = self.get_value(&t);
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.set_value(&t, r1 >> 1);
    }

    fn bit(&mut self, bit: u8, r1: u8) {
        self.registers.reg_f.h = true;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 & (1 << bit) == (1 << bit);
    }

    fn res(&mut self, bit: u8, r1: u8) -> u8 {
        r1 & !(1 << bit)
    }

    fn set(&mut self, bit: u8, r1: u8) -> u8 {
        r1 | (1 << bit)
    }

    fn cpi(&mut self) {
        let bc = self.registers.get_bc();
        let hl = self.registers.get_hl();
        let value = self.bus.read_mem(hl);
        let result = self.registers.reg_a.wrapping_sub(value);

        self.registers.set_hl(hl.wrapping_add(1));
        self.registers.set_bc(bc.wrapping_sub(1));

        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = self.registers.reg_a == value;
        self.registers.reg_f.h = (self.registers.reg_a as i8 & 0x0f) < (value as i8 & 0x0f);
        self.registers.reg_f.p = self.registers.get_bc() != 0;
        self.registers.reg_f.n = true;
    }

    fn cpd(&mut self) {
        let bc = self.registers.get_bc();
        let hl = self.registers.get_hl();
        let value = self.bus.read_mem(hl);
        let result = self.registers.reg_a.wrapping_sub(value);

        self.registers.set_hl(hl.wrapping_sub(1));
        self.registers.set_bc(bc.wrapping_sub(1));

        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = self.registers.reg_a == value;
        self.registers.reg_f.h = (self.registers.reg_a as i8 & 0x0f) < (value as i8 & 0x0f);
        self.registers.reg_f.p = self.registers.get_bc() != 0;
        self.registers.reg_f.n = true;
    }

    /// Execute opcode at current program counter
    ///
    /// Return:
    /// pc: New program counter
    pub fn exec_opcode(&mut self) {
        if self.halt {
            return;
        }

        if self.nmi {
            self.nmi = false;
            self.push_stack(self.registers.reg_pc);
            self.registers.reg_pc = 0x0066;
            self.iff2 = self.iff1;
            self.iff1 = false;
        }

        let opcode = self.bus.read_mem(self.registers.reg_pc);
        self.registers.reg_pc += 1;
        match opcode {
            0x00 => (), // nop
            0x01 => {
                // ld bc,nn
                let value = self.bus.read_mem_u16(self.registers.reg_pc);
                self.registers.set_bc(value);
                self.registers.reg_pc += 2;
            }
            0x02 => {
                // ld (bc),a
                let addr = self.registers.get_bc();
                self.bus.write_mem(addr, self.registers.reg_a);
            }
            0x03 => {
                // inc bc
                let bc = self.registers.get_bc() + 1;
                self.registers.set_bc(bc);
            }
            0x04 => {
                // inc b
                self.registers.reg_b = self.inc(self.registers.reg_b);
            }
            0x05 => {
                // dec b
                self.registers.reg_b = self.dec(self.registers.reg_b);
            }
            0x06 => {
                // ld b,n
                let value = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_b = value;
                self.registers.reg_pc += 1;
            }
            0x07 => {
                // rlca
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = self.registers.reg_a & 0x80 == 0x80;
                self.registers.reg_a <<= 1;
            }
            0x08 => {
                // ex af,af'
                let af = self.registers.get_af();
                let aaf = self.alternate.get_af();
                self.registers.set_af(aaf);
                self.alternate.set_af(af);
            }
            0x09 => {
                // add hl,bc
                let bc = self.registers.get_bc();
                let hl = self.registers.get_hl();
                let value = self.add16(hl, bc);
                self.registers.set_hl(value);
            }
            0x0a => {
                // ld a,(bc)
                let bc = self.registers.get_bc();
                self.registers.reg_a = self.bus.read_mem(bc);
            }
            0x0b => {
                // dec bc
                let bc = self.registers.get_bc().wrapping_sub(1);
                self.registers.set_bc(bc);
            }
            0x0c => {
                // inc c
                self.registers.reg_c = self.inc(self.registers.reg_c);
            }
            0x0d => {
                // dec c
                self.registers.reg_c = self.dec(self.registers.reg_c);
            }
            0x0e => {
                // ld c,n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_c = n;
                self.registers.reg_pc += 1;
            }
            0x0f => {
                // rrca
                let carry = self.registers.reg_a & 0x01;
                let a = if self.registers.reg_f.c {
                    self.registers.reg_a >> 1 | 0x80
                } else {
                    self.registers.reg_a >> 1
                };
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = carry == 0x01;
                self.registers.reg_a = a;
            }
            0x10 => {
                // djnz $+2
                self.registers.reg_b = self.registers.reg_b.wrapping_sub(1);
                if self.registers.reg_b == 0 {
                    self.registers.reg_pc += 1;
                } else {
                    let value = self.bus.read_mem(self.registers.reg_pc);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc -= Cpu::abs(value) as u16 - 1;
                    } else {
                        self.registers.reg_pc += 1 + value as u16;
                    }
                }
            }
            0x11 => {
                // ld de,nn
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                self.registers.set_de(nn);
                self.registers.reg_pc += 2
            }
            0x12 => {
                // ld (de),a
                let de = self.registers.get_de();
                self.bus.write_mem(de, self.registers.reg_a);
            }
            0x13 => {
                // inc de
                let de = self.registers.get_de() + 1;
                self.registers.set_de(de);
            }
            0x14 => {
                // inc d
                self.registers.reg_d = self.inc(self.registers.reg_d);
            }
            0x15 => {
                // dec d
                self.registers.reg_d = self.dec(self.registers.reg_d);
            }
            0x16 => {
                // ld d,n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_d = n;
                self.registers.reg_pc += 1;
            }
            0x17 => {
                // rla
                let c = match self.registers.reg_f.c {
                    true => 1u8,
                    false => 0u8,
                };
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = self.registers.reg_a & 0x80 == 0x80;
                self.registers.reg_a <<= 1 | c;
            }
            0x18 => {
                // jr $+2
                let value = self.bus.read_mem(self.registers.reg_pc);
                if value & 0x80 == 0x80 {
                    self.registers.reg_pc -= Cpu::abs(value) as u16 - 1;
                } else {
                    self.registers.reg_pc += 1 + value as u16;
                }
            }
            0x19 => {
                // add hl,de
                let de = self.registers.get_de();
                let hl = self.registers.get_hl();
                let value = self.add16(hl, de);
                self.registers.set_hl(value);
            }
            0x1a => {
                // ld a,(de)
                let de = self.registers.get_de();
                self.registers.reg_a = self.bus.read_mem(de);
            }
            0x1b => {
                // dec de
                let de = self.registers.get_de().wrapping_sub(1);
                self.registers.set_de(de);
            }
            0x1c => {
                // inc e
                self.registers.reg_e = self.inc(self.registers.reg_e);
            }
            0x1d => {
                // dec e
                self.registers.reg_e = self.dec(self.registers.reg_e);
            }
            0x1e => {
                // ld e,n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_e = n;
                self.registers.reg_pc += 1;
            }
            0x1f => {
                // rra
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                let carry = match self.registers.reg_f.c {
                    true => 1,
                    false => 0,
                };
                self.registers.reg_f.c = self.registers.reg_a & 0x01 == 0x01;
                self.registers.reg_a = (self.registers.reg_a >> 1) | (carry << 7);
            }
            0x20 => {
                // jr nz,$+2
                if !self.registers.reg_f.z {
                    let value = self.bus.read_mem(self.registers.reg_pc);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc -= Cpu::abs(value) as u16 - 1;
                    } else {
                        self.registers.reg_pc += 1 + value as u16;
                    }
                } else {
                    self.registers.reg_pc += 1;
                }
            }
            0x21 => {
                // ld hl,nn
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                self.registers.set_hl(nn);
                self.registers.reg_pc += 2;
            }
            0x22 => {
                // ld (nn),hl
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                self.bus.write_mem_u16(nn, self.registers.get_hl());
                self.registers.reg_pc += 2;
            }
            0x23 => {
                // inc hl
                let hl = self.registers.get_hl().wrapping_add(1);
                self.registers.set_hl(hl);
            }
            0x24 => {
                // inc h
                self.registers.reg_h = self.inc(self.registers.reg_h);
            }
            0x25 => {
                // dec h
                self.registers.reg_h = self.dec(self.registers.reg_h);
            }
            0x26 => {
                // ld h,n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_h = n;
                self.registers.reg_pc += 1
            }
            0x27 => {
                // daa
                self.daa();
            }
            0x28 => {
                // jr z,$+2
                if self.registers.reg_f.z {
                    let value = self.bus.read_mem(self.registers.reg_pc);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc -= Cpu::abs(value) as u16 - 1;
                    } else {
                        self.registers.reg_pc += 1 + value as u16;
                    }
                } else {
                    self.registers.reg_pc += 1;
                }
            }
            0x29 => {
                // add hl,hl
                let hl = self.registers.get_hl();
                let value = self.add16(hl, hl);
                self.registers.set_hl(value);
            }
            0x2a => {
                // ld hl,(nn)
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                let n = self.bus.read_mem_u16(nn);
                self.registers.set_hl(n);
                self.registers.reg_pc += 2;
            }
            0x2b => {
                // dec hl
                let hl = self.registers.get_hl().wrapping_sub(1);
                self.registers.set_hl(hl);
            }
            0x2c => {
                // inc l
                self.registers.reg_l = self.inc(self.registers.reg_l);
            }
            0x2d => {
                // dec l
                self.registers.reg_l = self.dec(self.registers.reg_l);
            }
            0x2e => {
                // ld l,n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_l = n;
                self.registers.reg_pc += 1;
            }
            0x2f => {
                // cpl
                let a = self.registers.reg_a;
                self.registers.reg_a = ((a & 0x0f) << 4) | ((a & 0xf0) >> 4);
            }
            0x30 => {
                // jr nc,$+2
                if !self.registers.reg_f.c {
                    let value = self.bus.read_mem(self.registers.reg_pc);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc -= Cpu::abs(value) as u16 - 1;
                    } else {
                        self.registers.reg_pc += 1 + value as u16;
                    }
                } else {
                    self.registers.reg_pc += 1;
                }
            }
            0x31 => {
                // ld sp,nn
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                self.registers.set_sp(nn);
                self.registers.reg_pc += 2;
            }
            0x32 => {
                // ld (nn),a
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                self.bus.write_mem(nn, self.registers.reg_a);
                self.registers.reg_pc += 2;
            }
            0x33 => {
                // inc sp
                let sp = self.registers.get_sp().wrapping_add(1);
                self.registers.set_sp(sp);
            }
            0x34 => {
                // inc (hl)
                let hl = self.registers.get_hl();
                let v = self.inc(self.bus.read_mem(hl));
                self.bus.write_mem(hl, v);
            }
            0x35 => {
                // dec (hl)
                let hl = self.registers.get_hl();
                let v = self.dec(self.bus.read_mem(hl));
                self.bus.write_mem(hl, v);
            }
            0x36 => {
                // ld (hl),n
                let n = self.bus.read_mem(self.registers.reg_pc);
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, n);
                self.registers.reg_pc += 1;
            }
            0x37 => {
                // scf
                self.registers.reg_f.c = true;
            }
            0x38 => {
                // jr c,$+2
                if self.registers.reg_f.c {
                    let value = self.bus.read_mem(self.registers.reg_pc);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc -= Cpu::abs(value) as u16 - 1;
                    } else {
                        self.registers.reg_pc += 1 + value as u16;
                    }
                } else {
                    self.registers.reg_pc += 1;
                }
            }
            0x39 => {
                // add hl,sp
                let sp = self.registers.get_sp();
                let hl = self.registers.get_hl();
                let value = self.add16(hl, sp);
                self.registers.set_hl(value);
            }
            0x3a => {
                // ld a,(nn)
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                let n = self.bus.read_mem_u16(nn);
                self.registers.reg_a = self.bus.read_mem(n);
                self.registers.reg_pc += 2;
            }
            0x3b => {
                // dec sp
                let sp = self.registers.get_sp().wrapping_sub(1);
                self.registers.set_sp(sp);
            }
            0x3c => {
                // inc a
                self.registers.reg_a = self.inc(self.registers.reg_a);
            }
            0x3d => {
                // dec a
                self.registers.reg_a = self.dec(self.registers.reg_a);
            }
            0x3e => {
                // ld a,n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_a = n;
                self.registers.reg_pc += 1;
            }
            0x3f => {
                // ccf
                self.registers.reg_f.c = false;
            }
            0x40 => { // ld b,b
            }
            0x41 => {
                // ld b,c
                self.registers.reg_b = self.registers.reg_c;
            }
            0x42 => {
                // ld b,d
                self.registers.reg_b = self.registers.reg_d;
            }
            0x43 => {
                // ld b,e
                self.registers.reg_b = self.registers.reg_e;
            }
            0x44 => {
                // ld b,h
                self.registers.reg_b = self.registers.reg_h;
            }
            0x45 => {
                // ld b,l
                self.registers.reg_b = self.registers.reg_l;
            }
            0x46 => {
                // ld b,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_b = self.bus.read_mem(hl);
            }
            0x47 => {
                // ld b,a
                self.registers.reg_b = self.registers.reg_a;
            }
            0x48 => {
                // ld c,b
                self.registers.reg_b = self.registers.reg_a;
            }
            0x49 => { // ld c,c
            }
            0x4a => {
                // ld c,d
                self.registers.reg_c = self.registers.reg_d;
            }
            0x4b => {
                // ld c,e
                self.registers.reg_c = self.registers.reg_e;
            }
            0x4c => {
                // ld c,h
                self.registers.reg_c = self.registers.reg_h;
            }
            0x4d => {
                // ld c,l
                self.registers.reg_c = self.registers.reg_l;
            }
            0x4e => {
                // ld c,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_c = self.bus.read_mem(hl);
            }
            0x4f => {
                // ld c,a
                self.registers.reg_c = self.registers.reg_a;
            }
            0x50 => {
                // ld d,b
                self.registers.reg_d = self.registers.reg_b;
            }
            0x51 => {
                // ld d,c
                self.registers.reg_d = self.registers.reg_c;
            }
            0x52 => { // ld d,d
            }
            0x53 => {
                // ld d,e
                self.registers.reg_d = self.registers.reg_e;
            }
            0x54 => {
                // ld d,h
                self.registers.reg_d = self.registers.reg_h;
            }
            0x55 => {
                // ld d,l
                self.registers.reg_d = self.registers.reg_l;
            }
            0x56 => {
                // ld d,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_d = self.bus.read_mem(hl);
            }
            0x57 => {
                // ld d,a
                self.registers.reg_d = self.registers.reg_a;
            }
            0x58 => {
                // ld e,b
                self.registers.reg_e = self.registers.reg_b;
            }
            0x59 => {
                // ld e,c
                self.registers.reg_e = self.registers.reg_c;
            }
            0x5a => {
                // ld e,d
                self.registers.reg_e = self.registers.reg_d;
            }
            0x5b => { // ld e,e
            }
            0x5c => {
                // ld e,h
                self.registers.reg_e = self.registers.reg_h;
            }
            0x5d => {
                // ld e,l
                self.registers.reg_e = self.registers.reg_l;
            }
            0x5e => {
                // ld e,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_e = self.bus.read_mem(hl);
            }
            0x5f => {
                // ld e,a
                self.registers.reg_e = self.registers.reg_a;
            }
            0x60 => {
                // ld h,b
                self.registers.reg_h = self.registers.reg_b;
            }
            0x61 => {
                // ld h,c
                self.registers.reg_h = self.registers.reg_c;
            }
            0x62 => {
                // ld h,d
                self.registers.reg_h = self.registers.reg_d;
            }
            0x63 => {
                // ld h,e
                self.registers.reg_h = self.registers.reg_e;
            }
            0x64 => { // ld h,h
            }
            0x65 => {
                // ld h,l
                self.registers.reg_h = self.registers.reg_l;
            }
            0x66 => {
                // ld h,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_h = self.bus.read_mem(hl);
            }
            0x67 => {
                // ld h,a
                self.registers.reg_h = self.registers.reg_a;
            }
            0x68 => {
                // ld l,b
                self.registers.reg_l = self.registers.reg_b;
            }
            0x69 => {
                // ld l,c
                self.registers.reg_l = self.registers.reg_c;
            }
            0x6a => {
                // ld l,d
                self.registers.reg_l = self.registers.reg_d;
            }
            0x6b => {
                // ld l,e
                self.registers.reg_l = self.registers.reg_e;
            }
            0x6c => {
                // ld l,h
                self.registers.reg_l = self.registers.reg_h;
            }
            0x6d => { // ld l,l
            }
            0x6e => {
                // ld l,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_l = self.bus.read_mem(hl);
            }
            0x6f => {
                // ld l,a
                self.registers.reg_l = self.registers.reg_a;
            }
            0x70 => {
                // ld (hl),b
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_b);
            }
            0x71 => {
                // ld (hl),c
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_c);
            }
            0x72 => {
                // ld (hl),d
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_d);
            }
            0x73 => {
                // ld (hl),e
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_e);
            }
            0x74 => {
                // ld (hl),h
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_h);
            }
            0x75 => {
                // ld (hl),l
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_l);
            }
            0x76 => {
                // halt
                self.halt = true;
            }
            0x77 => {
                // ld (hl),a
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_a);
            }
            0x78 => {
                // ld a,b
                self.registers.reg_a = self.registers.reg_b;
            }
            0x79 => {
                // ld a,c
                self.registers.reg_a = self.registers.reg_c;
            }
            0x7a => {
                // ld a,d
                self.registers.reg_a = self.registers.reg_d;
            }
            0x7b => {
                // ld a,e
                self.registers.reg_a = self.registers.reg_e;
            }
            0x7c => {
                // ld a,h
                self.registers.reg_a = self.registers.reg_h;
            }
            0x7d => {
                // ld a,l
                self.registers.reg_a = self.registers.reg_l;
            }
            0x7e => {
                // ld a,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_a = self.bus.read_mem(hl);
            }
            0x7f => { // ld a,a
            }
            0x80 => {
                // add a,b
                self.add(self.registers.reg_b);
            }
            0x81 => {
                // add a,c
                self.add(self.registers.reg_c);
            }
            0x82 => {
                // add a,d
                self.add(self.registers.reg_d);
            }
            0x83 => {
                // add a,e
                self.add(self.registers.reg_e);
            }
            0x84 => {
                // add a,h
                self.add(self.registers.reg_h);
            }
            0x85 => {
                // add a,l
                self.add(self.registers.reg_l);
            }
            0x86 => {
                // add a,(hl)
                let hl = self.registers.get_hl();
                self.add(self.bus.read_mem(hl));
            }
            0x87 => {
                // add a,a
                self.add(self.registers.reg_a);
            }
            0x88 => {
                // adc a,b
                self.adc(self.registers.reg_b);
            }
            0x89 => {
                // adc a,c
                self.adc(self.registers.reg_c);
            }
            0x8a => {
                // adc a,d
                self.adc(self.registers.reg_d);
            }
            0x8b => {
                // adc a,e
                self.adc(self.registers.reg_e);
            }
            0x8c => {
                // adc a,h
                self.adc(self.registers.reg_h);
            }
            0x8d => {
                // adc a,l
                self.adc(self.registers.reg_l);
            }
            0x8e => {
                // adc a,(hl)
                let hl = self.registers.get_hl();
                self.adc(self.bus.read_mem(hl));
            }
            0x8f => {
                // adc a,a
                self.adc(self.registers.reg_a);
            }
            0x90 => {
                // sub b
                self.sub(self.registers.reg_b);
            }
            0x91 => {
                // sub c
                self.sub(self.registers.reg_c);
            }
            0x92 => {
                // sub d
                self.sub(self.registers.reg_d);
            }
            0x93 => {
                // sub e
                self.sub(self.registers.reg_e);
            }
            0x94 => {
                // sub h
                self.sub(self.registers.reg_h);
            }
            0x95 => {
                // sub l
                self.sub(self.registers.reg_l);
            }
            0x96 => {
                // sub (hl)
                let hl = self.registers.get_hl();
                self.sub(self.bus.read_mem(hl));
            }
            0x97 => {
                // sub a
                self.sub(self.registers.reg_a);
            }
            0x98 => {
                // sbc b
                self.sbc(self.registers.reg_b);
            }
            0x99 => {
                // sbc c
                self.sbc(self.registers.reg_c);
            }
            0x9a => {
                // sbc d
                self.sbc(self.registers.reg_d);
            }
            0x9b => {
                // sbc e
                self.sbc(self.registers.reg_e);
            }
            0x9c => {
                // sbc h
                self.sbc(self.registers.reg_h);
            }
            0x9d => {
                // sbc l
                self.sbc(self.registers.reg_l);
            }
            0x9e => {
                // sbc (hl)
                let hl = self.registers.get_hl();
                self.sbc(self.bus.read_mem(hl));
            }
            0x9f => {
                // sbc a
                self.sbc(self.registers.reg_a);
            }
            0xa0 => {
                // and b
                self.and(Type::Register(Regs::B));
            }
            0xa1 => {
                // and c
                self.and(Type::Register(Regs::C));
            }
            0xa2 => {
                // and d
                self.and(Type::Register(Regs::D));
            }
            0xa3 => {
                // and e
                self.and(Type::Register(Regs::E));
            }
            0xa4 => {
                // and h
                self.and(Type::Register(Regs::H));
            }
            0xa5 => {
                // and l
                self.and(Type::Register(Regs::L));
            }
            0xa6 => {
                // and (hl)
                let hl = self.registers.get_hl();
                self.and(Type::Direct(hl));
            }
            0xa7 => {
                // and a
                self.and(Type::Register(Regs::A));
            }
            0xa8 => {
                // xor b
                self.xor(Type::Register(Regs::B));
            }
            0xa9 => {
                // xor c
                self.xor(Type::Register(Regs::C));
            }
            0xaa => {
                // xor d
                self.xor(Type::Register(Regs::D));
            }
            0xab => {
                // xor e
                self.xor(Type::Register(Regs::E));
            }
            0xac => {
                // xor h
                self.xor(Type::Register(Regs::H));
            }
            0xad => {
                // xor l
                self.xor(Type::Register(Regs::L));
            }
            0xae => {
                // xor (hl)
                let hl = self.registers.get_hl();
                self.xor(Type::Direct(hl));
            }
            0xaf => {
                // xor a
                self.xor(Type::Register(Regs::A));
            }
            0xb0 => {
                // or b
                self.or(Type::Register(Regs::B));
            }
            0xb1 => {
                // or c
                self.or(Type::Register(Regs::C));
            }
            0xb2 => {
                // or d
                self.or(Type::Register(Regs::D));
            }
            0xb3 => {
                // or e
                self.or(Type::Register(Regs::E));
            }
            0xb4 => {
                // or h
                self.or(Type::Register(Regs::H));
            }
            0xb5 => {
                // or l
                self.or(Type::Register(Regs::L));
            }
            0xb6 => {
                // or (hl)
                let hl = self.registers.get_hl();
                self.or(Type::Direct(hl));
            }
            0xb7 => {
                // or a
                self.or(Type::Register(Regs::A));
            }
            0xb8 => {
                // cp b
                self.cp(self.registers.reg_b);
            }
            0xb9 => {
                // cp c
                self.cp(self.registers.reg_c);
            }
            0xba => {
                // cp d
                self.cp(self.registers.reg_d);
            }
            0xbb => {
                // cp e
                self.cp(self.registers.reg_e);
            }
            0xbc => {
                // cp h
                self.cp(self.registers.reg_h);
            }
            0xbd => {
                // cp l
                self.cp(self.registers.reg_l);
            }
            0xbe => {
                // cp (hl)
                let hl = self.registers.get_hl();
                self.cp(self.bus.read_mem(hl));
            }
            0xbf => {
                // cp a
                self.cp(self.registers.reg_a);
            }
            0xc0 => {
                // ret nz
                if !self.registers.reg_f.z {
                    self.pop_stack();
                }
            }
            0xc1 => {
                // pop bc
                self.registers
                    .set_bc(self.bus.read_mem_u16(self.registers.reg_sp));
                self.registers.reg_sp += 2;
            }
            0xc2 => {
                // jp nz,$+3
                let value = self.bus.read_mem_u16(self.registers.reg_pc);
                if !self.registers.reg_f.z {
                    self.registers.reg_pc = value;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xc3 => {
                // jp $+3
                self.registers.reg_pc = self.bus.read_mem_u16(self.registers.reg_pc);
            }
            0xc4 => {
                // call nz,nn
                let value = self.bus.read_mem_u16(self.registers.reg_pc);
                if !self.registers.reg_f.z {
                    self.registers.reg_pc = value;
                } else {
                    self.registers.reg_pc += 2
                }
            }
            0xc5 => {
                // push bc
                self.registers.reg_sp -= 2;
                self.bus
                    .write_mem_u16(self.registers.reg_sp, self.registers.get_bc());
            }
            0xc6 => {
                // add a,n
                self.add(self.bus.read_mem(self.registers.reg_pc));
                self.registers.reg_pc += 1;
            }
            0xc7 => {
                // rst 0
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0000;
            }
            0xc8 => {
                // ret z
                if self.registers.reg_f.z {
                    self.pop_stack();
                }
            }
            0xc9 => {
                // ret
                self.pop_stack();
            }
            0xca => {
                // jp z,$+3
                if self.registers.reg_f.z {
                    let value = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = value;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xcb => {
                let opcode = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_pc += 1;
                match opcode {
                    0x00 => {
                        // rlc b
                        self.rlc(Type::Register(Regs::B));
                    }
                    0x01 => {
                        // rlc c
                        self.rlc(Type::Register(Regs::C));
                    }
                    0x02 => {
                        // rlc d
                        self.rlc(Type::Register(Regs::D));
                    }
                    0x03 => {
                        // rlc e
                        self.rlc(Type::Register(Regs::E));
                    }
                    0x04 => {
                        // rlc h
                        self.rlc(Type::Register(Regs::H));
                    }
                    0x05 => {
                        // rlc l
                        self.rlc(Type::Register(Regs::L));
                    }
                    0x06 => {
                        // rlc (hl)
                        let addr = self.registers.get_hl();
                        let hl = self.bus.read_mem(addr);
                        self.rlc(Type::Direct(addr));
                    }
                    0x07 => {
                        // rlc a
                        self.rlc(Type::Register(Regs::A));
                    }
                    0x08 => {
                        // rrc b
                        self.rrc(Type::Register(Regs::B));
                    }
                    0x09 => {
                        // rrc c
                        self.rrc(Type::Register(Regs::C));
                    }
                    0x0a => {
                        // rrc d
                        self.rrc(Type::Register(Regs::D));
                    }
                    0x0b => {
                        // rrc e
                        self.rrc(Type::Register(Regs::E));
                    }
                    0x0c => {
                        // rrc h
                        self.rrc(Type::Register(Regs::H));
                    }
                    0x0d => {
                        // rrc l
                        self.rrc(Type::Register(Regs::L));
                    }
                    0x0e => {
                        // rrc (hl)
                        let addr = self.registers.get_hl();
                        let hl = self.bus.read_mem(addr);
                        self.rrc(Type::Direct(addr));
                    }
                    0x0f => {
                        // rrc a
                        self.rrc(Type::Register(Regs::A));
                    }
                    0x10 => {
                        // rl  b
                        self.rl(Type::Register(Regs::B));
                    }
                    0x11 => {
                        // rl  c
                        self.rl(Type::Register(Regs::C));
                    }
                    0x12 => {
                        // rl  d
                        self.rl(Type::Register(Regs::D));
                    }
                    0x13 => {
                        // rl  e
                        self.rl(Type::Register(Regs::E));
                    }
                    0x14 => {
                        // rl  h
                        self.rl(Type::Register(Regs::H));
                    }
                    0x15 => {
                        // rl  l
                        self.rl(Type::Register(Regs::L));
                    }
                    0x16 => {
                        // rl  (hl)
                        let hl = self.registers.get_hl();
                        self.rl(Type::Direct(hl));
                    }
                    0x17 => {
                        // rl  a
                        self.rl(Type::Register(Regs::A));
                    }
                    0x18 => {
                        // rr  b
                        self.rr(Type::Register(Regs::B));
                    }
                    0x19 => {
                        // rr  c
                        self.rr(Type::Register(Regs::C));
                    }
                    0x1a => {
                        // rr  d
                        self.rr(Type::Register(Regs::D));
                    }
                    0x1b => {
                        // rr  e
                        self.rr(Type::Register(Regs::E));
                    }
                    0x1c => {
                        // rr  h
                        self.rr(Type::Register(Regs::H));
                    }
                    0x1d => {
                        // rr  l
                        self.rr(Type::Register(Regs::L));
                    }
                    0x1e => {
                        // rr  (hl)
                        let hl = self.registers.get_hl();
                        self.rr(Type::Direct(hl));
                    }
                    0x1f => {
                        // rr  a
                        self.rr(Type::Register(Regs::A));
                    }
                    0x20 => {
                        // sla b
                        self.sla(Type::Register(Regs::B));
                    }
                    0x21 => {
                        // sla c
                        self.sla(Type::Register(Regs::C));
                    }
                    0x22 => {
                        // sla d
                        self.sla(Type::Register(Regs::D));
                    }
                    0x23 => {
                        // sla e
                        self.sla(Type::Register(Regs::E));
                    }
                    0x24 => {
                        // sla h
                        self.sla(Type::Register(Regs::H));
                    }
                    0x25 => {
                        // sla l
                        self.sla(Type::Register(Regs::L));
                    }
                    0x26 => {
                        // sla (hl)
                        let hl = self.registers.get_hl();
                        self.sla(Type::Direct(hl));
                    }
                    0x27 => {
                        // sla a
                        self.sla(Type::Register(Regs::A));
                    }
                    0x28 => {
                        // sra b
                        self.sra(Type::Register(Regs::B));
                    }
                    0x29 => {
                        // sra c
                        self.sra(Type::Register(Regs::C));
                    }
                    0x2a => {
                        // sra d
                        self.sra(Type::Register(Regs::D));
                    }
                    0x2b => {
                        // sra e
                        self.sra(Type::Register(Regs::E));
                    }
                    0x2c => {
                        // sra h
                        self.sra(Type::Register(Regs::H));
                    }
                    0x2d => {
                        // sra l
                        self.sra(Type::Register(Regs::L));
                    }
                    0x2e => {
                        // sra (hl)
                        let hl = self.registers.get_hl();
                        self.sra(Type::Direct(hl));
                    }
                    0x2f => {
                        // sra a
                        self.sra(Type::Register(Regs::A));
                    }
                    0x30 => {
                        // sll b
                        self.sll(Type::Register(Regs::B));
                    }
                    0x31 => {
                        // sll c
                        self.sll(Type::Register(Regs::C));
                    }
                    0x32 => {
                        // sll d
                        self.sll(Type::Register(Regs::D));
                    }
                    0x33 => {
                        // sll e
                        self.sll(Type::Register(Regs::E));
                    }
                    0x34 => {
                        // sll h
                        self.sll(Type::Register(Regs::H));
                    }
                    0x35 => {
                        // sll l
                        self.sll(Type::Register(Regs::L));
                    }
                    0x36 => {
                        // sll (hl)
                        let hl = self.registers.get_hl();
                        self.sll(Type::Direct(hl));
                    }
                    0x37 => {
                        // sll a
                        self.sll(Type::Register(Regs::A));
                    }
                    0x38 => {
                        // srl b
                        self.srl(Type::Register(Regs::B));
                    }
                    0x39 => {
                        // srl c
                        self.srl(Type::Register(Regs::C));
                    }
                    0x3a => {
                        // srl d
                        self.srl(Type::Register(Regs::D));
                    }
                    0x3b => {
                        // srl e
                        self.srl(Type::Register(Regs::E));
                    }
                    0x3c => {
                        // srl h
                        self.srl(Type::Register(Regs::H));
                    }
                    0x3d => {
                        // srl l
                        self.srl(Type::Register(Regs::L));
                    }
                    0x3e => {
                        // srl (hl)
                        let hl = self.registers.get_hl();
                        self.srl(Type::Direct(hl));
                    }
                    0x3f => {
                        // srl a
                        self.srl(Type::Register(Regs::A));
                    }
                    0x40 => {
                        // bit 0,b
                        self.bit(0, self.registers.reg_b);
                    }
                    0x41 => {
                        // bit 0,c
                        self.bit(0, self.registers.reg_c);
                    }
                    0x42 => {
                        // bit 0,d
                        self.bit(0, self.registers.reg_d);
                    }
                    0x43 => {
                        // bit 0,e
                        self.bit(0, self.registers.reg_e);
                    }
                    0x44 => {
                        // bit 0,h
                        self.bit(0, self.registers.reg_h);
                    }
                    0x45 => {
                        // bit 0,l
                        self.bit(0, self.registers.reg_l);
                    }
                    0x46 => {
                        // bit 0,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(0, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    }
                    0x47 => {
                        // bit 0,a
                        self.bit(0, self.registers.reg_a);
                    }
                    0x48 => {
                        // bit 1,b
                        self.bit(1, self.registers.reg_b);
                    }
                    0x49 => {
                        // bit 1,c
                        self.bit(1, self.registers.reg_c);
                    }
                    0x4a => {
                        // bit 1,d
                        self.bit(1, self.registers.reg_d);
                    }
                    0x4b => {
                        // bit 1,e
                        self.bit(1, self.registers.reg_e);
                    }
                    0x4c => {
                        // bit 1,h
                        self.bit(1, self.registers.reg_h);
                    }
                    0x4d => {
                        // bit 1,l
                        self.bit(1, self.registers.reg_l);
                    }
                    0x4e => {
                        // bit 1,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(1, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    }
                    0x4f => {
                        // bit 1,a
                        self.bit(1, self.registers.reg_a);
                    }
                    0x50 => {
                        // bit 2,b
                        self.bit(2, self.registers.reg_b);
                    }
                    0x51 => {
                        // bit 2,c
                        self.bit(2, self.registers.reg_c);
                    }
                    0x52 => {
                        // bit 2,d
                        self.bit(2, self.registers.reg_d);
                    }
                    0x53 => {
                        // bit 2,e
                        self.bit(2, self.registers.reg_e);
                    }
                    0x54 => {
                        // bit 2,h
                        self.bit(2, self.registers.reg_h);
                    }
                    0x55 => {
                        // bit 2,l
                        self.bit(2, self.registers.reg_l);
                    }
                    0x56 => {
                        // bit 2,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(2, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    }
                    0x57 => {
                        // bit 2,a
                        self.bit(2, self.registers.reg_a);
                    }
                    0x58 => {
                        // bit 3,b
                        self.bit(3, self.registers.reg_b);
                    }
                    0x59 => {
                        // bit 3,c
                        self.bit(3, self.registers.reg_c);
                    }
                    0x5a => {
                        // bit 3,d
                        self.bit(3, self.registers.reg_d);
                    }
                    0x5b => {
                        // bit 3,e
                        self.bit(3, self.registers.reg_e);
                    }
                    0x5c => {
                        // bit 3,h
                        self.bit(3, self.registers.reg_h);
                    }
                    0x5d => {
                        // bit 3,l
                        self.bit(3, self.registers.reg_l);
                    }
                    0x5e => {
                        // bit 3,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(3, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    }
                    0x5f => {
                        // bit 3,a
                        self.bit(3, self.registers.reg_a);
                    }
                    0x60 => {
                        // bit 4,b
                        self.bit(4, self.registers.reg_b);
                    }
                    0x61 => {
                        // bit 4,c
                        self.bit(4, self.registers.reg_c);
                    }
                    0x62 => {
                        // bit 4,d
                        self.bit(4, self.registers.reg_d);
                    }
                    0x63 => {
                        // bit 4,e
                        self.bit(4, self.registers.reg_e);
                    }
                    0x64 => {
                        // bit 4,h
                        self.bit(4, self.registers.reg_h);
                    }
                    0x65 => {
                        // bit 4,l
                        self.bit(4, self.registers.reg_l);
                    }
                    0x66 => {
                        // bit 4,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(4, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    }
                    0x67 => {
                        // bit 4,a
                        self.bit(4, self.registers.reg_a);
                    }
                    0x68 => {
                        // bit 5,b
                        self.bit(5, self.registers.reg_b);
                    }
                    0x69 => {
                        // bit 5,c
                        self.bit(5, self.registers.reg_c);
                    }
                    0x6a => {
                        // bit 5,d
                        self.bit(5, self.registers.reg_d);
                    }
                    0x6b => {
                        // bit 5,e
                        self.bit(5, self.registers.reg_e);
                    }
                    0x6c => {
                        // bit 5,h
                        self.bit(5, self.registers.reg_h);
                    }
                    0x6d => {
                        // bit 5,l
                        self.bit(5, self.registers.reg_l);
                    }
                    0x6e => {
                        // bit 5,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(5, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    }
                    0x6f => {
                        // bit 5,a
                        self.bit(5, self.registers.reg_a);
                    }
                    0x70 => {
                        // bit 6,b
                        self.bit(6, self.registers.reg_b);
                    }
                    0x71 => {
                        // bit 6,c
                        self.bit(6, self.registers.reg_c);
                    }
                    0x72 => {
                        // bit 6,d
                        self.bit(6, self.registers.reg_d);
                    }
                    0x73 => {
                        // bit 6,e
                        self.bit(6, self.registers.reg_e);
                    }
                    0x74 => {
                        // bit 6,h
                        self.bit(6, self.registers.reg_h);
                    }
                    0x75 => {
                        // bit 6,l
                        self.bit(6, self.registers.reg_l);
                    }
                    0x76 => {
                        // bit 6,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(6, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    }
                    0x77 => {
                        // bit 6,a
                        self.bit(6, self.registers.reg_a);
                    }
                    0x78 => {
                        // bit 7,b
                        self.bit(7, self.registers.reg_b);
                    }
                    0x79 => {
                        // bit 7,c
                        self.bit(7, self.registers.reg_c);
                    }
                    0x7a => {
                        // bit 7,d
                        self.bit(7, self.registers.reg_d);
                    }
                    0x7b => {
                        // bit 7,e
                        self.bit(7, self.registers.reg_e);
                    }
                    0x7c => {
                        // bit 7,h
                        self.bit(7, self.registers.reg_h);
                    }
                    0x7d => {
                        // bit 7,l
                        self.bit(7, self.registers.reg_l);
                    }
                    0x7e => {
                        // bit 7,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(7, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    }
                    0x7f => {
                        // bit 7,a
                        self.bit(7, self.registers.reg_a);
                    }
                    0x80 => {
                        // res 0,b
                        self.registers.reg_b &= 0xfe;
                    }
                    0x81 => {
                        // res 0,c
                        self.registers.reg_c &= 0xfe;
                    }
                    0x82 => {
                        // res 0,d
                        self.registers.reg_d &= 0xfe;
                    }
                    0x83 => {
                        // res 0,e
                        self.registers.reg_e &= 0xfe;
                    }
                    0x84 => {
                        // res 0,h
                        self.registers.reg_h &= 0xfe;
                    }
                    0x85 => {
                        // res 0,l
                        self.registers.reg_l &= 0xfe;
                    }
                    0x86 => {
                        // res 0,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xfe);
                    }
                    0x87 => {
                        // res 0,a
                        self.registers.reg_a &= 0xfe;
                    }
                    0x88 => {
                        // res 1,b
                        self.registers.reg_b &= 0xfd;
                    }
                    0x89 => {
                        // res 1,c
                        self.registers.reg_c &= 0xfd;
                    }
                    0x8a => {
                        // res 1,d
                        self.registers.reg_d &= 0xfd;
                    }
                    0x8b => {
                        // res 1,e
                        self.registers.reg_e &= 0xfd;
                    }
                    0x8c => {
                        // res 1,h
                        self.registers.reg_h &= 0xfd;
                    }
                    0x8d => {
                        // res 1,l
                        self.registers.reg_l &= 0xfd;
                    }
                    0x8e => {
                        // res 1,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xfd);
                    }
                    0x8f => {
                        // res 1,a
                        self.registers.reg_a &= 0xfd;
                    }
                    0x90 => {
                        // res 2,b
                        self.registers.reg_b &= 0xfb;
                    }
                    0x91 => {
                        // res 2,c
                        self.registers.reg_c &= 0xfb;
                    }
                    0x92 => {
                        // res 2,d
                        self.registers.reg_d &= 0xfb;
                    }
                    0x93 => {
                        // res 2,e
                        self.registers.reg_e &= 0xfb;
                    }
                    0x94 => {
                        // res 2,h
                        self.registers.reg_h &= 0xfb;
                    }
                    0x95 => {
                        // res 2,l
                        self.registers.reg_l &= 0xfb;
                    }
                    0x96 => {
                        // res 2,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xfb);
                    }
                    0x97 => {
                        // res 2,a
                        self.registers.reg_a &= 0xfb;
                    }
                    0x98 => {
                        // res 3,b
                        self.registers.reg_b &= 0xf7;
                    }
                    0x99 => {
                        // res 3,c
                        self.registers.reg_c &= 0xf7;
                    }
                    0x9a => {
                        // res 3,d
                        self.registers.reg_d &= 0xf7;
                    }
                    0x9b => {
                        // res 3,e
                        self.registers.reg_e &= 0xf7;
                    }
                    0x9c => {
                        // res 3,h
                        self.registers.reg_h &= 0xf7;
                    }
                    0x9d => {
                        // res 3,l
                        self.registers.reg_l &= 0xf7;
                    }
                    0x9e => {
                        // res 3,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xf7);
                    }
                    0x9f => {
                        // res 3,a
                        self.registers.reg_a &= 0xf7;
                    }
                    0xa0 => {
                        // res 4,b
                        self.registers.reg_b &= 0xef;
                    }
                    0xa1 => {
                        // res 4,c
                        self.registers.reg_c &= 0xef;
                    }
                    0xa2 => {
                        // res 4,d
                        self.registers.reg_d &= 0xef;
                    }
                    0xa3 => {
                        // res 4,e
                        self.registers.reg_e &= 0xef;
                    }
                    0xa4 => {
                        // res 4,h
                        self.registers.reg_h &= 0xef;
                    }
                    0xa5 => {
                        // res 4,l
                        self.registers.reg_l &= 0xef;
                    }
                    0xa6 => {
                        // res 4,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xef);
                    }
                    0xa7 => {
                        // res 4,a
                        self.registers.reg_a &= 0xef;
                    }
                    0xa8 => {
                        // res 5,b
                        self.registers.reg_b &= 0xdf;
                    }
                    0xa9 => {
                        // res 5,c
                        self.registers.reg_c &= 0xdf;
                    }
                    0xaa => {
                        // res 5,d
                        self.registers.reg_d &= 0xdf;
                    }
                    0xab => {
                        // res 5,e
                        self.registers.reg_e &= 0xdf;
                    }
                    0xac => {
                        // res 5,h
                        self.registers.reg_h &= 0xdf;
                    }
                    0xad => {
                        // res 5,l
                        self.registers.reg_l &= 0xdf;
                    }
                    0xae => {
                        // res 5,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xdf);
                    }
                    0xaf => {
                        // res 5,a
                        self.registers.reg_a &= 0xdf;
                    }
                    0xb0 => {
                        // res 6,b
                        self.registers.reg_b &= 0xbf;
                    }
                    0xb1 => {
                        // res 6,c
                        self.registers.reg_c &= 0xbf;
                    }
                    0xb2 => {
                        // res 6,d
                        self.registers.reg_d &= 0xbf;
                    }
                    0xb3 => {
                        // res 6,e
                        self.registers.reg_e &= 0xbf;
                    }
                    0xb4 => {
                        // res 6,h
                        self.registers.reg_h &= 0xbf;
                    }
                    0xb5 => {
                        // res 6,l
                        self.registers.reg_l &= 0xbf;
                    }
                    0xb6 => {
                        // res 6,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xbf);
                    }
                    0xb7 => {
                        // res 6,a
                        self.registers.reg_a &= 0xbf;
                    }
                    0xb8 => {
                        // res 7,b
                        self.registers.reg_b &= 0x7f;
                    }
                    0xb9 => {
                        // res 7,c
                        self.registers.reg_c &= 0x7f;
                    }
                    0xba => {
                        // res 7,d
                        self.registers.reg_d &= 0x7f;
                    }
                    0xbb => {
                        // res 7,e
                        self.registers.reg_e &= 0x7f;
                    }
                    0xbc => {
                        // res 7,h
                        self.registers.reg_h &= 0x7f;
                    }
                    0xbd => {
                        // res 7,l
                        self.registers.reg_l &= 0x7f;
                    }
                    0xbe => {
                        // res 7,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0x7f);
                    }
                    0xbf => {
                        // res 7,a
                        self.registers.reg_a &= 0x7f;
                    }
                    0xc0 => {
                        // set 0,b
                        self.registers.reg_b |= 0x01;
                    }
                    0xc1 => {
                        // set 0,c
                        self.registers.reg_c |= 0x01;
                    }
                    0xc2 => {
                        // set 0,d
                        self.registers.reg_d |= 0x01;
                    }
                    0xc3 => {
                        // set 0,e
                        self.registers.reg_e |= 0x01;
                    }
                    0xc4 => {
                        // set 0,h
                        self.registers.reg_h |= 0x01;
                    }
                    0xc5 => {
                        // set 0,l
                        self.registers.reg_l |= 0x01;
                    }
                    0xc6 => {
                        // set 0,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x01);
                    }
                    0xc7 => {
                        // set 0,a
                        self.registers.reg_a |= 0x01;
                    }
                    0xc8 => {
                        // set 1,b
                        self.registers.reg_b |= 0x02;
                    }
                    0xc9 => {
                        // set 1,c
                        self.registers.reg_c |= 0x02;
                    }
                    0xca => {
                        // set 1,d
                        self.registers.reg_d |= 0x02;
                    }
                    0xcb => {
                        // set 1,e
                        self.registers.reg_e |= 0x02;
                    }
                    0xcc => {
                        // set 1,h
                        self.registers.reg_h |= 0x02;
                    }
                    0xcd => {
                        // set 1,l
                        self.registers.reg_l |= 0x02;
                    }
                    0xce => {
                        // set 1,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x02);
                    }
                    0xcf => {
                        // set 1,a
                        self.registers.reg_a |= 0x02;
                    }
                    0xd0 => {
                        // set 2,b
                        self.registers.reg_b |= 0x04;
                    }
                    0xd1 => {
                        // set 2,c
                        self.registers.reg_c |= 0x04;
                    }
                    0xd2 => {
                        // set 2,d
                        self.registers.reg_d |= 0x04;
                    }
                    0xd3 => {
                        // set 2,e
                        self.registers.reg_e |= 0x04;
                    }
                    0xd4 => {
                        // set 2,h
                        self.registers.reg_h |= 0x04;
                    }
                    0xd5 => {
                        // set 2,l
                        self.registers.reg_l |= 0x04;
                    }
                    0xd6 => {
                        // set 2,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x04);
                    }
                    0xd7 => {
                        // set 2,a
                        self.registers.reg_a |= 0x04;
                    }
                    0xd8 => {
                        // set 3,b
                        self.registers.reg_b |= 0x08;
                    }
                    0xd9 => {
                        // set 3,c
                        self.registers.reg_c |= 0x08;
                    }
                    0xda => {
                        // set 3,d
                        self.registers.reg_d |= 0x08;
                    }
                    0xdb => {
                        // set 3,e
                        self.registers.reg_e |= 0x08;
                    }
                    0xdc => {
                        // set 3,h
                        self.registers.reg_h |= 0x08;
                    }
                    0xdd => {
                        // set 3,l
                        self.registers.reg_l |= 0x08;
                    }
                    0xde => {
                        // set 3,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x08);
                    }
                    0xdf => {
                        // set 3,a
                        self.registers.reg_a |= 0x08;
                    }
                    0xe0 => {
                        // set 4,b
                        self.registers.reg_b |= 0x10;
                    }
                    0xe1 => {
                        // set 4,c
                        self.registers.reg_c |= 0x10;
                    }
                    0xe2 => {
                        // set 4,d
                        self.registers.reg_d |= 0x10;
                    }
                    0xe3 => {
                        // set 4,e
                        self.registers.reg_e |= 0x10;
                    }
                    0xe4 => {
                        // set 4,h
                        self.registers.reg_h |= 0x10;
                    }
                    0xe5 => {
                        // set 4,l
                        self.registers.reg_l |= 0x10;
                    }
                    0xe6 => {
                        // set 4,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x10);
                    }
                    0xe7 => {
                        // set 4,a
                        self.registers.reg_a |= 0x10;
                    }
                    0xe8 => {
                        // set 5,b
                        self.registers.reg_b |= 0x20;
                    }
                    0xe9 => {
                        // set 5,c
                        self.registers.reg_c |= 0x20;
                    }
                    0xea => {
                        // set 5,d
                        self.registers.reg_d |= 0x20;
                    }
                    0xeb => {
                        // set 5,e
                        self.registers.reg_e |= 0x20;
                    }
                    0xec => {
                        // set 5,h
                        self.registers.reg_h |= 0x20;
                    }
                    0xed => {
                        // set 5,l
                        self.registers.reg_l |= 0x20;
                    }
                    0xee => {
                        // set 5,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x20);
                    }
                    0xef => {
                        // set 5,a
                        self.registers.reg_a |= 0x20;
                    }
                    0xf0 => {
                        // set 6,b
                        self.registers.reg_b |= 0x40;
                    }
                    0xf1 => {
                        // set 6,c
                        self.registers.reg_c |= 0x40;
                    }
                    0xf2 => {
                        // set 6,d
                        self.registers.reg_d |= 0x40;
                    }
                    0xf3 => {
                        // set 6,e
                        self.registers.reg_e |= 0x40;
                    }
                    0xf4 => {
                        // set 6,h
                        self.registers.reg_h |= 0x40;
                    }
                    0xf5 => {
                        // set 6,l
                        self.registers.reg_l |= 0x40;
                    }
                    0xf6 => {
                        // set 6,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x40);
                    }
                    0xf7 => {
                        // set 6,a
                        self.registers.reg_a |= 0x40;
                    }
                    0xf8 => {
                        // set 7,b
                        self.registers.reg_b |= 0x80;
                    }
                    0xf9 => {
                        // set 7,c
                        self.registers.reg_c |= 0x80;
                    }
                    0xfa => {
                        // set 7,d
                        self.registers.reg_d |= 0x80;
                    }
                    0xfb => {
                        // set 7,e
                        self.registers.reg_e |= 0x80;
                    }
                    0xfc => {
                        // set 7,h
                        self.registers.reg_h |= 0x80;
                    }
                    0xfd => {
                        // set 7,l
                        self.registers.reg_l |= 0x80;
                    }
                    0xfe => {
                        // set 7,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x80);
                    }
                    0xff => {
                        // set 7,a
                        self.registers.reg_a |= 0x80;
                    }
                }
            }
            0xcc => {
                // call z,nn
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                if self.registers.reg_f.z {
                    self.push_stack(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2
                }
            }
            0xcd => {
                // call nn
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                self.push_stack(self.registers.reg_pc + 2);
                self.registers.reg_pc = nn;
            }
            0xce => {
                // adc a,n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.adc(n);
                self.registers.reg_pc += 1;
            }
            0xcf => {
                // rst 8h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0008;
            }
            0xd0 => {
                // ret nc
                if !self.registers.reg_f.c {
                    self.pop_stack();
                }
            }
            0xd1 => {
                // pop de
                self.registers
                    .set_de(self.bus.read_mem_u16(self.registers.reg_sp));
                self.registers.reg_sp += 2;
            }
            0xd2 => {
                // jp nc,$+3
                if !self.registers.reg_f.c {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xd3 => {
                // out (n),a
                let n = self.bus.read_mem(self.registers.reg_pc);
                let a = (self.registers.reg_a as u16) << 8;
                self.bus.write_io(n as u16 | a, self.registers.reg_a);
                self.registers.reg_pc += 1;
            }
            0xd4 => {
                // call nc,nn
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                if !self.registers.reg_f.c {
                    self.push_stack(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xd5 => {
                // push de
                self.registers.reg_sp -= 2;
                self.bus
                    .write_mem_u16(self.registers.reg_sp, self.registers.get_de());
            }
            0xd6 => {
                // sub n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.sub(n);
                self.registers.reg_pc += 1;
            }
            0xd7 => {
                // rst 10h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0010;
            }
            0xd8 => {
                // ret c
                if self.registers.reg_f.c {
                    self.pop_stack();
                }
            }
            0xd9 => {
                //
                let bc = self.registers.get_bc();
                let de = self.registers.get_de();
                let hl = self.registers.get_hl();
                let abc = self.alternate.get_bc();
                let ade = self.alternate.get_de();
                let ahl = self.alternate.get_hl();
                self.registers.set_bc(abc);
                self.registers.set_de(ade);
                self.registers.set_hl(ahl);
                self.alternate.set_bc(bc);
                self.alternate.set_de(de);
                self.alternate.set_hl(hl);
            }
            0xda => {
                // jp c,$+3
                if self.registers.reg_f.c {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xdb => {
                // in a,(n)
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_a = self
                    .bus
                    .read_io((n as u16) | (self.registers.reg_a as u16) << 8);
                self.registers.reg_pc += 1;
            }
            0xdc => {
                // call c,nn
                if self.registers.reg_f.c {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.push_stack(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xdd => {
                let opcode = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_pc += 1;
                match opcode {
                    0x09 => {
                        // add ix,bc
                        let bc = self.registers.get_bc();
                        let ix = self.registers.get_ix();
                        let value = self.add16(ix, bc);
                        self.registers.set_ix(value);
                    }
                    0x19 => {
                        // add ix,de
                        let de = self.registers.get_de();
                        let ix = self.registers.get_ix();
                        let value = self.add16(ix, de);
                        self.registers.set_ix(value);
                    }
                    0x21 => {
                        // ld ix,nn
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        self.registers.set_ix(nn);
                        self.registers.reg_pc += 2;
                    }
                    0x22 => {
                        // ld (nn),ix
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        self.bus.write_mem_u16(nn, self.registers.get_ix());
                        self.registers.reg_pc += 2;
                    }
                    0x23 => {
                        // inc ix
                        let ix = self.registers.get_ix().wrapping_add(1);
                        self.registers.set_ix(ix);
                    }
                    0x29 => {
                        // add ix,ix
                        let ix = self.registers.get_ix();
                        let value = self.add16(ix, ix);
                        self.registers.set_ix(value);
                    }
                    0x2a => {
                        // ld ix,(nn)
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        let n = self.bus.read_mem_u16(nn);
                        self.registers.set_ix(n);
                        self.registers.reg_pc += 2;
                    }
                    0x2b => {
                        // dec ix
                        let ix = self.registers.get_ix().wrapping_sub(1);
                        self.registers.set_ix(ix);
                    }
                    0x34 => {
                        // inc (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let ix = self.registers.get_ix();
                        let value = self.inc(self.bus.read_mem(ix + n as u16));
                        self.bus.write_mem(ix + n as u16, value);
                        self.registers.reg_pc += 1;
                    }
                    0x35 => {
                        // dec (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let ix = self.registers.get_ix();
                        let value = self.dec(self.bus.read_mem(ix + n as u16));
                        self.bus.write_mem(ix + n as u16, value);
                        self.registers.reg_pc += 1;
                    }
                    0x36 => {
                        // ld (ix+n),n
                        let ixn = self.bus.read_mem(self.registers.reg_pc);
                        let n = self.bus.read_mem(self.registers.reg_pc + 1);
                        self.bus.write_mem(self.registers.get_ix() + ixn as u16, n);
                        self.registers.reg_pc += 2;
                    }
                    0x39 => {
                        // add ix,sp
                        let sp = self.registers.get_sp();
                        let ix = self.registers.get_ix();
                        let value = self.add16(ix, sp);
                        self.registers.set_ix(value);
                    }
                    0x46 => {
                        // ld b,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_b =
                            self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.registers.reg_pc += 1;
                    }
                    0x4e => {
                        // ld c,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_c =
                            self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.registers.reg_pc += 1;
                    }
                    0x56 => {
                        // ld d,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_d =
                            self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.registers.reg_pc += 1;
                    }
                    0x5e => {
                        // ld e,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_e =
                            self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.registers.reg_pc += 1;
                    }
                    0x66 => {
                        // ld h,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_h =
                            self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.registers.reg_pc += 1;
                    }
                    0x6e => {
                        // ld l,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_l =
                            self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.registers.reg_pc += 1;
                    }
                    0x70 => {
                        // ld (ix+n),b
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.bus
                            .write_mem(self.registers.get_ix() + n as u16, self.registers.reg_b);
                        self.registers.reg_pc += 1;
                    }
                    0x71 => {
                        // ld (ix+n),c
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.bus
                            .write_mem(self.registers.get_ix() + n as u16, self.registers.reg_c);
                        self.registers.reg_pc += 1;
                    }
                    0x72 => {
                        // ld (ix+n),d
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.bus
                            .write_mem(self.registers.get_ix() + n as u16, self.registers.reg_d);
                        self.registers.reg_pc += 1;
                    }
                    0x73 => {
                        // ld (ix+n),e
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.bus
                            .write_mem(self.registers.get_ix() + n as u16, self.registers.reg_e);
                        self.registers.reg_pc += 1;
                    }
                    0x74 => {
                        // ld (ix+n),h
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.bus
                            .write_mem(self.registers.get_ix() + n as u16, self.registers.reg_h);
                        self.registers.reg_pc += 1;
                    }
                    0x75 => {
                        // ld (ix+n),l
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.bus
                            .write_mem(self.registers.get_ix() + n as u16, self.registers.reg_l);
                        self.registers.reg_pc += 1;
                    }
                    0x77 => {
                        // ld (ix+n),a
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.bus
                            .write_mem(self.registers.get_ix() + n as u16, self.registers.reg_a);
                        self.registers.reg_pc += 1;
                    }
                    0x7e => {
                        // ld a,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_a =
                            self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.registers.reg_pc += 1;
                    }
                    0x86 => {
                        // add a,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.add(value);
                        self.registers.reg_pc += 1;
                    }
                    0x8e => {
                        // adc a,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.adc(value);
                        self.registers.reg_pc += 1;
                    }
                    0x96 => {
                        // sub (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.sub(value);
                        self.registers.reg_pc += 1;
                    }
                    0x9e => {
                        // sbc a,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.sbc(value);
                        self.registers.reg_pc += 1;
                    }
                    0xa6 => {
                        // and (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let ix = self.registers.get_ix();
                        self.and(Type::Direct(ix + n as u16));
                        self.registers.reg_pc += 1;
                    }
                    0xae => {
                        // xor (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let ix = self.registers.get_ix();
                        self.xor(Type::Direct(ix + n as u16));
                        self.registers.reg_pc += 1;
                    }
                    0xb6 => {
                        // or (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let ix = self.registers.get_ix();
                        self.or(Type::Direct(ix + n as u16));
                        self.registers.reg_pc += 1;
                    }
                    0xbe => {
                        // cp (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.cp(value);
                        self.registers.reg_pc += 1;
                    }
                    0xcb => {
                        let opcode = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_pc += 1;
                        match opcode {
                            0x06 => {
                                // rlc (ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let ix = self.registers.get_ix();
                                self.rlc(Type::Direct(ix + n as u16));
                                self.registers.reg_pc += 1;
                            }
                            0x0e => {
                                // rrc (ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let ix = self.registers.get_ix();
                                self.rrc(Type::Direct(ix + n as u16));
                                self.registers.reg_pc += 1;
                            }
                            0x16 => {
                                // rl (ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let ix = self.registers.get_ix();
                                self.rl(Type::Direct(ix + n as u16));
                                self.registers.reg_pc += 1;
                            }
                            0x1e => {
                                // rr (ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let ix = self.registers.get_ix();
                                self.rr(Type::Direct(ix + n as u16));
                                self.registers.reg_pc += 1;
                            }
                            0x26 => {
                                // sla (ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let ix = self.registers.get_ix();
                                self.sla(Type::Direct(ix + n as u16));
                                self.registers.reg_pc += 1;
                            }
                            0x2e => {
                                // sra (ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let ix = self.registers.get_ix();
                                self.sra(Type::Direct(ix + n as u16));
                                self.registers.reg_pc += 1;
                            }
                            0x46 => {
                                // bit 0,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(0, value);
                                self.registers.reg_pc += 1;
                            }
                            0x4e => {
                                // bit 1,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(1, value);
                                self.registers.reg_pc += 1;
                            }
                            0x56 => {
                                // bit 2,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(2, value);
                                self.registers.reg_pc += 1;
                            }
                            0x5e => {
                                // bit 3,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(3, value);
                                self.registers.reg_pc += 1;
                            }
                            0x66 => {
                                // bit 4,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(4, value);
                                self.registers.reg_pc += 1;
                            }
                            0x6e => {
                                // bit 5,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(5, value);
                                self.registers.reg_pc += 1;
                            }
                            0x76 => {
                                // bit 6,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(6, value);
                                self.registers.reg_pc += 1;
                            }
                            0x7e => {
                                // bit 7,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(7, value);
                                self.registers.reg_pc += 1;
                            }
                            0x86 => {
                                // res 0,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(0, value);
                                self.registers.reg_pc += 1;
                            }
                            0x8e => {
                                // res 1,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(1, value);
                                self.registers.reg_pc += 1;
                            }
                            0x96 => {
                                // res 2,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(2, value);
                                self.registers.reg_pc += 1;
                            }
                            0x9e => {
                                // res 3,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(3, value);
                                self.registers.reg_pc += 1;
                            }
                            0xa6 => {
                                // res 4,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(4, value);
                                self.registers.reg_pc += 1;
                            }
                            0xae => {
                                // res 5,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(5, value);
                                self.registers.reg_pc += 1;
                            }
                            0xb6 => {
                                // res 6,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(6, value);
                                self.registers.reg_pc += 1;
                            }
                            0xbe => {
                                // res 7,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(7, value);
                                self.registers.reg_pc += 1;
                            }
                            0xc6 => {
                                // set 0,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus
                                    .write_mem(self.registers.get_ix() + n as u16, value | 0x01);
                                self.registers.reg_pc += 1;
                            }
                            0xce => {
                                // set 1,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus
                                    .write_mem(self.registers.get_ix() + n as u16, value | 0x02);
                                self.registers.reg_pc += 1;
                            }
                            0xd6 => {
                                // set 2,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus
                                    .write_mem(self.registers.get_ix() + n as u16, value | 0x04);
                                self.registers.reg_pc += 1;
                            }
                            0xde => {
                                // set 3,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus
                                    .write_mem(self.registers.get_ix() + n as u16, value | 0x08);
                                self.registers.reg_pc += 1;
                            }
                            0xe6 => {
                                // set 4,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus
                                    .write_mem(self.registers.get_ix() + n as u16, value | 0x10);
                                self.registers.reg_pc += 1;
                            }
                            0xee => {
                                // set 5,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus
                                    .write_mem(self.registers.get_ix() + n as u16, value | 0x20);
                                self.registers.reg_pc += 1;
                            }
                            0xf6 => {
                                // set 6,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus
                                    .write_mem(self.registers.get_ix() + n as u16, value | 0x40);
                                self.registers.reg_pc += 1;
                            }
                            0xfe => {
                                // set 7,(ix+n)
                                let n = self.bus.read_mem(self.registers.reg_pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus
                                    .write_mem(self.registers.get_ix() + n as u16, value | 0x80);
                                self.registers.reg_pc += 1;
                            }
                            _ => {
                                // Illegal opcode
                                panic!("Illegal opcode {:x}", self.registers.reg_pc);
                            }
                        }
                    }
                    0xe1 => {
                        // pop ix
                        self.registers
                            .set_ix(self.bus.read_mem_u16(self.registers.reg_sp));
                        self.registers.reg_sp += 2;
                    }
                    0xe3 => {
                        // ex (sp),ix
                        let sp = self.bus.read_mem_u16(self.registers.reg_sp);
                        self.bus
                            .write_mem_u16(self.registers.reg_sp, self.registers.get_ix());
                        self.registers.set_ix(sp);
                    }
                    0xe5 => {
                        // push ix
                        self.registers.reg_sp -= 2;
                        self.bus
                            .write_mem_u16(self.registers.reg_sp, self.registers.get_ix());
                    }
                    0xe9 => {
                        // jp (ix)
                        let ix = self.bus.read_mem_u16(self.registers.get_ix());
                        self.registers.reg_pc = ix;
                    }
                    0xf9 => {
                        // ld sp,ix
                        self.registers.reg_sp = self.registers.get_ix();
                    }
                    _ => {
                        // Illegal opcode
                        panic!("Illegal opcode {:x}", self.registers.reg_pc);
                    }
                }
            }
            0xde => {
                // sbc a,n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.sbc(n);
            }
            0xdf => {
                // rst 18h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0018;
            }
            0xe0 => {
                // ret po
                if !self.registers.reg_f.p {
                    self.pop_stack();
                }
            }
            0xe1 => {
                // pop hl
                self.registers
                    .set_hl(self.bus.read_mem_u16(self.registers.reg_sp));
                self.registers.reg_sp += 2;
            }
            0xe2 => {
                // jp po,$+3
                if !self.registers.reg_f.p {
                    let value = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = value;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xe3 => {
                // ex (sp),hl
                let sp = self.bus.read_mem_u16(self.registers.reg_sp);
                self.bus
                    .write_mem_u16(self.registers.reg_sp, self.registers.get_hl());
                self.registers.set_hl(sp);
            }
            0xe4 => {
                // call po,nn
                if !self.registers.reg_f.p {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xe5 => {
                // push hl
                self.registers.reg_sp -= 2;
                self.bus
                    .write_mem_u16(self.registers.reg_sp, self.registers.get_hl());
            }
            0xe6 => {
                // and n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.and(Type::Immediate(n));
                self.registers.reg_pc += 1;
            }
            0xe7 => {
                // rst 20h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0020;
            }
            0xe8 => {
                // ret pe
                if self.registers.reg_f.p {
                    self.pop_stack();
                }
            }
            0xe9 => {
                // jp (hl)
                let hl = self.bus.read_mem_u16(self.registers.get_hl());
                self.registers.reg_pc = hl;
            }
            0xea => {
                // jp pe,$+3
                if self.registers.reg_f.p {
                    let value = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = value;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xeb => {
                // ex de,hl
                let hl = self.registers.get_hl();
                let de = self.registers.get_de();
                self.registers.set_hl(de);
                self.registers.set_de(hl);
            }
            0xec => {
                // call pe,nn
                if self.registers.reg_f.p {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xed => {
                let opcode = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_pc += 1;
                match opcode {
                    0x40 => {
                        // in b,(c)
                        self.registers.reg_b = self.bus.read_io(self.registers.get_bc());
                    }
                    0x41 => {
                        // out (c),b
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_b);
                    }
                    0x42 => {
                        // sbc hl,bc
                        let bc = self.registers.get_bc();
                        self.sbc16(bc);
                    }
                    0x43 => {
                        // ld (nn),bc
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        self.bus.write_mem_u16(nn, self.registers.get_bc());
                        self.registers.reg_pc += 2;
                    }
                    0x44 => {
                        // neg
                        let a = 0x100 - self.registers.reg_a as u16;
                        self.registers.reg_f.z = a == 0;
                        self.registers.reg_f.s = (a as i8) < 0;
                        self.registers.reg_f.p = a == 0x80;
                        self.registers.reg_f.c = a == 0;
                        self.registers.reg_a = a as u8;
                    }
                    0x45 => {
                        // retn
                        self.iff1 = self.iff2;
                        self.pop_stack();
                    }
                    0x46 => {
                        // im 0
                        self.im = 0;
                    }
                    0x47 => {
                        // ld i,a
                        self.registers.reg_i = self.registers.reg_a;
                    }
                    0x48 => {
                        // in c,(c)
                        self.registers.reg_c = self.bus.read_io(self.registers.get_bc());
                    }
                    0x49 => {
                        // out (c),c
                        // TODO: Implement
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_c);
                    }
                    0x4a => {
                        // adc hl,bc
                        let hl = self.registers.get_hl();
                        let bc = self.registers.get_bc();
                        let value = self.adc16(hl, bc);
                        self.registers.set_hl(value);
                    }
                    0x4b => {
                        // ld bc,(nn)
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        let n = self.bus.read_mem_u16(nn);
                        self.registers.set_bc(n);
                        self.registers.reg_pc += 2;
                    }
                    0x4d => {
                        // reti
                        self.pop_stack();
                    }
                    0x4f => {
                        // ld r,a
                        self.registers.reg_r = self.registers.reg_a;
                    }
                    0x50 => {
                        // in d,(c)
                        self.registers.reg_d = self.bus.read_io(self.registers.get_bc());
                    }
                    0x51 => {
                        // out (c),d
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_d);
                    }
                    0x52 => {
                        // sbc hl,de
                        let de = self.registers.get_de();
                        self.sbc16(de);
                    }
                    0x53 => {
                        // ld (nn),de
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        self.bus.write_mem_u16(nn, self.registers.get_de());
                        self.registers.reg_pc += 2;
                    }
                    0x56 => {
                        // im 1
                        self.im = 1;
                    }
                    0x57 => {
                        // ld a,i
                        self.registers.reg_a = self.registers.reg_i;
                        self.registers.reg_f.z = self.registers.reg_i == 0;
                        self.registers.reg_f.s = (self.registers.reg_i as i8) < 0;
                        self.registers.reg_f.p = self.iff2;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.h = false;
                    }
                    0x58 => {
                        // in e,(c)
                        self.registers.reg_e = self.bus.read_io(self.registers.get_bc());
                    }
                    0x59 => {
                        // out (c),e
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_e);
                    }
                    0x5a => {
                        // adc hl,de
                        let hl = self.registers.get_hl();
                        let de = self.registers.get_de();
                        let value = self.adc16(hl, de);
                        self.registers.set_hl(value);
                    }
                    0x5b => {
                        // ld de,(nn)
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        let n = self.bus.read_mem_u16(nn);
                        self.registers.set_de(n);
                        self.registers.reg_pc += 2;
                    }
                    0x5e => {
                        // im 2
                        self.im = 2;
                    }
                    0x5f => {
                        // ld a,r
                        self.registers.reg_a = self.registers.reg_r;
                        self.registers.reg_f.z = self.registers.reg_r == 0;
                        self.registers.reg_f.s = (self.registers.reg_r as i8) < 0;
                        self.registers.reg_f.p = self.iff2;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.h = false;
                    }
                    0x60 => {
                        // in h,(c)
                        self.registers.reg_h = self.bus.read_io(self.registers.get_bc());
                    }
                    0x61 => {
                        // out (c),h
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_h);
                    }
                    0x62 => {
                        // sbc hl,hl
                        let hl = self.registers.get_hl();
                        self.sbc16(hl);
                    }
                    0x67 => {
                        // rrd
                        let value = self.bus.read_mem(self.registers.get_hl());
                        let a = self.registers.reg_a;
                        self.registers.reg_a = (a & 0xf0) | (value & 0x0f);
                        self.bus
                            .write_mem(self.registers.get_hl(), (a << 4) | (value >> 4));
                    }
                    0x68 => {
                        // in l,(c)
                        self.registers.reg_l = self.bus.read_io(self.registers.get_bc());
                    }
                    0x69 => {
                        // out (c),l
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_l);
                    }
                    0x6a => {
                        // adc hl,hl
                        let hl = self.registers.get_hl();
                        let value = self.adc16(hl, hl);
                        self.registers.set_hl(value);
                    }
                    0x6f => {
                        // rld
                        let value = self.bus.read_mem(self.registers.get_hl());
                        let a = self.registers.reg_a;
                        self.registers.reg_a = (value >> 4) | (a & 0xf0);
                        self.bus
                            .write_mem(self.registers.get_hl(), (value << 4) | (a & 0x0f));
                    }
                    0x72 => {
                        // sbc hl,sp
                        let sp = self.registers.get_sp();
                        self.sbc16(sp);
                    }
                    0x73 => {
                        // ld (nn),sp
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        self.bus.write_mem_u16(nn, self.registers.get_sp());
                        self.registers.reg_pc += 2;
                    }
                    0x78 => {
                        // in a,(c)
                        self.registers.reg_a = self.bus.read_io(self.registers.get_bc());
                    }
                    0x79 => {
                        // out (c),a
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_a);
                    }
                    0x7a => {
                        // adc hl,sp
                        let hl = self.registers.get_hl();
                        let sp = self.registers.get_sp();
                        let value = self.adc16(hl, sp);
                        self.registers.set_hl(value);
                    }
                    0x7b => {
                        // ld sp,(nn)
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        let n = self.bus.read_mem_u16(nn);
                        self.registers.set_sp(n);
                        self.registers.reg_pc += 2;
                    }
                    0xa0 => {
                        // ldi
                        let hl = self.registers.get_hl();
                        let de = self.registers.get_de();
                        let bc = self.registers.get_bc();
                        let value = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_de(), value);
                        self.registers.set_hl(hl.wrapping_add(1));
                        self.registers.set_de(de.wrapping_add(1));
                        self.registers.set_bc(bc.wrapping_sub(1));
                        self.registers.reg_f.h = false;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.p = bc.wrapping_sub(1) != 0;
                    }
                    0xa1 => {
                        // cpi
                        self.cpi();
                    }
                    0xa2 => { // ini
                         // TODO: Implement input
                    }
                    0xa3 => { // outi
                         // TODO: Implement output
                    }
                    0xa8 => {
                        // ldd
                        let hl = self.registers.get_hl();
                        let de = self.registers.get_de();
                        let bc = self.registers.get_bc();
                        let value = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_de(), value);
                        self.registers.set_hl(hl.wrapping_sub(1));
                        self.registers.set_de(de.wrapping_sub(1));
                        self.registers.set_bc(bc.wrapping_sub(1));
                        self.registers.reg_f.h = false;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.p = bc.wrapping_sub(1) != 0;
                    }
                    0xa9 => {
                        // cpd
                        self.cpd();
                    }
                    0xaa => { // ind
                         // TODO: Implement input
                    }
                    0xab => { // outd
                         // TODO: Implement output
                    }
                    0xb0 => {
                        // ldir
                        let mut hl = self.registers.get_hl();
                        let mut de = self.registers.get_de();
                        let mut bc = self.registers.get_bc();
                        while bc != 0 {
                            let value = self.bus.read_mem(hl);
                            self.bus.write_mem(de, value);
                            hl = hl.wrapping_add(1);
                            de = de.wrapping_add(1);
                            bc = bc.wrapping_sub(1);
                        }
                        self.registers.reg_f.h = false;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.p = bc != 0;
                    }
                    0xb1 => {
                        // cpir
                        while self.registers.get_bc() > 0 {
                            self.cpi();
                            if self.registers.reg_f.z {
                                break;
                            }
                        }
                    }
                    0xb2 => { // inir
                         // TODO: Implement input
                    }
                    0xb3 => { // otir
                         // TODO: Implement output
                    }
                    0xb8 => {
                        // lddr
                        let mut hl = self.registers.get_hl();
                        let mut de = self.registers.get_de();
                        let mut bc = self.registers.get_bc();
                        while bc > 0 {
                            let value = self.bus.read_mem(hl);
                            self.bus.write_mem(de, value);
                            hl = hl.wrapping_sub(1);
                            de = de.wrapping_sub(1);
                            bc = bc.wrapping_sub(1);
                        }
                    }
                    0xb9 => {
                        // cpdr
                        while self.registers.get_bc() > 0 {
                            self.cpd();
                            if self.registers.reg_f.z {
                                break;
                            }
                        }
                    }
                    0xba => { // indr
                         // TODO: Implement input
                    }
                    0xbb => { // otdr
                         // TODO: Implement output
                    }
                    _ => {
                        // Illegal opcode
                        panic!("Illegal opcode {:x}", self.registers.reg_pc);
                    }
                }
            }
            0xee => {
                // xor n
                let value = self.bus.read_mem(self.registers.reg_pc);
            }
            0xef => {
                // rst 28h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0028;
            }
            0xf0 => {
                // ret p
                if !self.registers.reg_f.s {
                    self.pop_stack();
                }
            }
            0xf1 => {
                // pop af
                self.registers.reg_f = self.bus.read_mem(self.registers.reg_sp).into();
                self.registers.reg_a = self.bus.read_mem(self.registers.reg_sp + 1);
                self.registers.reg_sp += 2;
            }
            0xf2 => {
                // jp p,$+3
                if !self.registers.reg_f.s {
                    let value = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = value;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xf3 => {
                // di
                self.interrupts_enabled = false;
                self.iff1 = false;
                self.iff2 = false;
            }
            0xf4 => {
                // call p,nn
                if !self.registers.reg_f.s {
                    let value = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.push_stack(self.registers.reg_pc);
                    self.registers.reg_pc = value;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xf5 => {
                // push af
                self.registers.reg_sp -= 2;
                self.bus
                    .write_mem(self.registers.reg_sp, self.registers.reg_f.to_byte());
                self.bus
                    .write_mem(self.registers.reg_sp + 1, self.registers.reg_a);
            }
            0xf6 => {
                // or n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.or(Type::Immediate(n));
                self.registers.reg_pc += 1;
            }
            0xf7 => {
                // rst 30h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0030;
            }
            0xf8 => {
                // ret m
                if self.registers.reg_f.s {
                    self.pop_stack();
                }
            }
            0xf9 => {
                // ld sp,hl
                let hl = self.registers.get_hl();
                self.registers.set_sp(hl);
            }
            0xfa => {
                // jp m,$+3
                if self.registers.reg_f.s {
                    let value = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = value;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xfb => {
                // ei
                self.interrupts_enabled = true;
                self.iff1 = true;
                self.iff2 = true;
            }
            0xfc => {
                // call m,nn
                if self.registers.reg_f.s {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.push_stack(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xfd => {
                let opcode = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_pc += 1;
                match opcode {
                    0x09 => {
                        // add iy,bc
                        let bc = self.registers.get_bc();
                        let iy = self.registers.get_iy();
                        let value = self.add16(iy, bc);
                        self.registers.set_iy(value);
                    }
                    0x19 => {
                        // add iy,de
                        let de = self.registers.get_de();
                        let iy = self.registers.get_iy();
                        let value = self.add16(iy, de);
                        self.registers.set_iy(value);
                    }
                    0x21 => {
                        // ld iy,nn
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        self.registers.set_iy(nn);
                        self.registers.reg_pc += 2;
                    }
                    0x22 => {
                        // ld (nn),iy
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        self.bus.write_mem_u16(nn, self.registers.get_iy());
                        self.registers.reg_pc += 2;
                    }
                    0x23 => {
                        // inc iy
                        let iy = self.registers.get_iy().wrapping_add(1);
                        self.registers.set_iy(iy);
                    }
                    0x29 => {
                        // add iy,iy
                        let iy = self.registers.get_iy();
                        let value = self.add16(iy, iy);
                        self.registers.set_iy(value);
                    }
                    0x2a => {
                        // ld iy,(nn)
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        let n = self.bus.read_mem_u16(nn);
                        self.registers.set_iy(n);
                        self.registers.reg_pc += 2;
                    }
                    0x2b => {
                        // dec iy
                        let iy = self.registers.get_iy().wrapping_sub(1);
                        self.registers.set_iy(iy);
                    }
                    0x34 => {
                        // inc (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.bus.write_mem(iy + n as u16, value + 1);
                        self.registers.reg_pc += 1;
                    }
                    0x35 => {
                        // dec (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.bus.write_mem(iy + n as u16, value - 1);
                        self.registers.reg_pc += 1;
                    }
                    0x36 => {
                        // ld (iy+n),n
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(self.registers.reg_pc + 1);
                        self.bus.write_mem(iy + n as u16, value);
                        self.registers.reg_pc += 2;
                    }
                    0x39 => {
                        // add iy,sp
                        let sp = self.registers.get_sp();
                        let iy = self.registers.get_iy();
                        let value = self.add16(iy, sp);
                        self.registers.set_iy(value);
                    }
                    0x46 => {
                        // ld b,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.registers.reg_b = value;
                        self.registers.reg_pc += 1;
                    }
                    0x4e => {
                        // ld c,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.registers.reg_c = value;
                        self.registers.reg_pc += 1;
                    }
                    0x56 => {
                        // ld d,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.registers.reg_d = value;
                        self.registers.reg_pc += 1;
                    }
                    0x5e => {
                        // ld e,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.registers.reg_e = value;
                        self.registers.reg_pc += 1;
                    }
                    0x66 => {
                        // ld h,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.registers.reg_h = value;
                        self.registers.reg_pc += 1;
                    }
                    0x6e => {
                        // ld l,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.registers.reg_l = value;
                        self.registers.reg_pc += 1;
                    }
                    0x70 => {
                        // ld (iy+n),b
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.bus.write_mem(iy + n as u16, self.registers.reg_b);
                        self.registers.reg_pc += 1;
                    }
                    0x71 => {
                        // ld (iy+n),c
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.bus.write_mem(iy + n as u16, self.registers.reg_c);
                        self.registers.reg_pc += 1;
                    }
                    0x72 => {
                        // ld (iy+n),d
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.bus.write_mem(iy + n as u16, self.registers.reg_d);
                        self.registers.reg_pc += 1;
                    }
                    0x73 => {
                        // ld (iy+n),e
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.bus.write_mem(iy + n as u16, self.registers.reg_e);
                        self.registers.reg_pc += 1;
                    }
                    0x74 => {
                        // ld (iy+n),h
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.bus.write_mem(iy + n as u16, self.registers.reg_h);
                        self.registers.reg_pc += 1;
                    }
                    0x75 => {
                        // ld (iy+n),l
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.bus.write_mem(iy + n as u16, self.registers.reg_l);
                        self.registers.reg_pc += 1;
                    }
                    0x77 => {
                        // ld (iy+n),a
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.bus.write_mem(iy + n as u16, self.registers.reg_a);
                        self.registers.reg_pc += 1;
                    }
                    0x7e => {
                        // ld a,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.registers.reg_a = value;
                        self.registers.reg_pc += 1;
                    }
                    0x86 => {
                        // add a,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.add(value);
                        self.registers.reg_pc += 1;
                    }
                    0x8e => {
                        // adc a,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.adc(value);
                        self.registers.reg_pc += 1;
                    }
                    0x96 => {
                        // sub (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.sub(value);
                        self.registers.reg_pc += 1;
                    }
                    0x9e => {
                        // sbc a,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.sbc(value);
                        self.registers.reg_pc += 1;
                    }
                    0xa6 => {
                        // and (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.and(Type::Direct(iy + n as u16));
                        self.registers.reg_pc += 1;
                    }
                    0xae => {
                        // xor (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.xor(Type::Direct(iy + n as u16));
                        self.registers.reg_pc += 1;
                    }
                    0xb6 => {
                        // or (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        self.or(Type::Direct(iy + n as u16));
                        self.registers.reg_pc += 1;
                    }
                    0xbe => {
                        // cp (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        self.cp(value);
                        self.registers.reg_pc += 1;
                    }
                    0xcb => {
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        let value = self.bus.read_mem(iy + n as u16);
                        let opcode = self.bus.read_mem(self.registers.reg_pc + 1);
                        self.registers.reg_pc += 2;
                        match opcode {
                            0x06 => {
                                // rlc (iy+n)
                                self.rlc(Type::Direct(iy + n as u16));
                            }
                            0x0e => {
                                // rrc (iy+n)
                                self.rrc(Type::Direct(iy + n as u16));
                            }
                            0x16 => {
                                // rl (iy+n)
                                self.rl(Type::Direct(iy + n as u16));
                            }
                            0x1e => {
                                // rr (iy+n)
                                self.rr(Type::Direct(iy + n as u16));
                            }
                            0x26 => {
                                // sla (iy+n)
                                self.sla(Type::Direct(iy + n as u16));
                            }
                            0x2e => {
                                // sra (iy+n)
                                self.sra(Type::Direct(iy + n as u16));
                            }
                            0x46 => {
                                // bit 0,(iy+n)
                                self.bit(0, self.bus.read_mem(iy + n as u16));
                            }
                            0x4e => {
                                // bit 1,(iy+n)
                                self.bit(1, self.bus.read_mem(iy + n as u16));
                            }
                            0x56 => {
                                // bit 2,(iy+n)
                                self.bit(2, self.bus.read_mem(iy + n as u16));
                            }
                            0x5e => {
                                // bit 3,(iy+n)
                                self.bit(3, self.bus.read_mem(iy + n as u16));
                            }
                            0x66 => {
                                // bit 4,(iy+n)
                                self.bit(4, self.bus.read_mem(iy + n as u16));
                            }
                            0x6e => {
                                // bit 5,(iy+n)
                                self.bit(5, self.bus.read_mem(iy + n as u16));
                            }
                            0x76 => {
                                // bit 6,(iy+n)
                                self.bit(6, self.bus.read_mem(iy + n as u16));
                            }
                            0x7e => {
                                // bit 7,(iy+n)
                                self.bit(7, self.bus.read_mem(iy + n as u16));
                            }
                            0x86 => {
                                // res 0,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.res(0, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0x8e => {
                                // res 1,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.res(1, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0x96 => {
                                // res 2,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.res(2, value);
                                self.bus.write_mem(iy + n as u16, value);
                            }
                            0x9e => {
                                // res 3,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.res(3, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xa6 => {
                                // res 4,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.res(4, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xae => {
                                // res 5,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.res(5, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xb6 => {
                                // res 6,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.res(6, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xbe => {
                                // res 7,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.res(7, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xc6 => {
                                // set 0,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.set(0, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xce => {
                                // set 1,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.set(1, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xd6 => {
                                // set 2,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.set(2, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xde => {
                                // set 3,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.set(3, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xe6 => {
                                // set 4,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.set(4, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xee => {
                                // set 5,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.set(5, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xf6 => {
                                // set 6,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.set(6, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            0xfe => {
                                // set 7,(iy+n)
                                let value = self.bus.read_mem(iy + n as u16);
                                let result = self.set(7, value);
                                self.bus.write_mem(iy + n as u16, result);
                            }
                            _ => {
                                // Illegal opcode
                                panic!("Illegal opcode {:x}", self.registers.reg_pc);
                            }
                        }
                    }
                    0xe1 => {
                        // pop iy
                        self.registers
                            .set_iy(self.bus.read_mem_u16(self.registers.reg_sp));
                        self.registers.reg_sp += 2;
                    }
                    0xe3 => {
                        // ex (sp),iy
                        let sp = self.bus.read_mem_u16(self.registers.reg_sp);
                        self.bus
                            .write_mem_u16(self.registers.reg_sp, self.registers.get_iy());
                        self.registers.set_iy(sp);
                    }
                    0xe5 => {
                        // push iy
                        self.registers.reg_sp -= 2;
                        self.bus
                            .write_mem_u16(self.registers.reg_sp, self.registers.get_iy());
                    }
                    0xe9 => {
                        // jp (iy)
                        let iy = self.bus.read_mem_u16(self.registers.get_iy());
                        self.registers.reg_pc = iy;
                    }
                    0xf9 => {
                        // ld sp,iy
                        self.registers.reg_sp = self.registers.get_iy();
                    }
                    _ => {
                        // Illegal opcode
                        panic!("Illegal opcode {:x}", self.registers.reg_pc);
                    }
                }
            }
            0xfe => {
                // cp n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.cp(n);
                self.registers.reg_pc += 1;
            }
            0xff => {
                // rst 38h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0038;
            }
        }
    }

    pub fn run(&mut self) {}

    pub fn step(&mut self) {
        self.exec_opcode();
        let rhb = self.registers.reg_r & 0x80;
        self.registers.reg_r = self.registers.reg_r.wrapping_add(1) | rhb;
    }

    pub fn steps(&mut self, no_steps: u16) {
        for _ in 0..no_steps {
            self.step();
        }
    }

    pub fn reset(&mut self) {
        self.reset = true;
        self.hard_reset = false;
        self.registers = Registers::default();
    }

    pub fn hard_reset(&mut self) {
        self.reset = false;
        self.hard_reset = true;
        self.registers = Registers::default();
    }
}

#[cfg(test)]
mod tests {
    use crate::bus::Bus;

    use super::Cpu;
    use super::Type;
    use std::io::Write;

    pub fn zx_spectrum_print(cpu: &mut Cpu) {
        static mut TAB: bool = false;
        static mut XPOS: u8 = 0;
        let a = cpu.registers.reg_a;
        if unsafe { TAB } {
            let pos = unsafe { a - XPOS };
            print!("{}", " ".repeat(pos as usize));
            unsafe {
                TAB = false;
            };
        } else {
            match a {
                13 => {
                    unsafe { XPOS = 0 };
                    println!()
                }
                16..=22 => (),
                23 => {
                    unsafe { TAB = true };
                }
                32..=127 => {
                    std::io::stdout().flush().unwrap();
                    print!("{}", a as char);
                    std::io::stdout().flush().unwrap();
                    unsafe { XPOS += 1 };
                }
                _ => (),
            }
        }
    }

    #[test]
    fn testing_abs_function() {
        let value = Cpu::abs(0xfe);
        assert_eq!(value, 0x02);
    }

    #[test]
    fn testing_cpu_execution() {
        let mut bus = Bus::new(16384);
        let program = vec![
            0x3e, 0xff, 0x06, 0x80, 0x0e, 0xaa, 0x16, 0x55, 0x1e, 0x10, 0x26, 0x20, 0x2e, 0x40,
            0xd9, 0xcb, 0x17, 0xdd, 0x09,
        ];

        for (addr, &opcode) in program.iter().enumerate() {
            bus.write_mem(addr as u16, opcode);
        }
        bus.write_mem(0x2000, 0xaa);

        let mut cpu = Cpu::new(bus);
        cpu.registers.reg_f.c = false;
        cpu.steps(7);

        assert_eq!(cpu.registers.reg_a, 0xff);
        assert_eq!(cpu.registers.reg_b, 0x80);
        assert_eq!(cpu.registers.reg_c, 0xaa);
        assert_eq!(cpu.registers.reg_d, 0x55);
        assert_eq!(cpu.registers.reg_e, 0x10);
        assert_eq!(cpu.registers.reg_h, 0x20);
        assert_eq!(cpu.registers.reg_l, 0x40);

        cpu.step(); // Execute 0xd9, swap all registers

        assert_eq!(cpu.registers.reg_b, 0x00);
        assert_eq!(cpu.registers.reg_c, 0x00);
        assert_eq!(cpu.registers.reg_d, 0x00);
        assert_eq!(cpu.registers.reg_e, 0x00);
        assert_eq!(cpu.registers.reg_h, 0x00);
        assert_eq!(cpu.registers.reg_l, 0x00);

        assert_eq!(cpu.alternate.get_bc(), 0x80aa);
        assert_eq!(cpu.alternate.get_de(), 0x5510);
        assert_eq!(cpu.alternate.get_hl(), 0x2040);

        cpu.step();
        assert_eq!(cpu.registers.reg_a, 0xfe);
        cpu.registers.reg_a = cpu.inc(cpu.registers.reg_a);
        cpu.registers.reg_a = cpu.inc(cpu.registers.reg_a);
        assert_eq!(cpu.registers.reg_a, 0x00);
        assert_eq!(cpu.registers.reg_f.c, true);
        cpu.or(Type::Immediate(0x80));
        assert_eq!(cpu.registers.reg_a, 0x80);
        cpu.xor(Type::Immediate(0x81));
        assert_eq!(cpu.registers.reg_a, 0x01);
        cpu.and(Type::Immediate(0xfe));
        assert_eq!(cpu.registers.reg_a, 0x00);

        cpu.registers.set_bc(0x1234);
        cpu.registers.set_ix(0x4321);
        cpu.step();
        assert_eq!(cpu.registers.get_ix(), 0x5555);

        cpu.registers.set_hl(0x2000);
        cpu.xor(Type::Direct(0x2000));
        assert_eq!(cpu.registers.reg_a, 0xaa);
    }

    #[test]
    fn testing_cpu_full_test() {
        let mut bus = Bus::new(65535);
        let program = include_bytes!("../tests/z80ccf.bin").to_vec();
        // let program = include_bytes!("../tests/z80full.bin").to_vec();

        for (offset, &opcode) in program.iter().enumerate() {
            bus.write_mem(0x8000 + offset as u16, opcode);
        }
        // Patch location 0x1601 where ZX Spectrum selects channel.
        bus.write_mem(0x1601, 0xc9);
        // Patch RST10 location with HALT
        bus.write_mem(0x0010, 0x76);

        let mut cpu = Cpu::new(bus);
        cpu.registers.reg_pc = 0x8000;
        cpu.registers.set_sp(0xffff);

        while cpu.registers.reg_pc != 0x8094 {
            // println!("PC: {:#04x}", cpu.registers.reg_pc);
            if cpu.halt {
                // dbg!("HALT");
                zx_spectrum_print(&mut cpu);
                cpu.pop_stack();
                cpu.halt = false;
            }
            // if cpu.registers.reg_pc == 0x8335 {
            //     print!(".");
            // }
            cpu.step();
        }

        assert_eq!(cpu.registers.reg_pc, 0x8094);
    }
}

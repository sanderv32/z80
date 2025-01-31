#![allow(dead_code)]
#![allow(unused_variables)]

use crate::registers::Registers;
use crate::bus::Bus;

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

    fn abs(value: u8) -> u8 {
        if value & 0x80 == 0x80 {
            (0x100 - value as u16 & 0x007f) as u8
        } else {
            value
        }
    }

    fn daa(&mut self) {

    }

    fn inc(&mut self, r1: u8) -> u8 {
        let value = r1.wrapping_add(1);
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (value & 0x0f) + 1 > 0x0f;
        self.registers.reg_f.n = false;
        value
    }

    fn dec(&mut self, r1: u8) -> u8 {
        let value = r1.wrapping_sub(1);
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.p = value == 0x80;
        self.registers.reg_f.h = (value & 0x0f) < 1;
        self.registers.reg_f.n = true;
        value
    }

    // fn add(&mut self, r1: u8) {
    //     let a = self.registers.reg_a;
    //     let value = a.wrapping_add(r1);
    //     self.registers.reg_f.s = (value as i8) < 0;
    //     self.registers.reg_f.z = value == 0;
    //     self.registers.reg_f.h = (value & 0x0f) + (a & 0x0f) > 0x0f;
    //     self.registers.reg_f.c = u16::from(a) + u16::from(r1) > 0xff;
    //     self.registers.reg_f.p = (a as i8).overflowing_add(value as i8).1;
    //     self.registers.reg_f.n = false;
    //     self.registers.reg_a = value;
    // }

    fn add(&mut self, r1: u8, with_carry: bool) {
        let carry = if with_carry {
            match self.registers.reg_f.c {
                true => 1,
                false => 0,
            }
        } else {
            0
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

    /// Substract `r1` from register A
    ///
    /// r1: Register to substract from A
    /// with_carry: Use SUB if not set otherwise use SBC.
    fn sub(&mut self, r1: u8, with_carry: bool) {
        let carry: u8 = if with_carry {
            match self.registers.reg_f.c {
                true => 1,
                false => 0,
            }
        } else {
            0
        };
        let a = self.registers.reg_a;
        let value = a.wrapping_sub(r1);
        self.registers.reg_f.s = (value as i8) < 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (a as i8 & 0x0f) < (value as i8 & 0x0f).wrapping_add(carry as i8);
        self.registers.reg_f.c = u16::from(a) < (u16::from(r1) + u16::from(carry));
        self.registers.reg_f.p = (a as i8).overflowing_sub(value.wrapping_add(carry) as i8).1;
        self.registers.reg_f.n = false;
        self.registers.reg_a = value;
    }

    fn and(&mut self, r1: u8) {
        let a = self.registers.reg_a;
        let value = a & r1;
        self.registers.reg_a = value;
    }

    fn or(&mut self, r1: u8) {
        let a = self.registers.reg_a;
        let value = a | r1;
        self.registers.reg_a = value;
    }

    fn xor(&mut self, r1: u8) {
        let a = self.registers.reg_a;
        let value = a ^ r1;
        self.registers.reg_a = value;
    }

    fn cp(&mut self, r1: u8) {
        let a = self.registers.reg_a;
        self.sub(r1, false);
        self.registers.reg_a = a;
    }

    fn pop_stack(&mut self) {
        self.registers.reg_pc = self.bus.read_mem_u16(self.registers.reg_sp);
        self.registers.reg_sp += 2;
    }

    fn push_stack(&mut self, value: u16) {
        self.registers.reg_sp -= 2;
        self.bus.write_mem_u16(self.registers.reg_sp, value);
    }

    fn rlc(&mut self, r1: u8) {
        let carry = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.registers.reg_a = r1 << 1 | carry >> 7;
    }

    fn rrc(&mut self, r1: u8) {
        let carry = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.registers.reg_a = r1 >> 1 | carry << 7;
    }

    fn rl(&mut self, r1: u8) {
        let carry = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.registers.reg_a = r1 << 1 | carry;
    }

    fn rr(&mut self, r1: u8) {
        let carry = match self.registers.reg_f.c {
            true => 1,
            false => 0,
        };
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.registers.reg_a = r1 >> 1 | carry;
    }

    fn sla(&mut self, r1: u8) {
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.registers.reg_a = r1 << 1;
    }

    fn sll(&mut self, r1: u8) {
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.registers.reg_a = r1 << 1 | 1;
    }

    fn sra(&mut self, r1: u8) {
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.registers.reg_a = r1 >> 1 | r1 & 0x80;
    }

    fn srl(&mut self, r1: u8) {
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 == 0;
        self.registers.reg_f.s = (r1 as i8) < 0;
        self.registers.reg_a = r1 >> 1;
    }

    fn bit(&mut self, bit: u8, r1: u8) {
        self.registers.reg_f.h = true;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 & (1 << bit) == (1 << bit);
    }

    fn res(&mut self, bit: u8, r1: u8) -> u8 {
        r1 & !(1 << bit)
    }

    pub fn ex_op(&mut self) -> u16 {
        let pc = self.registers.reg_pc;
        let opcode = self.bus.read_mem(pc);
        let mut pc = pc+1;
        match opcode {
            0x00 => (), // nop
            0x01 => {// ld bc,nn
                let value = self.bus.read_mem_u16(pc);
                self.registers.set_bc(value);
                pc += 2;
            },
            0x02 => {// ld (bc),a
                let addr = self.registers.get_bc();
                self.bus.write_mem(addr, self.registers.reg_a);
            },
            0x03 => {// inc bc
                let bc = self.registers.get_bc() + 1;
                self.registers.set_bc(bc);
            },
            0x04 => {// inc b
                self.inc(self.registers.reg_b);
            },
            0x05 => {// dec b
                self.dec(self.registers.reg_b);
            },
            0x06 => {// ld b,n
                let value = self.bus.read_mem(pc);
                self.registers.reg_b = value;
                pc += 1;
            },
            0x07 => {// rlca
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = self.registers.reg_a & 0x80 == 0x80;
                self.registers.reg_a = self.registers.reg_a << 1;
            },
            0x08 => {// ex af,af'
                let af = self.registers.get_af();
                let aaf = self.alternate.get_af();
                self.registers.set_af(aaf);
                self.alternate.set_af(af);
            },
            0x09 => {// add hl,bc
                let bc = self.registers.get_bc();
                let hl = self.registers.get_hl();
                let value = self.add16(hl, bc);
                self.registers.set_hl(value);
            },
            0x0a => {// ld a,(bc)
                let bc = self.registers.get_bc();
                self.registers.reg_a = self.bus.read_mem(bc);
            },
            0x0b => {// dec bc
                let bc = self.registers.get_bc().wrapping_sub(1);
                self.registers.set_bc(bc);
            },
            0x0c => {// inc c
                self.inc(self.registers.reg_c);
            },
            0x0d => {// dec c
                self.dec(self.registers.reg_c);
            },
            0x0e => {// ld c,n
                let n = self.bus.read_mem(pc);
                self.registers.reg_c = n;
                pc += 1;
            },
            0x0f => {// rrca
                let carry = self.registers.reg_a & 0x01;
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = carry == 0x01;
                self.registers.reg_a = (self.registers.reg_a >> 1) | (carry << 7);

            },
            0x10 => {// djnz $+2
                self.registers.reg_b = self.registers.reg_b.wrapping_sub(1);
                if self.registers.reg_b == 0 {
                    self.registers.reg_pc += 1;
                } else {
                    let value = self.bus.read_mem(pc+1);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc = self.registers.reg_pc + 1 - Cpu::abs(value) as u16;
                    } else {
                        self.registers.reg_pc = self.registers.reg_pc + 1 + value as u16;
                    }
                }
                pc += 1;
            },
            0x11 => {// ld de,nn
                let nn = self.bus.read_mem_u16(pc+1);
                self.registers.set_de(nn);
                pc += 2
            },
            0x12 => {// ld (de),a
                let de = self.registers.get_de();
                self.bus.write_mem(de, self.registers.reg_a);
            },
            0x13 => {// inc de
                let de = self.registers.get_de() + 1;
                self.registers.set_de(de);
            },
            0x14 => {// inc d
                self.inc(self.registers.reg_d);
            },
            0x15 => {// dec d
                self.dec(self.registers.reg_d);
            },
            0x16 => {// ld d,n
                let n = self.bus.read_mem(pc);
                self.registers.reg_d = n;
                pc += 1;
            },
            0x17 => {// rla
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = self.registers.reg_a & 0x80 == 0x80;
                self.registers.reg_a = self.registers.reg_a << 1;
            },
            0x18 => {// jr $+2
                let value = self.bus.read_mem(pc+1);
                if value & 0x80 == 0x80 {
                    self.registers.reg_pc = self.registers.reg_pc + 1 - Cpu::abs(value) as u16;
                } else {
                    self.registers.reg_pc = self.registers.reg_pc + 1 + value as u16;
                }
            },
            0x19 => {// add hl,de
                let de = self.registers.get_de();
                let hl = self.registers.get_hl();
                let value = self.add16(hl, de);
                self.registers.set_hl(value);
            },
            0x1a => {// ld a,(de)
                let de = self.registers.get_de();
                self.registers.reg_a = self.bus.read_mem(de);
            },
            0x1b => {// dec de
                let de = self.registers.get_de().wrapping_sub(1);
                self.registers.set_de(de);
            },
            0x1c => {// inc e
                self.inc(self.registers.reg_e);
            },
            0x1d => {// dec e
                self.dec(self.registers.reg_e);
            },
            0x1e => {// ld e,n
                let n = self.bus.read_mem(pc);
                self.registers.reg_e = n;
                pc += 1;
            },
            0x1f => {// rra
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                let carry = match self.registers.reg_f.c {
                    true => 1,
                    false => 0,
                };
                self.registers.reg_f.c = self.registers.reg_a & 0x01 == 0x01;
                self.registers.reg_a = (self.registers.reg_a >> 1) | (carry << 7);
            },
            0x20 => {// jr nz,$+2
                if self.registers.reg_f.z == false {
                    let value = self.bus.read_mem(pc+1);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc = self.registers.reg_pc + 1 - Cpu::abs(value) as u16;
                    } else {
                        self.registers.reg_pc = self.registers.reg_pc + 1 + value as u16;
                    }
                }
                pc += 1;
            },
            0x21 => {// ld hl,nn
                let nn = self.bus.read_mem_u16(pc);
                self.registers.set_hl(nn);
                pc += 2;
            },
            0x22 => {// ld (nn),hl
                let nn = self.bus.read_mem_u16(pc);
                self.bus.write_mem_u16(nn, self.registers.get_hl());
                pc += 2;
            },
            0x23 => {// inc hl
                let hl = self.registers.get_hl() + 1;
                self.registers.set_hl(hl);
            },
            0x24 => {// inc h
                self.inc(self.registers.reg_h);
            },
            0x25 => {// dec h
                self.dec(self.registers.reg_h);
            },
            0x26 => {// ld h,n
                let n = self.bus.read_mem(pc);
                self.registers.reg_h = n;
                pc += 1
            },
            0x27 => {// daa
                // TODO
            },
            0x28 => {// jr z,$+2
                if self.registers.reg_f.z == true {
                    let value = self.bus.read_mem(pc+1);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc = self.registers.reg_pc + 1 - Cpu::abs(value) as u16;
                    } else {
                        self.registers.reg_pc = self.registers.reg_pc + 1 + value as u16;
                    }
                }
                pc += 1;
            },
            0x29 => {// add hl,hl
                let hl = self.registers.get_hl();
                let value = self.add16(hl, hl);
                self.registers.set_hl(value);
            },
            0x2a => {// ld hl,(nn)
                let nn = self.bus.read_mem_u16(pc);
                self.registers.set_hl(nn);
                pc += 2;
            },
            0x2b => {// dec hl
                let hl = self.registers.get_hl().wrapping_sub(1);
                self.registers.set_hl(hl);
            },
            0x2c => {// inc l
                self.inc(self.registers.reg_l);
            },
            0x2d => {// dec l
                self.dec(self.registers.reg_l);
            },
            0x2e => {// ld l,n
                let n = self.bus.read_mem(pc);
                self.registers.reg_l = n;
                pc += 1;
            },
            0x2f => {// cpl
                let a = self.registers.reg_a;
                self.registers.reg_a = ((a & 0x0f) << 4) | ((a & 0xf0) >> 4);
            },
            0x30 => {// jr nc,$+2
                if self.registers.reg_f.c == false {
                    let value = self.bus.read_mem(pc+1);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc = self.registers.reg_pc + 1 - Cpu::abs(value) as u16;
                    } else {
                        self.registers.reg_pc = self.registers.reg_pc + 1 + value as u16;
                    }
                }
                pc += 1;
            },
            0x31 => {// ld sp,nn
                let nn = self.bus.read_mem_u16(pc);
                self.registers.set_sp(nn);
                pc += 2;
            },
            0x32 => {// ld (nn),a
                let nn = self.bus.read_mem_u16(pc);
                self.bus.write_mem(nn, self.registers.reg_a);
                pc += 2;
            },
            0x33 => {// inc sp
                let sp = self.registers.get_sp() + 1;
                self.registers.set_sp(sp);
            },
            0x34 => {// inc (hl)
                let hl = self.registers.get_hl();
                let v = self.inc(self.bus.read_mem(hl));
                self.bus.write_mem(hl, v);
            },
            0x35 => {// dec (hl)
                let hl = self.registers.get_hl();
                let v = self.dec(self.bus.read_mem(hl));
                self.bus.write_mem(hl, v);
            },
            0x36 => {// ld (hl),n
                let n = self.bus.read_mem(pc);
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, n);
                pc += 1;
            },
            0x37 => {// scf
                self.registers.reg_f.c = true;
            },
            0x38 => {// jr c,$+2
                if self.registers.reg_f.c == true {
                    let value = self.bus.read_mem(pc+1);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc = self.registers.reg_pc + 1 - Cpu::abs(value) as u16;
                    } else {
                        self.registers.reg_pc = self.registers.reg_pc + 1 + value as u16;
                    }
                }
                pc += 1;
            },
            0x39 => {// add hl,sp
                let sp = self.registers.get_sp();
                let hl = self.registers.get_hl();
                let value = self.add16(hl, sp);
                self.registers.set_hl(value);
            },
            0x3a => {// ld a,(nn)
                let nn = self.bus.read_mem_u16(pc);
                self.registers.reg_a = self.bus.read_mem(nn);
                pc += 2;
            },
            0x3b => {// dec sp
                let sp = self.registers.get_sp().wrapping_sub(1);
                self.registers.set_sp(sp);
            },
            0x3c => {// inc a
                self.inc(self.registers.reg_a);
            },
            0x3d => {// dec a
                self.dec(self.registers.reg_a);
            },
            0x3e => {// ld a,n
                let n = self.bus.read_mem(pc);
                self.registers.reg_a = n;
                pc += 1;
            },
            0x3f => {// ccf
                self.registers.reg_f.c = false;
            },
            0x40 => {// ld b,b
            },
            0x41 => {// ld b,c
                self.registers.reg_b = self.registers.reg_c;
            },
            0x42 => {// ld b,d
                self.registers.reg_b = self.registers.reg_d;
            },
            0x43 => {// ld b,e
                self.registers.reg_b = self.registers.reg_e;
            },
            0x44 => {// ld b,h
                self.registers.reg_b = self.registers.reg_h;
            },
            0x45 => {// ld b,l
                self.registers.reg_b = self.registers.reg_l;
            },
            0x46 => {// ld b,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_b = self.bus.read_mem(hl);
            },
            0x47 => {// ld b,a
                self.registers.reg_b = self.registers.reg_a;
            },
            0x48 => {// ld c,b
                self.registers.reg_b = self.registers.reg_a;
            },
            0x49 => {// ld c,c
            },
            0x4a => {// ld c,d
                self.registers.reg_c = self.registers.reg_d;
            },
            0x4b => {// ld c,e
                self.registers.reg_c = self.registers.reg_e;
            },
            0x4c => {// ld c,h
                self.registers.reg_c = self.registers.reg_h;
            },
            0x4d => {// ld c,l
                self.registers.reg_c = self.registers.reg_l;
            },
            0x4e => {// ld c,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_c = self.bus.read_mem(hl);
            },
            0x4f => {// ld c,a
                self.registers.reg_c = self.registers.reg_a;
            },
            0x50 => {// ld d,b
                self.registers.reg_d = self.registers.reg_b;
            },
            0x51 => {// ld d,c
                self.registers.reg_d = self.registers.reg_c;
            },
            0x52 => {// ld d,d
            },
            0x53 => {// ld d,e
                self.registers.reg_d = self.registers.reg_e;
            },
            0x54 => {// ld d,h
                self.registers.reg_d = self.registers.reg_h;
            },
            0x55 => {// ld d,l
                self.registers.reg_d = self.registers.reg_l;
            },
            0x56 => {// ld d,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_d = self.bus.read_mem(hl);
            },
            0x57 => {// ld d,a
                self.registers.reg_d = self.registers.reg_a;
            },
            0x58 => {// ld e,b
                self.registers.reg_e = self.registers.reg_b;
            },
            0x59 => {// ld e,c
                self.registers.reg_e = self.registers.reg_c;
            },
            0x5a => {// ld e,d
                self.registers.reg_e = self.registers.reg_d;
            },
            0x5b => {// ld e,e
            },
            0x5c => {// ld e,h
                self.registers.reg_e = self.registers.reg_h;
            },
            0x5d => {// ld e,l
                self.registers.reg_e = self.registers.reg_l;
            },
            0x5e => {// ld e,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_e = self.bus.read_mem(hl);
            },
            0x5f => {// ld e,a
                self.registers.reg_e = self.registers.reg_a;
            },
            0x60 => {// ld h,b
                self.registers.reg_h = self.registers.reg_b;
            },
            0x61 => {// ld h,c
                self.registers.reg_h = self.registers.reg_c;
            },
            0x62 => {// ld h,d
                self.registers.reg_h = self.registers.reg_d;
            },
            0x63 => {// ld h,e
                self.registers.reg_h = self.registers.reg_e;
            },
            0x64 => {// ld h,h
            },
            0x65 => {// ld h,l
                self.registers.reg_h = self.registers.reg_l;
            },
            0x66 => {// ld h,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_h = self.bus.read_mem(hl);
            },
            0x67 => {// ld h,a
                self.registers.reg_h = self.registers.reg_a;
            },
            0x68 => {// ld l,b
                self.registers.reg_l = self.registers.reg_b;
            },
            0x69 => {// ld l,c
                self.registers.reg_l = self.registers.reg_c;
            },
            0x6a => {// ld l,d
                self.registers.reg_l = self.registers.reg_d;
            },
            0x6b => {// ld l,e
                self.registers.reg_l = self.registers.reg_e;
            },
            0x6c => {// ld l,h
                self.registers.reg_l = self.registers.reg_h;
            },
            0x6d => {// ld l,l
            },
            0x6e => {// ld l,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_l = self.bus.read_mem(hl);
            },
            0x6f => {// ld l,a
                self.registers.reg_l = self.registers.reg_a;
            },
            0x70 => {// ld (hl),b
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_b);
            },
            0x71 => {// ld (hl),c
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_c);
            },
            0x72 => {// ld (hl),d
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_d);
            },
            0x73 => {// ld (hl),e
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_e);
            },
            0x74 => {// ld (hl),h
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_h);
            },
            0x75 => {// ld (hl),l
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_l);
            },
            0x76 => {// halt
                self.halt = true;
            },
            0x77 => {// ld (hl),a
                let hl = self.registers.get_hl();
                self.bus.write_mem(hl, self.registers.reg_a);
            },
            0x78 => {// ld a,b
                self.registers.reg_a = self.registers.reg_b;
            },
            0x79 => {// ld a,c
                self.registers.reg_a = self.registers.reg_c;
            },
            0x7a => {// ld a,d
                self.registers.reg_a = self.registers.reg_d;
            },
            0x7b => {// ld a,e
                self.registers.reg_a = self.registers.reg_e;
            },
            0x7c => {// ld a,h
                self.registers.reg_a = self.registers.reg_h;
            },
            0x7d => {// ld a,l
                self.registers.reg_a = self.registers.reg_l;
            },
            0x7e => {// ld a,(hl)
                let hl = self.registers.get_hl();
                self.registers.reg_a = self.bus.read_mem(hl);
            },
            0x7f => {// ld a,a
            },
            0x80 => {// add a,b
                self.add(self.registers.reg_b, false);
            },
            0x81 => {// add a,c
                self.add(self.registers.reg_c, false);
            },
            0x82 => {// add a,d
                self.add(self.registers.reg_d, false);
            },
            0x83 => {// add a,e
                self.add(self.registers.reg_e, false);
            },
            0x84 => {// add a,h
                self.add(self.registers.reg_h, false);
            },
            0x85 => {// add a,l
                self.add(self.registers.reg_l, false);
            },
            0x86 => {// add a,(hl)
                let hl = self.registers.get_hl();
                self.add(self.bus.read_mem(hl), false);
            },
            0x87 => {// add a,a
                self.add(self.registers.reg_a, false);
            },
            0x88 => {// adc a,b
                self.add(self.registers.reg_b, true);
            },
            0x89 => {// adc a,c
                self.add(self.registers.reg_c, true);
            },
            0x8a => {// adc a,d
                self.add(self.registers.reg_d, true);
            },
            0x8b => {// adc a,e
                self.add(self.registers.reg_e, true);
            },
            0x8c => {// adc a,h
                self.add(self.registers.reg_h, true);
            },
            0x8d => {// adc a,l
                self.add(self.registers.reg_l, true);
            },
            0x8e => {// adc a,(hl)
                let hl = self.registers.get_hl();
                self.add(self.bus.read_mem(hl), true);
            },
            0x8f => {// adc a,a
                self.add(self.registers.reg_a, true);
            },
            0x90 => {// sub b
                self.sub(self.registers.reg_b, false);
            },
            0x91 => {// sub c
                self.sub(self.registers.reg_c, false);
            },
            0x92 => {// sub d
                self.sub(self.registers.reg_d, false);
            },
            0x93 => {// sub e
                self.sub(self.registers.reg_e, false);
            },
            0x94 => {// sub h
                self.sub(self.registers.reg_h, false);
            },
            0x95 => {// sub l
                self.sub(self.registers.reg_l, false);
            },
            0x96 => {// sub (hl)
                let hl = self.registers.get_hl();
                self.sub(self.bus.read_mem(hl), false);
            },
            0x97 => {// sub a
                self.sub(self.registers.reg_a, false);
            },
            0x98 => {// sbc b
                self.sub(self.registers.reg_b, true);
            },
            0x99 => {// sbc c
                self.sub(self.registers.reg_c, true);
            },
            0x9a => {// sbc d
                self.sub(self.registers.reg_d, true);
            },
            0x9b => {// sbc e
                self.sub(self.registers.reg_e, true);
            },
            0x9c => {// sbc h
                self.sub(self.registers.reg_h, true);
            },
            0x9d => {// sbc l
                self.sub(self.registers.reg_l, true);
            },
            0x9e => {// sbc (hl)
                let hl = self.registers.get_hl();
                self.sub(self.bus.read_mem(hl), true);
            },
            0x9f => {// sbc a
                self.sub(self.registers.reg_a, true);
            },
            0xa0 => {// and b
                self.and(self.registers.reg_b);
            },
            0xa1 => {// and c
                self.and(self.registers.reg_c);
            },
            0xa2 => {// and d
                self.and(self.registers.reg_d);
            },
            0xa3 => {// and e
                self.and(self.registers.reg_e);
            },
            0xa4 => {// and h
                self.and(self.registers.reg_h);
            },
            0xa5 => {// and l
                self.and(self.registers.reg_l);
            },
            0xa6 => {// and (hl)
                let hl = self.registers.get_hl();
                self.and(self.bus.read_mem(hl));
            },
            0xa7 => {// and a
                self.and(self.registers.reg_a);
            },
            0xa8 => {// xor b
                self.xor(self.registers.reg_b);
            },
            0xa9 => {// xor c
                self.xor(self.registers.reg_c);
            },
            0xaa => {// xor d
                self.xor(self.registers.reg_d);
            },
            0xab => {// xor e
                self.xor(self.registers.reg_e);
            },
            0xac => {// xor h
                self.xor(self.registers.reg_h);
            },
            0xad => {// xor l
                self.xor(self.registers.reg_l);
            },
            0xae => {// xor (hl)
                let hl = self.registers.get_hl();
                self.xor(self.bus.read_mem(hl));
            },
            0xaf => {// xor a
                self.xor(self.registers.reg_a);
            },
            0xb0 => {// or b
                self.or(self.registers.reg_b);
            },
            0xb1 => {// or c
                self.or(self.registers.reg_c);
            },
            0xb2 => {// or d
                self.or(self.registers.reg_d);
            },
            0xb3 => {// or e
                self.or(self.registers.reg_e);
            },
            0xb4 => {// or h
                self.or(self.registers.reg_h);
            },
            0xb5 => {// or l
                self.or(self.registers.reg_l);
            },
            0xb6 => {// or (hl)
                let hl = self.registers.get_hl();
                self.or(self.bus.read_mem(hl));
            },
            0xb7 => {// or a
                self.or(self.registers.reg_a);
            },
            0xb8 => {// cp b
                self.cp(self.registers.reg_b);
            },
            0xb9 => {// cp c
                self.cp(self.registers.reg_c);
            },
            0xba => {// cp d
                self.cp(self.registers.reg_d);
            },
            0xbb => {// cp e
                self.cp(self.registers.reg_e);
            },
            0xbc => {// cp h
                self.cp(self.registers.reg_h);
            },
            0xbd => {// cp l
                self.cp(self.registers.reg_l);
            },
            0xbe => {// cp (hl)
                let hl = self.registers.get_hl();
                self.cp(self.bus.read_mem(hl));
            },
            0xbf => {// cp a
                self.cp(self.registers.reg_a);
            },
            0xc0 => {// ret nz
                if self.registers.reg_f.z == false {
                    self.pop_stack();
                }
            },
            0xc1 => {// pop bc
                self.registers.set_bc(self.bus.read_mem_u16(self.registers.reg_sp));
                self.registers.reg_sp += 2;
            },
            0xc2 => {// jp nz,$+3
                let value = self.bus.read_mem_u16(pc);
                if self.registers.reg_f.z == false {
                    self.registers.reg_pc = value;
                } else {
                    pc += 2;
                }
            },
            0xc3 => {// jp $+3
                self.registers.reg_pc = self.bus.read_mem_u16(pc);
            },
            0xc4 => {// call nz,nn
                let value = self.bus.read_mem_u16(pc);
                if self.registers.reg_f.z == false {
                    self.registers.reg_pc = value;
                } else {
                    pc += 2
                }
            },
            0xc5 => {// push bc
                self.registers.reg_sp -= 2;
                self.bus.write_mem_u16(self.registers.reg_sp, self.registers.get_bc());
            },
            0xc6 => {// add a,n
                self.add(self.bus.read_mem(pc), false);
                pc += 1;
            },
            0xc7 => {// rst 0
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0000;
            },
            0xc8 => {// ret z
                if self.registers.reg_f.z == true {
                    self.pop_stack();
                }
            },
            0xc9 => {// ret
                self.pop_stack();
            },
            0xca => {// jp z,$+3
                if self.registers.reg_f.z == true {
                    let value = self.bus.read_mem_u16(pc);
                    self.registers.reg_pc = value;
                } else {
                    pc += 2;
                }
            },
            0xcb => {
                let opcode = self.bus.read_mem(pc);
                match opcode {
                    0x00 => {// rlc b
                        self.rlc(self.registers.reg_b);
                    },
                    0x01 => {// rlc c
                        self.rlc(self.registers.reg_c);
                    },
                    0x02 => {// rlc d
                        self.rlc(self.registers.reg_d);
                    },
                    0x03 => {// rlc e
                        self.rlc(self.registers.reg_e);
                    },
                    0x04 => {// rlc h
                        self.rlc(self.registers.reg_h);
                    },
                    0x05 => {// rlc l
                        self.rlc(self.registers.reg_l);
                    },
                    0x06 => {// rlc (hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.rlc(hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x07 => {// rlc a
                        self.rlc(self.registers.reg_a);
                    },
                    0x08 => {// rrc b
                        self.rrc(self.registers.reg_b);
                    },
                    0x09 => {// rrc c
                        self.rrc(self.registers.reg_c);
                    },
                    0x0a => {// rrc d
                        self.rrc(self.registers.reg_d);
                    },
                    0x0b => {// rrc e
                        self.rrc(self.registers.reg_e);
                    },
                    0x0c => {// rrc h
                        self.rrc(self.registers.reg_h);
                    },
                    0x0d => {// rrc l
                        self.rrc(self.registers.reg_l);
                    },
                    0x0e => {// rrc (hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.rrc(hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x0f => {// rrc a
                        self.rrc(self.registers.reg_a);
                    },
                    0x10 => {// rl  b
                        self.rl(self.registers.reg_b);
                    },
                    0x11 => {// rl  c
                        self.rl(self.registers.reg_c);
                    },
                    0x12 => {// rl  d
                        self.rl(self.registers.reg_d);
                    },
                    0x13 => {// rl  e
                        self.rl(self.registers.reg_e);
                    },
                    0x14 => {// rl  h
                        self.rl(self.registers.reg_h);
                    },
                    0x15 => {// rl  l
                        self.rl(self.registers.reg_l);
                    },
                    0x16 => {// rl  (hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.rl(hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x17 => {// rl  a
                        self.rl(self.registers.reg_a);
                    },
                    0x18 => {// rr  b
                        self.rr(self.registers.reg_b);
                    },
                    0x19 => {// rr  c
                        self.rr(self.registers.reg_c);
                    },
                    0x1a => {// rr  d
                        self.rr(self.registers.reg_d);
                    },
                    0x1b => {// rr  e
                        self.rr(self.registers.reg_e);
                    },
                    0x1c => {// rr  h
                        self.rr(self.registers.reg_h);
                    },
                    0x1d => {// rr  l
                        self.rr(self.registers.reg_l);
                    },
                    0x1e => {// rr  (hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.rr(hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x1f => {// rr  a
                        self.rr(self.registers.reg_a);
                    },
                    0x20 => {// sla b
                        self.sla(self.registers.reg_b);
                    },
                    0x21 => {// sla c
                        self.sla(self.registers.reg_c);
                    },
                    0x22 => {// sla d
                        self.sla(self.registers.reg_d);
                    },
                    0x23 => {// sla e
                        self.sla(self.registers.reg_e);
                    },
                    0x24 => {// sla h
                        self.sla(self.registers.reg_h);
                    },
                    0x25 => {// sla l
                        self.sla(self.registers.reg_l);
                    },
                    0x26 => {// sla (hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.sla(hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x27 => {// sla a
                        self.sla(self.registers.reg_a);
                    },
                    0x28 => {// sra b
                        self.sra(self.registers.reg_b);
                    },
                    0x29 => {// sra c
                        self.sra(self.registers.reg_c);
                    },
                    0x2a => {// sra d
                        self.sra(self.registers.reg_d);
                    },
                    0x2b => {// sra e
                        self.sra(self.registers.reg_e);
                    },
                    0x2c => {// sra h
                        self.sra(self.registers.reg_h);
                    },
                    0x2d => {// sra l
                        self.sra(self.registers.reg_l);
                    },
                    0x2e => {// sra (hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.sra(hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x2f => {// sra a
                        self.sra(self.registers.reg_a);
                    },
                    0x30 => {// sll b
                        self.sll(self.registers.reg_b);
                    },
                    0x31 => {// sll c
                        self.sll(self.registers.reg_c);
                    },
                    0x32 => {// sll d
                        self.sll(self.registers.reg_d);
                    },
                    0x33 => {// sll e
                        self.sll(self.registers.reg_e);
                    },
                    0x34 => {// sll h
                        self.sll(self.registers.reg_h);
                    },
                    0x35 => {// sll l
                        self.sll(self.registers.reg_l);
                    },
                    0x36 => {// sll (hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.sll(hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x37 => {// sll a
                        self.sll(self.registers.reg_a);
                    },
                    0x38 => {// srl b
                        self.srl(self.registers.reg_b);
                    },
                    0x39 => {// srl c
                        self.srl(self.registers.reg_c);
                    },
                    0x3a => {// srl d
                        self.srl(self.registers.reg_d);
                    },
                    0x3b => {// srl e
                        self.srl(self.registers.reg_e);
                    },
                    0x3c => {// srl h
                        self.srl(self.registers.reg_h);
                    },
                    0x3d => {// srl l
                        self.srl(self.registers.reg_l);
                    },
                    0x3e => {// srl (hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.srl(hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x3f => {// srl a
                        self.srl(self.registers.reg_a);
                    },
                    0x40 => {// bit 0,b
                        self.bit(0, self.registers.reg_b);
                    },
                    0x41 => {// bit 0,c
                        self.bit(0, self.registers.reg_c);
                    },
                    0x42 => {// bit 0,d
                        self.bit(0, self.registers.reg_d);
                    },
                    0x43 => {// bit 0,e
                        self.bit(0, self.registers.reg_e);
                    },
                    0x44 => {// bit 0,h
                        self.bit(0, self.registers.reg_h);
                    },
                    0x45 => {// bit 0,l
                        self.bit(0, self.registers.reg_l);
                    },
                    0x46 => {// bit 0,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(0, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x47 => {// bit 0,a
                        self.bit(0, self.registers.reg_a);
                    },
                    0x48 => {// bit 1,b
                        self.bit(1, self.registers.reg_b);
                    },
                    0x49 => {// bit 1,c
                        self.bit(1, self.registers.reg_c);
                    },
                    0x4a => {// bit 1,d
                        self.bit(1, self.registers.reg_d);
                    },
                    0x4b => {// bit 1,e
                        self.bit(1, self.registers.reg_e);
                    },
                    0x4c => {// bit 1,h
                        self.bit(1, self.registers.reg_h);
                    },
                    0x4d => {// bit 1,l
                        self.bit(1, self.registers.reg_l);
                    },
                    0x4e => {// bit 1,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(1, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x4f => {// bit 1,a
                        self.bit(1, self.registers.reg_a);
                    },
                    0x50 => {// bit 2,b
                        self.bit(2, self.registers.reg_b);
                    },
                    0x51 => {// bit 2,c
                        self.bit(2, self.registers.reg_c);
                    },
                    0x52 => {// bit 2,d
                        self.bit(2, self.registers.reg_d);
                    },
                    0x53 => {// bit 2,e
                        self.bit(2, self.registers.reg_e);
                    },
                    0x54 => {// bit 2,h
                        self.bit(2, self.registers.reg_h);
                    },
                    0x55 => {// bit 2,l
                        self.bit(2, self.registers.reg_l);
                    },
                    0x56 => {// bit 2,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(2, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x57 => {// bit 2,a
                        self.bit(2, self.registers.reg_a);
                    },
                    0x58 => {// bit 3,b
                        self.bit(3, self.registers.reg_b);
                    },
                    0x59 => {// bit 3,c
                        self.bit(3, self.registers.reg_c);
                    },
                    0x5a => {// bit 3,d
                        self.bit(3, self.registers.reg_d);
                    },
                    0x5b => {// bit 3,e
                        self.bit(3, self.registers.reg_e);
                    },
                    0x5c => {// bit 3,h
                        self.bit(3, self.registers.reg_h);
                    },
                    0x5d => {// bit 3,l
                        self.bit(3, self.registers.reg_l);
                    },
                    0x5e => {// bit 3,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(3, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x5f => {// bit 3,a
                        self.bit(3, self.registers.reg_a);
                    },
                    0x60 => {// bit 4,b
                        self.bit(4, self.registers.reg_b);
                    },
                    0x61 => {// bit 4,c
                        self.bit(4, self.registers.reg_c);
                    },
                    0x62 => {// bit 4,d
                        self.bit(4, self.registers.reg_d);
                    },
                    0x63 => {// bit 4,e
                        self.bit(4, self.registers.reg_e);
                    },
                    0x64 => {// bit 4,h
                        self.bit(4, self.registers.reg_h);
                    },
                    0x65 => {// bit 4,l
                        self.bit(4, self.registers.reg_l);
                    },
                    0x66 => {// bit 4,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(4, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x67 => {// bit 4,a
                        self.bit(4, self.registers.reg_a);
                    },
                    0x68 => {// bit 5,b
                        self.bit(5, self.registers.reg_b);
                    },
                    0x69 => {// bit 5,c
                        self.bit(5, self.registers.reg_c);
                    },
                    0x6a => {// bit 5,d
                        self.bit(5, self.registers.reg_d);
                    },
                    0x6b => {// bit 5,e
                        self.bit(5, self.registers.reg_e);
                    },
                    0x6c => {// bit 5,h
                        self.bit(5, self.registers.reg_h);
                    },
                    0x6d => {// bit 5,l
                        self.bit(5, self.registers.reg_l);
                    },
                    0x6e => {// bit 5,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(5, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x6f => {// bit 5,a
                        self.bit(5, self.registers.reg_a);
                    },
                    0x70 => {// bit 6,b
                        self.bit(6, self.registers.reg_b);
                    },
                    0x71 => {// bit 6,c
                        self.bit(6, self.registers.reg_c);
                    },
                    0x72 => {// bit 6,d
                        self.bit(6, self.registers.reg_d);
                    },
                    0x73 => {// bit 6,e
                        self.bit(6, self.registers.reg_e);
                    },
                    0x74 => {// bit 6,h
                        self.bit(6, self.registers.reg_h);
                    },
                    0x75 => {// bit 6,l
                        self.bit(6, self.registers.reg_l);
                    },
                    0x76 => {// bit 6,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(6, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x77 => {// bit 6,a
                        self.bit(6, self.registers.reg_a);
                    },
                    0x78 => {// bit 7,b
                        self.bit(7, self.registers.reg_b);
                    },
                    0x79 => {// bit 7,c
                        self.bit(7, self.registers.reg_c);
                    },
                    0x7a => {// bit 7,d
                        self.bit(7, self.registers.reg_d);
                    },
                    0x7b => {// bit 7,e
                        self.bit(7, self.registers.reg_e);
                    },
                    0x7c => {// bit 7,h
                        self.bit(7, self.registers.reg_h);
                    },
                    0x7d => {// bit 7,l
                        self.bit(7, self.registers.reg_l);
                    },
                    0x7e => {// bit 7,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bit(7, hl);
                        self.bus.write_mem(self.registers.get_hl(), hl);
                    },
                    0x7f => {// bit 7,a
                        self.bit(7, self.registers.reg_a);
                    },
                    0x80 => {// res 0,b
                        self.registers.reg_b = self.registers.reg_b & 0xfe;
                    },
                    0x81 => {// res 0,c
                        self.registers.reg_c = self.registers.reg_c & 0xfe;
                    },
                    0x82 => {// res 0,d
                        self.registers.reg_d = self.registers.reg_d & 0xfe;
                    },
                    0x83 => {// res 0,e
                        self.registers.reg_e = self.registers.reg_e & 0xfe;
                    },
                    0x84 => {// res 0,h
                        self.registers.reg_h = self.registers.reg_h & 0xfe;
                    },
                    0x85 => {// res 0,l
                        self.registers.reg_l = self.registers.reg_l & 0xfe;
                    },
                    0x86 => {// res 0,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xfe);
                    },
                    0x87 => {// res 0,a
                        self.registers.reg_a = self.registers.reg_a & 0xfe;
                    },
                    0x88 => {// res 1,b
                        self.registers.reg_b = self.registers.reg_b & 0xfd;
                    },
                    0x89 => {// res 1,c
                        self.registers.reg_c = self.registers.reg_c & 0xfd;
                    },
                    0x8a => {// res 1,d
                        self.registers.reg_d = self.registers.reg_d & 0xfd;
                    },
                    0x8b => {// res 1,e
                        self.registers.reg_e = self.registers.reg_e & 0xfd;
                    },
                    0x8c => {// res 1,h
                        self.registers.reg_h = self.registers.reg_h & 0xfd;
                    },
                    0x8d => {// res 1,l
                        self.registers.reg_l = self.registers.reg_l & 0xfd;
                    },
                    0x8e => {// res 1,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xfd);
                    },
                    0x8f => {// res 1,a
                        self.registers.reg_a = self.registers.reg_a & 0xfd;
                    },
                    0x90 => {// res 2,b
                        self.registers.reg_b = self.registers.reg_b & 0xfb;
                    },
                    0x91 => {// res 2,c
                        self.registers.reg_c = self.registers.reg_c & 0xfb;
                    },
                    0x92 => {// res 2,d
                        self.registers.reg_d = self.registers.reg_d & 0xfb;
                    },
                    0x93 => {// res 2,e
                        self.registers.reg_e = self.registers.reg_e & 0xfb;
                    },
                    0x94 => {// res 2,h
                        self.registers.reg_h = self.registers.reg_h & 0xfb;
                    },
                    0x95 => {// res 2,l
                        self.registers.reg_l = self.registers.reg_l & 0xfb;
                    },
                    0x96 => {// res 2,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xfb);
                    },
                    0x97 => {// res 2,a
                        self.registers.reg_a = self.registers.reg_a & 0xfb;
                    },
                    0x98 => {// res 3,b
                        self.registers.reg_b = self.registers.reg_b & 0xf7;
                    },
                    0x99 => {// res 3,c
                        self.registers.reg_c = self.registers.reg_c & 0xf7;
                    },
                    0x9a => {// res 3,d
                        self.registers.reg_d = self.registers.reg_d & 0xf7;
                    },
                    0x9b => {// res 3,e
                        self.registers.reg_e = self.registers.reg_e & 0xf7;
                    },
                    0x9c => {// res 3,h
                        self.registers.reg_h = self.registers.reg_h & 0xf7;
                    },
                    0x9d => {// res 3,l
                        self.registers.reg_l = self.registers.reg_l & 0xf7;
                    },
                    0x9e => {// res 3,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xf7);
                    },
                    0x9f => {// res 3,a
                        self.registers.reg_a = self.registers.reg_a & 0xf7;
                    },
                    0xa0 => {// res 4,b
                        self.registers.reg_b = self.registers.reg_b & 0xef;
                    },
                    0xa1 => {// res 4,c
                        self.registers.reg_c = self.registers.reg_c & 0xef;
                    },
                    0xa2 => {// res 4,d
                        self.registers.reg_d = self.registers.reg_d & 0xef;
                    },
                    0xa3 => {// res 4,e
                        self.registers.reg_e = self.registers.reg_e & 0xef;
                    },
                    0xa4 => {// res 4,h
                        self.registers.reg_h = self.registers.reg_h & 0xef;
                    },
                    0xa5 => {// res 4,l
                        self.registers.reg_l = self.registers.reg_l & 0xef;
                    },
                    0xa6 => {// res 4,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xef);
                    },
                    0xa7 => {// res 4,a
                        self.registers.reg_a = self.registers.reg_a & 0xef;
                    },
                    0xa8 => {// res 5,b
                        self.registers.reg_b = self.registers.reg_b & 0xdf;
                    },
                    0xa9 => {// res 5,c
                        self.registers.reg_c = self.registers.reg_c & 0xdf;
                    },
                    0xaa => {// res 5,d
                        self.registers.reg_d = self.registers.reg_d & 0xdf;
                    },
                    0xab => {// res 5,e
                        self.registers.reg_e = self.registers.reg_e & 0xdf;
                    },
                    0xac => {// res 5,h
                        self.registers.reg_h = self.registers.reg_h & 0xdf;
                    },
                    0xad => {// res 5,l
                        self.registers.reg_l = self.registers.reg_l & 0xdf;
                    },
                    0xae => {// res 5,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xdf);
                    },
                    0xaf => {// res 5,a
                        self.registers.reg_a = self.registers.reg_a & 0xdf;
                    },
                    0xb0 => {// res 6,b
                        self.registers.reg_b = self.registers.reg_b & 0xbf;
                    },
                    0xb1 => {// res 6,c
                        self.registers.reg_c = self.registers.reg_c & 0xbf;
                    },
                    0xb2 => {// res 6,d
                        self.registers.reg_d = self.registers.reg_d & 0xbf;
                    },
                    0xb3 => {// res 6,e
                        self.registers.reg_e = self.registers.reg_e & 0xbf;
                    },
                    0xb4 => {// res 6,h
                        self.registers.reg_h = self.registers.reg_h & 0xbf;
                    },
                    0xb5 => {// res 6,l
                        self.registers.reg_l = self.registers.reg_l & 0xbf;
                    },
                    0xb6 => {// res 6,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0xbf);
                    },
                    0xb7 => {// res 6,a
                        self.registers.reg_a = self.registers.reg_a & 0xbf;
                    },
                    0xb8 => {// res 7,b
                        self.registers.reg_b = self.registers.reg_b & 0x7f;
                    },
                    0xb9 => {// res 7,c
                        self.registers.reg_c = self.registers.reg_c & 0x7f;
                    },
                    0xba => {// res 7,d
                        self.registers.reg_d = self.registers.reg_d & 0x7f;
                    },
                    0xbb => {// res 7,e
                        self.registers.reg_e = self.registers.reg_e & 0x7f;
                    },
                    0xbc => {// res 7,h
                        self.registers.reg_h = self.registers.reg_h & 0x7f;
                    },
                    0xbd => {// res 7,l
                        self.registers.reg_l = self.registers.reg_l & 0x7f;
                    },
                    0xbe => {// res 7,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl & 0x7f);
                    },
                    0xbf => {// res 7,a
                        self.registers.reg_a = self.registers.reg_a & 0x7f;
                    },
                    0xc0 => {// set 0,b
                        self.registers.reg_b = self.registers.reg_b | 0x01;
                    },
                    0xc1 => {// set 0,c
                        self.registers.reg_c = self.registers.reg_c | 0x01;
                    },
                    0xc2 => {// set 0,d
                        self.registers.reg_d = self.registers.reg_d | 0x01;
                    },
                    0xc3 => {// set 0,e
                        self.registers.reg_e = self.registers.reg_e | 0x01;
                    },
                    0xc4 => {// set 0,h
                        self.registers.reg_h = self.registers.reg_h | 0x01;
                    },
                    0xc5 => {// set 0,l
                        self.registers.reg_l = self.registers.reg_l | 0x01;
                    },
                    0xc6 => {// set 0,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x01);
                    },
                    0xc7 => {// set 0,a
                        self.registers.reg_a = self.registers.reg_a | 0x01;
                    },
                    0xc8 => {// set 1,b
                        self.registers.reg_b = self.registers.reg_b | 0x02;
                    },
                    0xc9 => {// set 1,c
                        self.registers.reg_c = self.registers.reg_c | 0x02;
                    },
                    0xca => {// set 1,d
                        self.registers.reg_d = self.registers.reg_d | 0x02;
                    },
                    0xcb => {// set 1,e
                        self.registers.reg_e = self.registers.reg_e | 0x02;
                    },
                    0xcc => {// set 1,h
                        self.registers.reg_h = self.registers.reg_h | 0x02;
                    },
                    0xcd => {// set 1,l
                        self.registers.reg_l = self.registers.reg_l | 0x02;
                    },
                    0xce => {// set 1,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x02);
                    },
                    0xcf => {// set 1,a
                        self.registers.reg_a = self.registers.reg_a | 0x02;
                    },
                    0xd0 => {// set 2,b
                        self.registers.reg_b = self.registers.reg_b | 0x04;
                    },
                    0xd1 => {// set 2,c
                        self.registers.reg_c = self.registers.reg_c | 0x04;
                    },
                    0xd2 => {// set 2,d
                        self.registers.reg_d = self.registers.reg_d | 0x04;
                    },
                    0xd3 => {// set 2,e
                        self.registers.reg_e = self.registers.reg_e | 0x04;
                    },
                    0xd4 => {// set 2,h
                        self.registers.reg_h = self.registers.reg_h | 0x04;
                    },
                    0xd5 => {// set 2,l
                        self.registers.reg_l = self.registers.reg_l | 0x04;
                    },
                    0xd6 => {// set 2,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x04);
                    },
                    0xd7 => {// set 2,a
                        self.registers.reg_a = self.registers.reg_a | 0x04;
                    },
                    0xd8 => {// set 3,b
                        self.registers.reg_b = self.registers.reg_b | 0x08;
                    },
                    0xd9 => {// set 3,c
                        self.registers.reg_c = self.registers.reg_c | 0x08;
                    },
                    0xda => {// set 3,d
                        self.registers.reg_d = self.registers.reg_d | 0x08;
                    },
                    0xdb => {// set 3,e
                        self.registers.reg_e = self.registers.reg_e | 0x08;
                    },
                    0xdc => {// set 3,h
                        self.registers.reg_h = self.registers.reg_h | 0x08;
                    },
                    0xdd => {// set 3,l
                        self.registers.reg_l = self.registers.reg_l | 0x08;
                    },
                    0xde => {// set 3,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x08);
                    },
                    0xdf => {// set 3,a
                        self.registers.reg_a = self.registers.reg_a | 0x08;
                    },
                    0xe0 => {// set 4,b
                        self.registers.reg_b = self.registers.reg_b | 0x10;
                    },
                    0xe1 => {// set 4,c
                        self.registers.reg_c = self.registers.reg_c | 0x10;
                    },
                    0xe2 => {// set 4,d
                        self.registers.reg_d = self.registers.reg_d | 0x10;
                    },
                    0xe3 => {// set 4,e
                        self.registers.reg_e = self.registers.reg_e | 0x10;
                    },
                    0xe4 => {// set 4,h
                        self.registers.reg_h = self.registers.reg_h | 0x10;
                    },
                    0xe5 => {// set 4,l
                        self.registers.reg_l = self.registers.reg_l | 0x10;
                    },
                    0xe6 => {// set 4,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x10);
                    },
                    0xe7 => {// set 4,a
                        self.registers.reg_a = self.registers.reg_a | 0x10;
                    },
                    0xe8 => {// set 5,b
                        self.registers.reg_b = self.registers.reg_b | 0x20;
                    },
                    0xe9 => {// set 5,c
                        self.registers.reg_c = self.registers.reg_c | 0x20;
                    },
                    0xea => {// set 5,d
                        self.registers.reg_d = self.registers.reg_d | 0x20;
                    },
                    0xeb => {// set 5,e
                        self.registers.reg_e = self.registers.reg_e | 0x20;
                    },
                    0xec => {// set 5,h
                        self.registers.reg_h = self.registers.reg_h | 0x20;
                    },
                    0xed => {// set 5,l
                        self.registers.reg_l = self.registers.reg_l | 0x20;
                    },
                    0xee => {// set 5,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x20);
                    },
                    0xef => {// set 5,a
                        self.registers.reg_a = self.registers.reg_a | 0x20;
                    },
                    0xf0 => {// set 6,b
                        self.registers.reg_b = self.registers.reg_b | 0x40;
                    },
                    0xf1 => {// set 6,c
                        self.registers.reg_c = self.registers.reg_c | 0x40;
                    },
                    0xf2 => {// set 6,d
                        self.registers.reg_d = self.registers.reg_d | 0x40;
                    },
                    0xf3 => {// set 6,e
                        self.registers.reg_e = self.registers.reg_e | 0x40;
                    },
                    0xf4 => {// set 6,h
                        self.registers.reg_h = self.registers.reg_h | 0x40;
                    },
                    0xf5 => {// set 6,l
                        self.registers.reg_l = self.registers.reg_l | 0x40;
                    },
                    0xf6 => {// set 6,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x40);
                    },
                    0xf7 => {// set 6,a
                        self.registers.reg_a = self.registers.reg_a | 0x40;
                    },
                    0xf8 => {// set 7,b
                        self.registers.reg_b = self.registers.reg_b | 0x80;
                    },
                    0xf9 => {// set 7,c
                        self.registers.reg_c = self.registers.reg_c | 0x80;
                    },
                    0xfa => {// set 7,d
                        self.registers.reg_d = self.registers.reg_d | 0x80;
                    },
                    0xfb => {// set 7,e
                        self.registers.reg_e = self.registers.reg_e | 0x80;
                    },
                    0xfc => {// set 7,h
                        self.registers.reg_h = self.registers.reg_h | 0x80;
                    },
                    0xfd => {// set 7,l
                        self.registers.reg_l = self.registers.reg_l | 0x80;
                    },
                    0xfe => {// set 7,(hl)
                        let hl = self.bus.read_mem(self.registers.get_hl());
                        self.bus.write_mem(self.registers.get_hl(), hl | 0x80);
                    },
                    0xff => {// set 7,a
                        self.registers.reg_a = self.registers.reg_a | 0x80;
                    },
                }
            },
            0xcc => {// call z,nn
                let nn = self.bus.read_mem_u16(pc);
                if self.registers.reg_f.z == true {
                    self.push_stack(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                }
            },
            0xcd => {// call nn
                let nn = self.bus.read_mem_u16(pc);
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = nn;
            },
            0xce => {// adc a,n
                let n = self.bus.read_mem(pc);
                self.add(n, true);
                pc += 1;
            },
            0xcf => {// rst 8h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0008;
            },
            0xd0 => {// ret nc
                if self.registers.reg_f.c == false {
                    self.pop_stack();
                }
            },
            0xd1 => {// pop de
                self.registers.set_de(self.bus.read_mem_u16(self.registers.reg_sp));
                self.registers.reg_sp += 2;
            },
            0xd2 => {// jp nc,$+3
                if self.registers.reg_f.c == false {
                    let nn = self.bus.read_mem_u16(pc);
                    self.registers.reg_pc = nn;
                } else {
                    pc += 2;
                }
            },
            0xd3 => {// out (n),a
                let n = self.bus.read_mem(pc);
                // TODO: implement output
                pc += 1;
            },
            0xd4 => {// call nc,nn
                let nn = self.bus.read_mem_u16(pc);
                if self.registers.reg_f.c == false {
                    self.push_stack(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                } else {
                    pc += 2;
                }
            },
            0xd5 => {// push de
                self.registers.reg_sp -= 2;
                self.bus.write_mem_u16(self.registers.reg_sp, self.registers.get_de());
            },
            0xd6 => {// sub n
                let n = self.bus.read_mem(pc);
                self.sub(n, false);
                pc += 1;
            },
            0xd7 => {// rst 10h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0010;
            },
            0xd8 => {// ret c
                if self.registers.reg_f.c == true {
                    self.pop_stack();
                }
            },
            0xd9 => {// exx
                let mut temp = self.registers.reg_b;
                self.registers.reg_b = self.alternate.reg_b;
                self.alternate.reg_b = temp;

                temp = self.registers.reg_c;
                self.registers.reg_c = self.alternate.reg_c;
                self.alternate.reg_c = temp;

                temp = self.registers.reg_d;
                self.registers.reg_d = self.alternate.reg_d;
                self.alternate.reg_d = temp;

                temp = self.registers.reg_e;
                self.registers.reg_e = self.alternate.reg_e;
                self.alternate.reg_e = temp;

                temp = self.registers.reg_h;
                self.registers.reg_h = self.alternate.reg_h;
                self.alternate.reg_h = temp;

                temp = self.registers.reg_l;
                self.registers.reg_l = self.alternate.reg_l;
                self.alternate.reg_l = temp;
            },
            0xda => {// jp c,$+3
                if self.registers.reg_f.c == true {
                    let nn = self.bus.read_mem_u16(pc);
                    self.registers.reg_pc = nn;
                } else {
                    pc += 2;
                }
            },
            0xdb => {// in a,(n)
                let n = self.bus.read_mem(pc);
                // TODO: implement input
                pc += 1;
            },
            0xdc => {// call c,nn
                if self.registers.reg_f.c == true {
                    let nn = self.bus.read_mem_u16(pc);
                    self.push_stack(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                }
                pc += 2;
            },
            0xdd => {
                let opcode = self.bus.read_mem(pc);
                pc += 1;
                match opcode {
                    0x09 => {// add ix,bc
                        let bc = self.registers.get_bc();
                        let ix = self.registers.get_ix();
                        let value = self.add16(ix, bc);
                        self.registers.set_ix(value);
                    },
                    0x19 => {// add ix,de
                        let de = self.registers.get_de();
                        let ix = self.registers.get_ix();
                        let value = self.add16(ix, de);
                        self.registers.set_ix(value);
                    },
                    0x21 => {// ld ix,nn
                        let nn = self.bus.read_mem_u16(pc);
                        self.registers.set_ix(nn);
                        pc += 2;
                    },
                    0x22 => {// ld (nn),ix
                        let nn = self.bus.read_mem_u16(pc);
                        self.bus.write_mem_u16(nn, self.registers.get_ix());
                        pc += 2;
                    },
                    0x23 => {// inc ix
                        let ix = self.registers.get_ix() + 1;
                        self.registers.set_ix(ix);
                    },
                    0x29 => {// add ix,ix
                        let ix = self.registers.get_ix();
                        let value = self.add16(ix, ix);
                        self.registers.set_ix(value);
                    },
                    0x2a => {// ld ix,(nn)
                        let nn = self.bus.read_mem_u16(pc);
                        self.registers.set_ix(nn);
                        pc += 2;
                    },
                    0x2b => {// dec ix
                        let ix = self.registers.get_ix().wrapping_sub(1);
                        self.registers.set_ix(ix);
                    },
                    0x34 => {// inc (ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.inc(value + n);
                        pc += 1;
                    },
                    0x35 => {// dec (ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.dec(value + n);
                        pc += 1;
                    },
                    0x36 => {// ld (ix+n),n
                        let ixn = self.bus.read_mem(pc);
                        let n = self.bus.read_mem(pc + 1);
                        self.bus.write_mem(self.registers.get_ix() + ixn as u16, n);
                        pc += 2;
                    },
                    0x39 => {// add ix,sp
                        let sp = self.registers.get_sp();
                        let ix = self.registers.get_ix();
                        let value = self.add16(ix, sp);
                        self.registers.set_ix(value);
                    },
                    0x46 => {// ld b,(ix+n)
                        let n = self.bus.read_mem(pc);
                        self.registers.reg_b = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        pc += 1;
                    },
                    0x4e => {// ld c,(ix+n)
                        let n = self.bus.read_mem(pc);
                        self.registers.reg_c = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        pc += 1;
                    },
                    0x56 => {// ld d,(ix+n)
                        let n = self.bus.read_mem(pc);
                        self.registers.reg_d = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        pc += 1;
                    },
                    0x5e => {// ld e,(ix+n)
                        let n = self.bus.read_mem(pc);
                        self.registers.reg_e = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        pc += 1;
                    },
                    0x66 => {// ld h,(ix+n)
                        let n = self.bus.read_mem(pc);
                        self.registers.reg_h = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        pc += 1;
                    },
                    0x6e => {// ld l,(ix+n)
                        let n = self.bus.read_mem(pc);
                        self.registers.reg_l = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        pc += 1;
                    },
                    0x70 => {// ld (ix+n),b
                        let n = self.bus.read_mem(pc);
                        self.bus.write_mem(self.registers.get_ix() + n as u16, self.registers.reg_b);
                        pc += 1;
                    },
                    0x71 => {// ld (ix+n),c
                        let n = self.bus.read_mem(pc);
                        self.bus.write_mem(self.registers.get_ix() + n as u16, self.registers.reg_c);
                        pc += 1;
                    },
                    0x72 => {// ld (ix+n),d
                        let n = self.bus.read_mem(pc);
                        self.bus.write_mem(self.registers.get_ix() + n as u16, self.registers.reg_d);
                        pc += 1;
                    },
                    0x73 => {// ld (ix+n),e
                        let n = self.bus.read_mem(pc);
                        self.bus.write_mem(self.registers.get_ix() + n as u16, self.registers.reg_e);
                        pc += 1;
                    },
                    0x74 => {// ld (ix+n),h
                        let n = self.bus.read_mem(pc);
                        self.bus.write_mem(self.registers.get_ix() + n as u16, self.registers.reg_h);
                        pc += 1;
                    },
                    0x75 => {// ld (ix+n),l
                        let n = self.bus.read_mem(pc);
                        self.bus.write_mem(self.registers.get_ix() + n as u16, self.registers.reg_l);
                        pc += 1;
                    },
                    0x77 => {// ld (ix+n),a
                        let n = self.bus.read_mem(pc);
                        self.bus.write_mem(self.registers.get_ix() + n as u16, self.registers.reg_a);
                        pc += 1;
                    },
                    0x7e => {// ld a,(ix+n)
                        let n = self.bus.read_mem(pc);
                        self.registers.reg_a = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        pc += 1;
                    },
                    0x86 => {// add a,(ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.add(value, false);
                        pc += 1;
                    },
                    0x8e => {// adc a,(ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.add(value, true);
                        pc += 1;
                    },
                    0x96 => {// sub (ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.sub(value, false);
                        pc += 1;
                    },
                    0x9e => {// sbc a,(ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.sub(value, true);
                        pc += 1;
                    },
                    0xa6 => {// and (ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.and(value);
                        pc += 1;
                    },
                    0xae => {// xor (ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.xor(value);
                        pc += 1;
                    },
                    0xb6 => {// or (ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.or(value);
                        pc += 1;
                    },
                    0xbe => {// cp (ix+n)
                        let n = self.bus.read_mem(pc);
                        let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                        self.cp(value);
                        pc += 1;
                    },
                    0xcb => {
                        let opcode = self.bus.read_mem(pc);
                        pc += 1;
                        match opcode {
                            0x06 => {// rlc (ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.rlc(value);
                                pc += 1;
                            },
                            0x0e => {// rrc (ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.rrc(value);
                                pc += 1;
                            },
                            0x16 => {// rl (ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.rl(value);
                                pc += 1;
                            },
                            0x1e => {// rr (ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.rr(value);
                                pc += 1;
                            },
                            0x26 => {// sla (ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.sla(value);
                                pc += 1;
                            },
                            0x2e => {// sra (ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.sra(value);
                                pc += 1;
                            },
                            0x46 => {// bit 0,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(0, value);
                                pc += 1;
                            },
                            0x4e => {// bit 1,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(1, value);
                                pc += 1;
                            },
                            0x56 => {// bit 2,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(2, value);
                                pc += 1;
                            },
                            0x5e => {// bit 3,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(3, value);
                                pc += 1;
                            },
                            0x66 => {// bit 4,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(4, value);
                                pc += 1;
                            },
                            0x6e => {// bit 5,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(5, value);
                                pc += 1;
                            },
                            0x76 => {// bit 6,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(6, value);
                                pc += 1;
                            },
                            0x7e => {// bit 7,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bit(7, value);
                                pc += 1;
                            },
                            0x86 => {// res 0,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(0, value);
                                pc += 1;
                            },
                            0x8e => {// res 1,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(1, value);
                                pc += 1;
                            },
                            0x96 => {// res 2,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(2, value);
                                pc += 1;
                            },
                            0x9e => {// res 3,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(3, value);
                                pc += 1;
                            },
                            0xa6 => {// res 4,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(4, value);
                                pc += 1;
                            },
                            0xae => {// res 5,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(5, value);
                                pc += 1;
                            },
                            0xb6 => {// res 6,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(6, value);
                                pc += 1;
                            },
                            0xbe => {// res 7,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.res(7, value);
                                pc += 1;
                            },
                            0xc6 => {// set 0,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus.write_mem(self.registers.get_ix() + n as u16, value | 0x01);
                                pc += 1;
                            },
                            0xce => {// set 1,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus.write_mem(self.registers.get_ix() + n as u16, value | 0x02);
                                pc += 1;
                            },
                            0xd6 => {// set 2,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus.write_mem(self.registers.get_ix() + n as u16, value | 0x04);
                                pc += 1;
                            },
                            0xde => {// set 3,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus.write_mem(self.registers.get_ix() + n as u16, value | 0x08);
                                pc += 1;
                            },
                            0xe6 => {// set 4,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus.write_mem(self.registers.get_ix() + n as u16, value | 0x10);
                                pc += 1;
                            },
                            0xee => {// set 5,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus.write_mem(self.registers.get_ix() + n as u16, value | 0x20);
                                pc += 1;
                            },
                            0xf6 => {// set 6,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus.write_mem(self.registers.get_ix() + n as u16, value | 0x40);
                                pc += 1;
                            },
                            0xfe => {// set 7,(ix+n)
                                let n = self.bus.read_mem(pc);
                                let value = self.bus.read_mem(self.registers.get_ix() + n as u16);
                                self.bus.write_mem(self.registers.get_ix() + n as u16, value | 0x80);
                                pc += 1;
                            },
                            _ => {
                                // Illegal opcode
                                panic!("Illegal opcode {:x}", self.registers.reg_pc);
                            }
                        }
                    },
                    0xe1 => {// pop ix
                        self.registers.set_ix(self.bus.read_mem_u16(self.registers.reg_sp));
                        self.registers.reg_sp += 2;
                    },
                    0xe3 => {// ex (sp),ix
                        let value = self.bus.read_mem_u16(self.registers.reg_sp);
                        self.bus.write_mem_u16(self.registers.reg_sp, self.registers.get_ix());
                        self.registers.set_ix(value);
                    },
                    0xe5 => {// push ix
                        self.registers.reg_sp -= 2;
                        self.bus.write_mem_u16(self.registers.reg_sp, self.registers.get_ix());
                    },
                    0xe9 => {// jp (ix)
                        let ix = self.bus.read_mem_u16(self.registers.get_ix());
                        self.registers.reg_pc = ix;
                    },
                    0xf9 => {// ld sp,ix
                        self.registers.reg_sp = self.registers.get_ix();
                    },
                    _ => {
                        // Illegal opcode
                        panic!("Illegal opcode {:x}", self.registers.reg_pc);
                    }
                }
            },
            0xde => {// sbc a,n
                let n = self.bus.read_mem(pc);
                self.sub(n, true);
            },
            0xdf => {// rst 18h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0018;
            },
            0xe0 => {// ret po
                if self.registers.reg_f.p == false {
                    self.pop_stack();
                }
            },
            0xe1 => {// pop hl
                self.registers.set_hl(self.bus.read_mem_u16(self.registers.reg_sp));
                self.registers.reg_sp += 2;
            },
            0xe2 => {// jp po,$+3
                if self.registers.reg_f.p == false {
                    let value = self.bus.read_mem_u16(pc);
                    self.registers.reg_pc = value;
                } else {
                    pc += 2;
                }
            },
            0xe3 => {// ex (sp),hl
                let value = self.bus.read_mem_u16(self.registers.reg_sp);
                self.bus.write_mem_u16(self.registers.reg_sp, self.registers.get_hl());
                self.registers.set_hl(value);
            },
            0xe4 => {// call po,nn
                if self.registers.reg_f.p == false {
                    let nn = self.bus.read_mem_u16(pc);
                    self.registers.reg_pc = nn;
                } else {
                    pc += 2;
                }
            },
            0xe5 => {// push hl
                self.registers.reg_sp -= 2;
                self.bus.write_mem_u16(self.registers.reg_sp, self.registers.get_hl());
            },
            0xe6 => {// and n
                let n = self.bus.read_mem(pc);
                self.and(n);
                pc += 1;
            },
            0xe7 => {// rst 20h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0020;
            },
            0xe8 => {// ret pe
                if self.registers.reg_f.p == true {
                    self.pop_stack();
                }
            },
            0xe9 => {// jp (hl)
                let hl = self.bus.read_mem_u16(self.registers.get_hl());
                self.registers.reg_pc = hl;
            },
            0xea => {// jp pe,$+3
                if self.registers.reg_f.p == true {
                    let value = self.bus.read_mem_u16(pc);
                    self.registers.reg_pc = value;
                } else {
                    pc += 2;
                }
            },
            0xeb => {// ex de,hl
                let hl = self.registers.get_hl();
                let de = self.registers.get_de();
                self.registers.set_hl(de);
                self.registers.set_de(hl);
            },
            0xec => {// call pe,nn
                if self.registers.reg_f.p == true {
                    let nn = self.bus.read_mem_u16(pc);
                    self.registers.reg_pc = nn;
                } else {
                    pc += 2;
                }
            },
            0xed => {
                let opcode = self.bus.read_mem(pc);
                match opcode {
                    0x40 => {// in b,(c)
                        // TODO
                    },
                    0x41 => {// out (c),b
                        // TODO
                    },
                    0x42 => {// sbc hl,bc
                        let bc = self.registers.get_bc();
                        let hl = self.registers.get_hl();
                        let value = self.sub(hl, bc);
                        self.registers.set_hl(value);
                    },
                    0x43 => {// ld (nn),bc
                        let nn = self.bus.read_mem_u16(pc);
                        self.bus.write_mem_u16(nn, self.registers.get_bc());
                        pc += 2;
                    },
                    0x44 => {// neg
                        let a = 0x100 - self.registers.reg_a as u16;
                        self.registers.reg_a = a as u8;
                    },
                    0x45 => {// retn
                    },
                    0x46 => {// im 0
                        self.im = 0;
                    },
                    0x47 => {// ld i,a
                    },
                    0x48 => {// in c,(c)
                        // TODO
                    },
                    0x49 => {// out (c),c
                        // TODO
                    },
                    0x4a => {// adc hl,bc
                    },
                    0x4b => {// ld bc,(nn)
                        let nn = self.bus.read_mem_u16(pc);
                        self.registers.set_bc(nn);
                        pc += 2;
                    },
                    0x4d => {// reti
                    },
                    0x50 => {// in d,(c)
                        // TODO
                    },
                    0x51 => {// out (c),d
                        // TODO
                    },
                    0x52 => {// sbc hl,de
                    },
                    0x53 => {// ld (nn),de
                        let nn = self.bus.read_mem_u16(pc);
                        self.bus.write_mem_u16(nn, self.registers.get_de());
                        pc += 2;
                    },
                    0x56 => {// im 1
                        self.im = 1;
                    },
                    0x57 => {// ld a,i
                    },
                    0x58 => {// in e,(c)
                        // TODO
                    },
                    0x59 => {// out (c),e
                        // TODO
                    },
                    0x5a => {// adc hl,de
                    },
                    0x5b => {// ld de,(nn)
                        let nn = self.bus.read_mem_u16(pc);
                        self.registers.set_de(nn);
                        pc += 2;
                    },
                    0x5e => {// im 2
                        self.im = 2;
                    },
                    0x60 => {// in h,(c)
                        // TODO
                    },
                    0x61 => {// out (c),h
                        // TODO
                    },
                    0x62 => {// sbc hl,hl
                    },
                    0x67 => {// rrd
                    },
                    0x68 => {// in l,(c)
                        // TODO
                    },
                    0x69 => {// out (c),l
                        // TODO
                    },
                    0x6a => {// adc hl,hl
                    },
                    0x6f => {// rld
                    },
                    0x72 => {// sbc hl,sp
                    },
                    0x73 => {// ld (nn),sp
                        let nn = self.bus.read_mem_u16(pc);
                        self.bus.write_mem_u16(nn, self.registers.get_sp());
                        pc += 2;
                    },
                    0x78 => {// in a,(c)
                        // TODO
                    },
                    0x79 => {// out (c),a
                        // TODO
                    },
                    0x7a => {// adc hl,sp
                    },
                    0x7b => {// ld sp,(nn)
                        let nn = self.bus.read_mem_u16(pc);
                        self.registers.set_sp(nn);
                        pc += 2;
                    },
                    0xa0 => {// ldi
                    },
                    0xa1 => {// cpi
                    },
                    0xa2 => {// ini
                        // TODO
                    },
                    0xa3 => {// outi
                        // TODO
                    },
                    0xa8 => {// ldd
                    },
                    0xa9 => {// cpd
                    },
                    0xaa => {// ind
                        // TODO
                    },
                    0xab => {// outd
                        // TODO
                    },
                    0xb0 => {// ldir
                    },
                    0xb1 => {// cpir
                    },
                    0xb2 => {// inir
                        // TODO
                    },
                    0xb3 => {// otir
                        // TODO
                    },
                    0xb8 => {// lddr
                    },
                    0xb9 => {// cpdr
                    },
                    0xba => {// indr
                        // TODO
                    },
                    0xbb => {// otdr
                        // TODO
                    },
                    _ => {
                        // Illegal opcode
                    }
                }
            },
            0xee => {// xor n
                let value = self.bus.read_mem(pc);
            },
            0xef => {// rst 28h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0028;
            },
            0xf0 => {// ret p
                if self.registers.reg_f.s == false {
                    self.pop_stack();
                }
            },
            0xf1 => {// pop af
                self.registers.reg_f = self.bus.read_mem(self.registers.reg_sp).into();
                self.registers.reg_a = self.bus.read_mem(self.registers.reg_sp+1);
                self.registers.reg_sp += 2;
            },
            0xf2 => {// jp p,$+3
            },
            0xf3 => {// di
                self.interrupts_enabled = false;
            },
            0xf4 => {// call p,nn
                let value = self.bus.read_mem_u16(pc);
                pc += 2;
            },
            0xf5 => {// push af
                self.registers.reg_sp -= 2;
                self.bus.write_mem(self.registers.reg_sp, self.registers.reg_f.to_byte());
                self.bus.write_mem(self.registers.reg_sp+1, self.registers.reg_a);
            },
            0xf6 => {// or n
                let value = self.bus.read_mem(pc);
            },
            0xf7 => {// rst 30h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0030;
            },
            0xf8 => {// ret m
                if self.registers.reg_f.s == true {
                    self.pop_stack();
                }
            },
            0xf9 => {// ld sp,hl
            },
            0xfa => {// jp m,$+3
            },
            0xfb => {// ei
                self.interrupts_enabled = true;
            },
            0xfc => {// call m,nn
                let value = self.bus.read_mem_u16(pc);
                // PC +=  n  n
            },
            0xfd => {
                let opcode = self.bus.read_mem(pc);
                match opcode {
                    0x09 => {// add iy,bc
                        let bc = self.registers.get_bc();
                        let iy = self.registers.get_iy();
                        let value = self.add16(iy, bc);
                        self.registers.set_iy(value);
                    },
                    0x19 => {// add iy,de
                        let de = self.registers.get_de();
                        let iy = self.registers.get_iy();
                        let value = self.add16(iy, de);
                        self.registers.set_iy(value);
                    },
                    0x21 => {// ld iy,nn
                        let nn = self.bus.read_mem_u16(pc);
                        self.registers.set_iy(nn);
                        pc += 2;
                    },
                    0x22 => {// ld (nn),iy
                        let nn = self.bus.read_mem_u16(pc);
                        self.bus.write_mem_u16(nn, self.registers.get_iy());
                        pc += 2;
                    },
                    0x23 => {// inc iy
                        let iy = self.registers.get_iy() + 1;
                        self.registers.set_iy(iy);
                    },
                    0x29 => {// add iy,iy
                        let iy = self.registers.get_iy();
                        let value = self.add16(iy, iy);
                        self.registers.set_iy(value);
                    },
                    0x2a => {// ld iy,(nn)
                        let nn = self.bus.read_mem_u16(pc);
                        self.registers.set_iy(nn);
                        pc += 2;
                    },
                    0x2b => {// dec iy
                        let iy = self.registers.get_iy().wrapping_sub(1);
                        self.registers.set_iy(iy);
                    },
                    0x34 => {// inc (iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x35 => {// dec (iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x36 => {// ld (iy+n),n
                        let value = self.bus.read_mem(pc);
                        pc += 2;
                    },
                    0x39 => {// add iy,sp
                        let sp = self.registers.get_sp();
                        let iy = self.registers.get_iy();
                        let value = self.add16(iy, sp);
                        self.registers.set_iy(value);
                    },
                    0x46 => {// ld b,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x4e => {// ld c,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x56 => {// ld d,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x5e => {// ld e,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x66 => {// ld h,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x6e => {// ld l,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x70 => {// ld (iy+n),b
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x71 => {// ld (iy+n),c
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x72 => {// ld (iy+n),d
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x73 => {// ld (iy+n),e
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x74 => {// ld (iy+n),h
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x75 => {// ld (iy+n),l
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x77 => {// ld (iy+n),a
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x7e => {// ld a,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x86 => {// add a,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x8e => {// adc a,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x96 => {// sub (iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0x9e => {// sbc a,(iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0xa6 => {// and (iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0xae => {// xor (iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0xb6 => {// or (iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },
                    0xbe => {// cp (iy+n)
                        let value = self.bus.read_mem(pc);
                        pc += 1;
                    },

                    0xcb => {
                        let value = self.bus.read_mem(pc+1);
                        let opcode = self.bus.read_mem(pc+2);
                        match opcode {
                            0x06 => {// rlc (iy+n)
                                pc += 1;
                            },
                            0x0e => {// rrc (iy+n)
                                pc += 1;
                            },
                            0x16 => {// rl (iy+n)
                                pc += 1;
                            },
                            0x1e => {// rr (iy+n)
                                pc += 1;
                            },
                            0x26 => {// sla (iy+n)
                                pc += 1;
                            },
                            0x2e => {// sra (iy+n)
                                pc += 1;
                            },
                            0x46 => {// bit 0,(iy+n)
                                pc += 1;
                            },
                            0x4e => {// bit 1,(iy+n)
                                pc += 1;
                            },
                            0x56 => {// bit 2,(iy+n)
                                pc += 1;
                            },
                            0x5e => {// bit 3,(iy+n)
                                pc += 1;
                            },
                            0x66 => {// bit 4,(iy+n)
                                pc += 1;
                            },
                            0x6e => {// bit 5,(iy+n)
                                pc += 1;
                            },
                            0x76 => {// bit 6,(iy+n)
                                pc += 1;
                            },
                            0x7e => {// bit 7,(iy+n)
                                pc += 1;
                            },
                            0x86 => {// res 0,(iy+n)
                                pc += 1;
                            },
                            0x8e => {// res 1,(iy+n)
                                pc += 1;
                            },
                            0x96 => {// res 2,(iy+n)
                                pc += 1;
                            },
                            0x9e => {// res 3,(iy+n)
                                pc += 1;
                            },
                            0xa6 => {// res 4,(iy+n)
                                pc += 1;
                            },
                            0xae => {// res 5,(iy+n)
                                pc += 1;
                            },
                            0xb6 => {// res 6,(iy+n)
                                pc += 1;
                            },
                            0xbe => {// res 7,(iy+n)
                                pc += 1;
                            },
                            0xc6 => {// set 0,(iy+n)
                                pc += 1;
                            },
                            0xce => {// set 1,(iy+n)
                                pc += 1;
                            },
                            0xd6 => {// set 2,(iy+n)
                                pc += 1;
                            },
                            0xde => {// set 3,(iy+n)
                                pc += 1;
                            },
                            0xe6 => {// set 4,(iy+n)
                                pc += 1;
                            },
                            0xee => {// set 5,(iy+n)
                                pc += 1;
                            },
                            0xf6 => {// set 6,(iy+n)
                                pc += 1;
                            },
                            0xfe => {// set 7,(iy+n)
                                pc += 1;
                            },
                            _ => {
                                // Illegal opcode
                                panic!("Illegal opcode {:x}", self.registers.reg_pc);
                            }
                        }
                    },
                    0xe1 => {// pop iy
                        self.registers.set_iy(self.bus.read_mem_u16(self.registers.reg_sp));
                        self.registers.reg_sp += 2;
                    },
                    0xe3 => {// ex (sp),iy
                        let value = self.bus.read_mem_u16(self.registers.reg_sp);
                        self.bus.write_mem_u16(self.registers.reg_sp, self.registers.get_iy());
                        self.registers.set_iy(value);
                    },
                    0xe5 => {// push iy
                        self.registers.reg_sp -= 2;
                        self.bus.write_mem_u16(self.registers.reg_sp, self.registers.get_iy());
                    },
                    0xe9 => {// jp (iy)
                    },
                    0xf9 => {// ld sp,iy
                        self.registers.reg_sp = self.registers.get_iy();
                    },
                    _ => {
                        // Illegal opcode
                        panic!("Illegal opcode {:x}", self.registers.reg_pc);
                    }
                }
            },
            0xfe => {// cp n
                let n = self.bus.read_mem(pc);
                self.cp(n);
                pc += 1;
            },
            0xff => {// rst 38h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0038;
            },
        }
        pc
    }

    pub fn run(&mut self) {
    }

    pub fn step2(&mut self) {
    }

    /// Step one instruction at a time
    ///
    /// This function executes one instruction at a time.
    pub fn step(&mut self) {
        let mut pc = self.registers.reg_pc;

        match self.bus.read_mem(pc) {
            // 8-Bit Load Group
            0x06 => {                                   // LD B,n
                let data = self.bus.read_mem(pc+1);
                self.registers.reg_b = data;
                pc += 2;
            }
            0x0e => {                                   // LD C,n
                let data = self.bus.read_mem(pc+1);
                self.registers.reg_c = data;
                pc += 2;
            }
            0x16 => {                                   // LD D,n
                let data = self.bus.read_mem(pc+1);
                self.registers.reg_d = data;
                pc += 2;
            }
            0x1e => {                                   // LD E,n
                let data = self.bus.read_mem(pc+1);
                self.registers.reg_e = data;
                pc += 2;
            }
            0x26 => {                                   // LD H,n
                let data = self.bus.read_mem(pc+1);
                self.registers.reg_h = data;
                pc += 2;
            }
            0x2e => {                                   // LD L,n
                let data = self.bus.read_mem(pc+1);
                self.registers.reg_l = data;
                pc += 2;
            }
            0x3e => {                                   // LD A,n
                let data = self.bus.read_mem(pc+1);
                self.registers.reg_a = data;
                pc += 2;
            }
            0x40 => {                                   // LD B,B'
                let t = self.registers.reg_b;
                self.registers.reg_b = self.alternate.reg_b;
                self.alternate.reg_b = t;
                pc += 1;
            }
            0x7f => {                                   // LD A,A'
                let t = self.registers.reg_a;
                self.registers.reg_a = self.alternate.reg_a;
                self.alternate.reg_a = t;
                pc += 1;
            }

            0xd9 => {                                   // EXX
                let temp_bc = self.registers.get_bc();
                let temp_de = self.registers.get_de();
                let temp_hl = self.registers.get_hl();
                let temp_abc = self.alternate.get_bc();
                let temp_ade = self.alternate.get_de();
                let temp_ahl = self.alternate.get_hl();
                self.registers.set_bc(temp_abc);
                self.registers.set_de(temp_ade);
                self.registers.set_hl(temp_ahl);
                self.alternate.set_bc(temp_bc);
                self.alternate.set_de(temp_de);
                self.alternate.set_hl(temp_hl);
                pc += 1;
            }
            0x00 => {                                   // NOP
                pc += 1;
            }
            _ => {
                println!("Opcode not yet implemented");
            }
        }

        self.registers.reg_pc = pc;
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

    #[test]
    fn testing_abs() {
        let value = Cpu::abs(0xfe);
        assert_eq!(value, 0x02);
    }

    #[test]
    fn testing_cpu() {
        let mut bus = Bus::new(16384);
        let code = vec![0x3e, 0xff, 0x06, 0x80, 0x0e, 0xaa, 0x16, 0x55, 0x1e, 0x10, 0x26, 0x20, 0x2e, 0x40, 0xd9];
        for (address, opcode) in code.iter().enumerate() {
            bus.write_mem(address as u16, *opcode);
        }
        let mut cpu = Cpu::new(bus);
        cpu.steps(7);
        assert_ne!(cpu.registers.reg_a, 0x00);
        assert_ne!(cpu.registers.reg_b, 0x00);
        assert_ne!(cpu.registers.reg_c, 0x00);
        assert_ne!(cpu.registers.reg_d, 0x00);
        assert_ne!(cpu.registers.reg_e, 0x00);
        assert_ne!(cpu.registers.reg_h, 0x00);
        assert_ne!(cpu.registers.reg_l, 0x00);

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
    }
}

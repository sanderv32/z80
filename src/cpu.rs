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

    // fn add(&mut self, r1: u8) -> u8 {
    //     let a = self.registers.reg_a;
    //     let value = a.wrapping_add(r1);
    //     self.registers.reg_f.s = (value as i8) < 0;
    //     self.registers.reg_f.z = value == 0;
    //     self.registers.reg_f.h = (value & 0x0f) + (a & 0x0f) > 0x0f;
    //     self.registers.reg_f.c = u16::from(a) + u16::from(r1) > 0xff;
    //     self.registers.reg_f.p = (a as i8).overflowing_add(value as i8).1;
    //     self.registers.reg_f.n = false;
    //     value
    // }

    fn add(&mut self, r1: u8, with_carry: bool) -> u8 {
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
        value
    }

    fn add16(&mut self, r1: u16, r2: u16) -> u16 {
        let v = r1.wrapping_add(r2);
        self.registers.reg_f.c = u32::from(r1) + u32::from(r2) > 0xffff;
        self.registers.reg_f.h = (r1 & 0x0fff) + (r2 & 0x0fff) > 0x0fff;
        self.registers.reg_f.n = false;
        v
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
            },
            0x8f => {// adc a,a
                self.add(self.registers.reg_a, true);
            },
            0x90 => {// sub b
            },
            0x91 => {// sub c
            },
            0x92 => {// sub d
            },
            0x93 => {// sub e
            },
            0x94 => {// sub h
            },
            0x95 => {// sub l
            },
            0x96 => {// sub (hl)
            },
            0x97 => {// sub a
            },
            0x98 => {// sbc b
            },
            0x99 => {// sbc c
            },
            0x9a => {// sbc d
            },
            0x9b => {// sbc e
            },
            0x9c => {// sbc h
            },
            0x9d => {// sbc l
            },
            0x9e => {// sbc (hl)
            },
            0x9f => {// sbc a
            },
            0xa0 => {// and b
            },
            0xa1 => {// and c
            },
            0xa2 => {// and d
            },
            0xa3 => {// and e
            },
            0xa4 => {// and h
            },
            0xa5 => {// and l
            },
            0xa6 => {// and (hl)
            },
            0xa7 => {// and a
            },
            0xa8 => {// xor b
            },
            0xa9 => {// xor c
            },
            0xaa => {// xor d
            },
            0xab => {// xor e
            },
            0xac => {// xor h
            },
            0xad => {// xor l
            },
            0xae => {// xor (hl)
            },
            0xaf => {// xor a
            },
            0xb0 => {// or b
            },
            0xb1 => {// or c
            },
            0xb2 => {// or d
            },
            0xb3 => {// or e
            },
            0xb4 => {// or h
            },
            0xb5 => {// or l
            },
            0xb6 => {// or (hl)
            },
            0xb7 => {// or a
            },
            0xb8 => {// cp b
            },
            0xb9 => {// cp c
            },
            0xba => {// cp d
            },
            0xbb => {// cp e
            },
            0xbc => {// cp h
            },
            0xbd => {// cp l
            },
            0xbe => {// cp (hl)
            },
            0xbf => {// cp a
            },
            0xc0 => {// ret nz
            },
            0xc1 => {// pop bc
            },
            0xc2 => {// jp nz,$+3
            },
            0xc3 => {// jp $+3
            },
            0xc4 => {// call nz,nn
                // PC += 3
            },
            0xc5 => {// push bc
            },
            0xc6 => {// add a,n
                // PC += 2
            },
            0xc7 => {// rst 0
            },
            0xc8 => {// ret z
            },
            0xc9 => {// ret
            },
            0xca => {// jp z,$+3
            },
            0xcb => {
                let opcode = self.bus.read_mem(pc);
                match opcode {
                    0x00 => {// rlc b
                    },
                    0x01 => {// rlc c
                    },
                    0x02 => {// rlc d
                    },
                    0x03 => {// rlc e
                    },
                    0x04 => {// rlc h
                    },
                    0x05 => {// rlc l
                    },
                    0x06 => {// rlc (hl)
                    },
                    0x07 => {// rlc a
                    },
                    0x08 => {// rrc b
                    },
                    0x09 => {// rrc c
                    },
                    0x0a => {// rrc d
                    },
                    0x0b => {// rrc e
                    },
                    0x0c => {// rrc h
                    },
                    0x0d => {// rrc l
                    },
                    0x0e => {// rrc (hl)
                    },
                    0x0f => {// rrc a
                    },
                    0x10 => {// rl  b
                    },
                    0x11 => {// rl  c
                    },
                    0x12 => {// rl  d
                    },
                    0x13 => {// rl  e
                    },
                    0x14 => {// rl  h
                    },
                    0x15 => {// rl  l
                    },
                    0x16 => {// rl  (hl)
                    },
                    0x17 => {// rl  a
                    },
                    0x18 => {// rr  b
                    },
                    0x19 => {// rr  c
                    },
                    0x1a => {// rr  d
                    },
                    0x1b => {// rr  e
                    },
                    0x1c => {// rr  h
                    },
                    0x1d => {// rr  l
                    },
                    0x1e => {// rr  (hl)
                    },
                    0x1f => {// rr  a
                    },
                    0x20 => {// sla b
                    },
                    0x21 => {// sla c
                    },
                    0x22 => {// sla d
                    },
                    0x23 => {// sla e
                    },
                    0x24 => {// sla h
                    },
                    0x25 => {// sla l
                    },
                    0x26 => {// sla (hl)
                    },
                    0x27 => {// sla a
                    },
                    0x28 => {// sra b
                    },
                    0x29 => {// sra c
                    },
                    0x2a => {// sra d
                    },
                    0x2b => {// sra e
                    },
                    0x2c => {// sra h
                    },
                    0x2d => {// sra l
                    },
                    0x2e => {// sra (hl)
                    },
                    0x2f => {// sra a
                    },
                    0x38 => {// srl b
                    },
                    0x39 => {// srl c
                    },
                    0x3a => {// srl d
                    },
                    0x3b => {// srl e
                    },
                    0x3c => {// srl h
                    },
                    0x3d => {// srl l
                    },
                    0x3e => {// srl (hl)
                    },
                    0x3f => {// srl a
                    },
                    0x40 => {// bit 0,b
                    },
                    0x41 => {// bit 0,c
                    },
                    0x42 => {// bit 0,d
                    },
                    0x43 => {// bit 0,e
                    },
                    0x44 => {// bit 0,h
                    },
                    0x45 => {// bit 0,l
                    },
                    0x46 => {// bit 0,(hl)
                    },
                    0x47 => {// bit 0,a
                    },
                    0x48 => {// bit 1,b
                    },
                    0x49 => {// bit 1,c
                    },
                    0x4a => {// bit 1,d
                    },
                    0x4b => {// bit 1,e
                    },
                    0x4c => {// bit 1,h
                    },
                    0x4d => {// bit 1,l
                    },
                    0x4e => {// bit 1,(hl)
                    },
                    0x4f => {// bit 1,a
                    },
                    0x50 => {// bit 2,b
                    },
                    0x51 => {// bit 2,c
                    },
                    0x52 => {// bit 2,d
                    },
                    0x53 => {// bit 2,e
                    },
                    0x54 => {// bit 2,h
                    },
                    0x55 => {// bit 2,l
                    },
                    0x56 => {// bit 2,(hl)
                    },
                    0x57 => {// bit 2,a
                    },
                    0x58 => {// bit 3,b
                    },
                    0x59 => {// bit 3,c
                    },
                    0x5a => {// bit 3,d
                    },
                    0x5b => {// bit 3,e
                    },
                    0x5c => {// bit 3,h
                    },
                    0x5d => {// bit 3,l
                    },
                    0x5e => {// bit 3,(hl)
                    },
                    0x5f => {// bit 3,a
                    },
                    0x60 => {// bit 4,b
                    },
                    0x61 => {// bit 4,c
                    },
                    0x62 => {// bit 4,d
                    },
                    0x63 => {// bit 4,e
                    },
                    0x64 => {// bit 4,h
                    },
                    0x65 => {// bit 4,l
                    },
                    0x66 => {// bit 4,(hl)
                    },
                    0x67 => {// bit 4,a
                    },
                    0x68 => {// bit 5,b
                    },
                    0x69 => {// bit 5,c
                    },
                    0x6a => {// bit 5,d
                    },
                    0x6b => {// bit 5,e
                    },
                    0x6c => {// bit 5,h
                    },
                    0x6d => {// bit 5,l
                    },
                    0x6e => {// bit 5,(hl)
                    },
                    0x6f => {// bit 5,a
                    },
                    0x70 => {// bit 6,b
                    },
                    0x71 => {// bit 6,c
                    },
                    0x72 => {// bit 6,d
                    },
                    0x73 => {// bit 6,e
                    },
                    0x74 => {// bit 6,h
                    },
                    0x75 => {// bit 6,l
                    },
                    0x76 => {// bit 6,(hl)
                    },
                    0x77 => {// bit 6,a
                    },
                    0x78 => {// bit 7,b
                    },
                    0x79 => {// bit 7,c
                    },
                    0x7a => {// bit 7,d
                    },
                    0x7b => {// bit 7,e
                    },
                    0x7c => {// bit 7,h
                    },
                    0x7d => {// bit 7,l
                    },
                    0x7e => {// bit 7,(hl)
                    },
                    0x7f => {// bit 7,a
                    },
                    0x80 => {// res 0,b
                    },
                    0x81 => {// res 0,c
                    },
                    0x82 => {// res 0,d
                    },
                    0x83 => {// res 0,e
                    },
                    0x84 => {// res 0,h
                    },
                    0x85 => {// res 0,l
                    },
                    0x86 => {// res 0,(hl)
                    },
                    0x87 => {// res 0,a
                    },
                    0x88 => {// res 1,b
                    },
                    0x89 => {// res 1,c
                    },
                    0x8a => {// res 1,d
                    },
                    0x8b => {// res 1,e
                    },
                    0x8c => {// res 1,h
                    },
                    0x8d => {// res 1,l
                    },
                    0x8e => {// res 1,(hl)
                    },
                    0x8f => {// res 1,a
                    },
                    0x90 => {// res 2,b
                    },
                    0x91 => {// res 2,c
                    },
                    0x92 => {// res 2,d
                    },
                    0x93 => {// res 2,e
                    },
                    0x94 => {// res 2,h
                    },
                    0x95 => {// res 2,l
                    },
                    0x96 => {// res 2,(hl)
                    },
                    0x97 => {// res 2,a
                    },
                    0x98 => {// res 3,b
                    },
                    0x99 => {// res 3,c
                    },
                    0x9a => {// res 3,d
                    },
                    0x9b => {// res 3,e
                    },
                    0x9c => {// res 3,h
                    },
                    0x9d => {// res 3,l
                    },
                    0x9e => {// res 3,(hl)
                    },
                    0x9f => {// res 3,a
                    },
                    0xa0 => {// res 4,b
                    },
                    0xa1 => {// res 4,c
                    },
                    0xa2 => {// res 4,d
                    },
                    0xa3 => {// res 4,e
                    },
                    0xa4 => {// res 4,h
                    },
                    0xa5 => {// res 4,l
                    },
                    0xa6 => {// res 4,(hl)
                    },
                    0xa7 => {// res 4,a
                    },
                    0xa8 => {// res 5,b
                    },
                    0xa9 => {// res 5,c
                    },
                    0xaa => {// res 5,d
                    },
                    0xab => {// res 5,e
                    },
                    0xac => {// res 5,h
                    },
                    0xad => {// res 5,l
                    },
                    0xae => {// res 5,(hl)
                    },
                    0xaf => {// res 5,a
                    },
                    0xb0 => {// res 6,b
                    },
                    0xb1 => {// res 6,c
                    },
                    0xb2 => {// res 6,d
                    },
                    0xb3 => {// res 6,e
                    },
                    0xb4 => {// res 6,h
                    },
                    0xb5 => {// res 6,l
                    },
                    0xb6 => {// res 6,(hl)
                    },
                    0xb7 => {// res 6,a
                    },
                    0xb8 => {// res 7,b
                    },
                    0xb9 => {// res 7,c
                    },
                    0xba => {// res 7,d
                    },
                    0xbb => {// res 7,e
                    },
                    0xbc => {// res 7,h
                    },
                    0xbd => {// res 7,l
                    },
                    0xbe => {// res 7,(hl)
                    },
                    0xbf => {// res 7,a
                    },
                    0xc0 => {// set 0,b
                    },
                    0xc1 => {// set 0,c
                    },
                    0xc2 => {// set 0,d
                    },
                    0xc3 => {// set 0,e
                    },
                    0xc4 => {// set 0,h
                    },
                    0xc5 => {// set 0,l
                    },
                    0xc6 => {// set 0,(hl)
                    },
                    0xc7 => {// set 0,a
                    },
                    0xc8 => {// set 1,b
                    },
                    0xc9 => {// set 1,c
                    },
                    0xca => {// set 1,d
                    },
                    0xcb => {// set 1,e
                    },
                    0xcc => {// set 1,h
                    },
                    0xcd => {// set 1,l
                    },
                    0xce => {// set 1,(hl)
                    },
                    0xcf => {// set 1,a
                    },
                    0xd0 => {// set 2,b
                    },
                    0xd1 => {// set 2,c
                    },
                    0xd2 => {// set 2,d
                    },
                    0xd3 => {// set 2,e
                    },
                    0xd4 => {// set 2,h
                    },
                    0xd5 => {// set 2,l
                    },
                    0xd6 => {// set 2,(hl)
                    },
                    0xd7 => {// set 2,a
                    },
                    0xd8 => {// set 3,b
                    },
                    0xd9 => {// set 3,c
                    },
                    0xda => {// set 3,d
                    },
                    0xdb => {// set 3,e
                    },
                    0xdc => {// set 3,h
                    },
                    0xdd => {// set 3,l
                    },
                    0xde => {// set 3,(hl)
                    },
                    0xdf => {// set 3,a
                    },
                    0xe0 => {// set 4,b
                    },
                    0xe1 => {// set 4,c
                    },
                    0xe2 => {// set 4,d
                    },
                    0xe3 => {// set 4,e
                    },
                    0xe4 => {// set 4,h
                    },
                    0xe5 => {// set 4,l
                    },
                    0xe6 => {// set 4,(hl)
                    },
                    0xe7 => {// set 4,a
                    },
                    0xe8 => {// set 5,b
                    },
                    0xe9 => {// set 5,c
                    },
                    0xea => {// set 5,d
                    },
                    0xeb => {// set 5,e
                    },
                    0xec => {// set 5,h
                    },
                    0xed => {// set 5,l
                    },
                    0xee => {// set 5,(hl)
                    },
                    0xef => {// set 5,a
                    },
                    0xf0 => {// set 6,b
                    },
                    0xf1 => {// set 6,c
                    },
                    0xf2 => {// set 6,d
                    },
                    0xf3 => {// set 6,e
                    },
                    0xf4 => {// set 6,h
                    },
                    0xf5 => {// set 6,l
                    },
                    0xf6 => {// set 6,(hl)
                    },
                    0xf7 => {// set 6,a
                    },
                    0xf8 => {// set 7,b
                    },
                    0xf9 => {// set 7,c
                    },
                    0xfa => {// set 7,d
                    },
                    0xfb => {// set 7,e
                    },
                    0xfc => {// set 7,h
                    },
                    0xfd => {// set 7,l
                    },
                    0xfe => {// set 7,(hl)
                    },
                    0xff => {// set 7,a
                    },
                    _ => {
                        // Illegal opcode
                    }
                }
            },
            0xcc => {// call z,nn
                let value = self.bus.read_mem_u16(pc);
                // PC += 3
            },
            0xcd => {// call nn
                let value = self.bus.read_mem_u16(pc);
                // PC += 3
            },
            0xce => {// adc a,n
                let value = self.bus.read_mem(pc);
                // PC += 2
            },
            0xcf => {// rst 8h
            },
            0xd0 => {// ret nc
            },
            0xd1 => {// pop de
            },
            0xd2 => {// jp nc,$+3
            },
            0xd3 => {// out (n),a
                let value = self.bus.read_mem(pc);
                // PC += 2
            },
            0xd4 => {// call nc,nn
                let value = self.bus.read_mem_u16(pc);
                // PC += 3
            },
            0xd5 => {// push de
            },
            0xd6 => {// sub n
                let value = self.bus.read_mem(pc);
                // PC += 2
            },
            0xd7 => {// rst 10h
            },
            0xd8 => {// ret c
            },
            0xd9 => {// en
            },
            0xda => {// jp c,$+3
            },
            0xdb => {// in a,(n)
                let value = self.bus.read_mem(pc);
                // PC += 2
            },
            0xdc => {// call c,nn
                let value = self.bus.read_mem_u16(pc);
                // PC += 3
            },
            0xdd => {
                let opcode = self.bus.read_mem(pc);
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
                        let value = self.bus.read_mem(pc);
                    },
                    0x35 => {// dec (ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x36 => {// ld (ix+n),n
                        let value = self.bus.read_mem(pc);
                        // PC +=  n  n
                    },
                    0x39 => {// add ix,sp
                        let sp = self.registers.get_sp();
                        let ix = self.registers.get_ix();
                        let value = self.add16(ix, sp);
                        self.registers.set_ix(value);
                    },
                    0x46 => {// ld b,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x4e => {// ld c,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x56 => {// ld d,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x5e => {// ld e,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x66 => {// ld h,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x6e => {// ld l,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x70 => {// ld (ix+n),b
                        let value = self.bus.read_mem(pc);
                    },
                    0x71 => {// ld (ix+n),c
                        let value = self.bus.read_mem(pc);
                    },
                    0x72 => {// ld (ix+n),d
                        let value = self.bus.read_mem(pc);
                    },
                    0x73 => {// ld (ix+n),e
                        let value = self.bus.read_mem(pc);
                    },
                    0x74 => {// ld (ix+n),h
                        let value = self.bus.read_mem(pc);
                    },
                    0x75 => {// ld (ix+n),l
                        let value = self.bus.read_mem(pc);
                    },
                    0x77 => {// ld (ix+n),a
                        let value = self.bus.read_mem(pc);
                    },
                    0x7e => {// ld a,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x86 => {// add a,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x8e => {// adc a,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x96 => {// sub (ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x9e => {// sbc a,(ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0xa6 => {// and (ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0xae => {// xor (ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0xb6 => {// or (ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0xbe => {// cp (ix+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0xcb => {
                        let value = self.bus.read_mem(pc+1);
                        match self.bus.read_mem(pc+2) {
                            0x06 => {// rlc (ix+n)
                            },
                            0x0e => {// rrc (ix+n)
                            },
                            0x16 => {// rl (ix+n)
                            },
                            0x1e => {// rr (ix+n)
                            },
                            0x26 => {// sla (ix+n)
                            },
                            0x2e => {// sra (ix+n)
                            },
                            0x46 => {// bit 0,(ix+n)
                            },
                            0x4e => {// bit 1,(ix+n)
                            },
                            0x56 => {// bit 2,(ix+n)
                            },
                            0x5e => {// bit 3,(ix+n)
                            },
                            0x66 => {// bit 4,(ix+n)
                            },
                            0x6e => {// bit 5,(ix+n)
                            },
                            0x76 => {// bit 6,(ix+n)
                            },
                            0x7e => {// bit 7,(ix+n)
                            },
                            0x86 => {// res 0,(ix+n)
                            },
                            0x8e => {// res 1,(ix+n)
                            },
                            0x96 => {// res 2,(ix+n)
                            },
                            0x9e => {// res 3,(ix+n)
                            },
                            0xa6 => {// res 4,(ix+n)
                            },
                            0xae => {// res 5,(ix+n)
                            },
                            0xb6 => {// res 6,(ix+n)
                            },
                            0xbe => {// res 7,(ix+n)
                            },
                            0xc6 => {// set 0,(ix+n)
                            },
                            0xce => {// set 1,(ix+n)
                            },
                            0xd6 => {// set 2,(ix+n)
                            },
                            0xde => {// set 3,(ix+n)
                            },
                            0xe6 => {// set 4,(ix+n)
                            },
                            0xee => {// set 5,(ix+n)
                            },
                            0xf6 => {// set 6,(ix+n)
                            },
                            0xfe => {// set 7,(ix+n)
                            },
                            _ => {
                                // Illegal opcode
                            }
                        }
                    },
                    0xe1 => {// pop ix
                    },
                    0xe3 => {// ex (sp),ix
                    },
                    0xe5 => {// push ix
                    },
                    0xe9 => {// jp (ix)
                    },
                    0xf9 => {// ld sp,ix
                    },
                    _ => {
                        // Illegal opcode
                    }
                }
            },
            0xde => {// sbc a,n
                let value = self.bus.read_mem(pc);
            },
            0xdf => {// rst 18h
            },
            0xe0 => {// ret po
            },
            0xe1 => {// pop hl
            },
            0xe2 => {// jp po,$+3
            },
            0xe3 => {// ex (sp),hl
            },
            0xe4 => {// call po,nn
                let value = self.bus.read_mem_u16(pc);
                // PC +=  n  n
            },
            0xe5 => {// push hl
            },
            0xe6 => {// and n
                let value = self.bus.read_mem(pc);
            },
            0xe7 => {// rst 20h
            },
            0xe8 => {// ret pe
            },
            0xe9 => {// jp (hl)
            },
            0xea => {// jp pe,$+3
            },
            0xeb => {// ex de,hl
            },
            0xec => {// call pe,nn
                // PC +=  n  n
            },
            0xed => {
                let opcode = self.bus.read_mem(pc);
                match opcode {
                    0x40 => {// in b,(c)
                    },
                    0x41 => {// out (c),b
                    },
                    0x42 => {// sbc hl,bc
                    },
                    0x43 => {// ld (nn),bc
                        let nn = self.bus.read_mem_u16(pc);
                        self.bus.write_mem_u16(nn, self.registers.get_bc());
                        pc += 2;
                    },
                    0x44 => {// neg
                    },
                    0x45 => {// retn
                    },
                    0x46 => {// im 0
                    },
                    0x47 => {// ld i,a
                    },
                    0x48 => {// in c,(c)
                    },
                    0x49 => {// out (c),c
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
                    },
                    0x51 => {// out (c),d
                    },
                    0x52 => {// sbc hl,de
                    },
                    0x53 => {// ld (nn),de
                        let nn = self.bus.read_mem_u16(pc);
                        self.bus.write_mem_u16(nn, self.registers.get_de());
                        pc += 2;
                    },
                    0x56 => {// im 1
                    },
                    0x57 => {// ld a,i
                    },
                    0x58 => {// in e,(c)
                    },
                    0x59 => {// out (c),e
                    },
                    0x5a => {// adc hl,de
                    },
                    0x5b => {// ld de,(nn)
                        let nn = self.bus.read_mem_u16(pc);
                        self.registers.set_de(nn);
                        pc += 2;
                    },
                    0x5e => {// im 2
                    },
                    0x60 => {// in h,(c)
                    },
                    0x61 => {// out (c),h
                    },
                    0x62 => {// sbc hl,hl
                    },
                    0x67 => {// rrd
                    },
                    0x68 => {// in l,(c)
                    },
                    0x69 => {// out (c),l
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
                    },
                    0x79 => {// out (c),a
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
                    },
                    0xa3 => {// outi
                    },
                    0xa8 => {// ldd
                    },
                    0xa9 => {// cpd
                    },
                    0xaa => {// ind
                    },
                    0xab => {// outd
                    },
                    0xb0 => {// ldir
                    },
                    0xb1 => {// cpir
                    },
                    0xb2 => {// inir
                    },
                    0xb3 => {// otir
                    },
                    0xb8 => {// lddr
                    },
                    0xb9 => {// cpdr
                    },
                    0xba => {// indr
                    },
                    0xbb => {// otdr
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
            },
            0xf0 => {// ret p
            },
            0xf1 => {// pop af
            },
            0xf2 => {// jp p,$+3
            },
            0xf3 => {// di
            },
            0xf4 => {// call p,nn
                let value = self.bus.read_mem_u16(pc);
                // PC +=  n  n
            },
            0xf5 => {// push af
            },
            0xf6 => {// or n
                let value = self.bus.read_mem(pc);
            },
            0xf7 => {// rst 30h
            },
            0xf8 => {// ret m
            },
            0xf9 => {// ld sp,hl
            },
            0xfa => {// jp m,$+3
            },
            0xfb => {// ei
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
                    },
                    0x35 => {// dec (iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x36 => {// ld (iy+n),n
                        let value = self.bus.read_mem(pc);
                        // PC +=  n  n
                    },
                    0x39 => {// add iy,sp
                        let sp = self.registers.get_sp();
                        let iy = self.registers.get_iy();
                        let value = self.add16(iy, sp);
                        self.registers.set_iy(value);
                    },
                    0x46 => {// ld b,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x4e => {// ld c,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x56 => {// ld d,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x5e => {// ld e,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x66 => {// ld h,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x6e => {// ld l,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x70 => {// ld (iy+n),b
                        let value = self.bus.read_mem(pc);
                    },
                    0x71 => {// ld (iy+n),c
                        let value = self.bus.read_mem(pc);
                    },
                    0x72 => {// ld (iy+n),d
                        let value = self.bus.read_mem(pc);
                    },
                    0x73 => {// ld (iy+n),e
                        let value = self.bus.read_mem(pc);
                    },
                    0x74 => {// ld (iy+n),h
                        let value = self.bus.read_mem(pc);
                    },
                    0x75 => {// ld (iy+n),l
                        let value = self.bus.read_mem(pc);
                    },
                    0x77 => {// ld (iy+n),a
                        let value = self.bus.read_mem(pc);
                    },
                    0x7e => {// ld a,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x86 => {// add a,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x8e => {// adc a,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x96 => {// sub (iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0x9e => {// sbc a,(iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0xa6 => {// and (iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0xae => {// xor (iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0xb6 => {// or (iy+n)
                        let value = self.bus.read_mem(pc);
                    },
                    0xbe => {// cp (iy+n)
                        let value = self.bus.read_mem(pc);
                    },

                    0xcb => {
                        let value = self.bus.read_mem(pc+1);
                        let opcode = self.bus.read_mem(pc+2);
                        match opcode {
                            0x06 => {// rlc (iy+n)
                            },
                            0x0e => {// rrc (iy+n)
                            },
                            0x16 => {// rl (iy+n)
                            },
                            0x1e => {// rr (iy+n)
                            },
                            0x26 => {// sla (iy+n)
                            },
                            0x2e => {// sra (iy+n)
                            },
                            0x46 => {// bit 0,(iy+n)
                            },
                            0x4e => {// bit 1,(iy+n)
                            },
                            0x56 => {// bit 2,(iy+n)
                            },
                            0x5e => {// bit 3,(iy+n)
                            },
                            0x66 => {// bit 4,(iy+n)
                            },
                            0x6e => {// bit 5,(iy+n)
                            },
                            0x76 => {// bit 6,(iy+n)
                            },
                            0x7e => {// bit 7,(iy+n)
                            },
                            0x86 => {// res 0,(iy+n)
                            },
                            0x8e => {// res 1,(iy+n)
                            },
                            0x96 => {// res 2,(iy+n)
                            },
                            0x9e => {// res 3,(iy+n)
                            },
                            0xa6 => {// res 4,(iy+n)
                            },
                            0xae => {// res 5,(iy+n)
                            },
                            0xb6 => {// res 6,(iy+n)
                            },
                            0xbe => {// res 7,(iy+n)
                            },
                            0xc6 => {// set 0,(iy+n)
                            },
                            0xce => {// set 1,(iy+n)
                            },
                            0xd6 => {// set 2,(iy+n)
                            },
                            0xde => {// set 3,(iy+n)
                            },
                            0xe6 => {// set 4,(iy+n)
                            },
                            0xee => {// set 5,(iy+n)
                            },
                            0xf6 => {// set 6,(iy+n)
                            },
                            0xfe => {// set 7,(iy+n)
                            },
                            _ => {
                                // Illegal opcode
                            }
                        }
                    },
                    0xe1 => {// pop iy
                    },
                    0xe3 => {// ex (sp),iy
                    },
                    0xe5 => {// push iy
                    },
                    0xe9 => {// jp (iy)
                    },
                    0xf9 => {// ld sp,iy
                    },
                    _ => {
                        // Illegal opcode
                    }
                }
            },
            0xfe => {// cp n
                let value = self.bus.read_mem(pc);
            },
            0xff => {// rst 38h
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

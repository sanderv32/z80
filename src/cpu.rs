#![allow(dead_code)]
#![allow(unused_variables)]

use crate::bus::Bus;
use crate::bus::Io;
use crate::flags::{CF, HF, SF, XF, YF};
use crate::registers::Registers;
use crate::registers::Regs;

/// Each bool models a distinct, independent piece of real Z80 CPU state
/// (interrupt/halt/reset flip-flops); they aren't related option toggles.
#[allow(clippy::struct_excessive_bools)]
pub struct Cpu {
    pub bus: Bus,
    pub registers: Registers,
    pub alternate: Registers,

    pub reset: bool,
    pub hard_reset: bool,

    pub iorq: bool,

    pub im: u8,
    pub im0data: Option<[u8; 4]>,
    pub int: Option<u8>,
    pub nmi: bool,
    pub halt: bool,

    pub iff1: bool,
    pub iff2: bool,

    /// Scratch flag, set by any flag-writing primitive during the current
    /// instruction; used to compute `reg_q` (the SCF/CCF undocumented flag
    /// source) after each `step()`.
    flags_written: bool,
}

#[derive(Clone, Copy)]
pub(crate) enum Type {
    Direct(u16),
    Register(Regs),
    Immediate(u8),
}

impl Cpu {
    /// Create new Cpu instance
    ///
    /// Create a new Cpu instance, need `bus` as a parameter which
    /// is an instance of [Bus]
    #[must_use]
    pub fn new(bus: Option<Bus>) -> Self {
        let bus = bus.unwrap_or_else(|| Bus::new(0xffff));
        Self {
            bus,
            registers: Registers::new(),
            alternate: Registers::new(),
            reset: false,
            hard_reset: true,
            iorq: false,
            im: 0,
            im0data: None,
            int: None,
            nmi: false,
            halt: false,
            iff1: false,
            iff2: false,
            flags_written: false,
        }
    }

    pub fn irq_request(&mut self, d: u8) {
        self.int = Some(d);
    }

    pub fn nmi_request(&mut self) {
        self.nmi = true;
    }

    fn get_value(&self, t: Type) -> u8 {
        match t {
            Type::Direct(addr) => self.bus.read_mem(addr),
            Type::Register(reg) => self.get_register_value(reg),
            Type::Immediate(value) => value,
        }
    }

    fn get_register_value(&self, reg: Regs) -> u8 {
        match reg {
            Regs::A => self.registers.reg_a,
            Regs::B => self.registers.reg_b,
            Regs::C => self.registers.reg_c,
            Regs::D => self.registers.reg_d,
            Regs::E => self.registers.reg_e,
            Regs::H => self.registers.reg_h,
            Regs::L => self.registers.reg_l,
            Regs::IXL => self.registers.reg_ixl,
            Regs::IXH => self.registers.reg_ixh,
            Regs::IYL => self.registers.reg_iyl,
            Regs::IYH => self.registers.reg_iyh,
            _ => 0,
        }
    }

    fn set_value(&mut self, t: Type, value: u8) {
        match t {
            Type::Direct(addr) => self.bus.write_mem(addr, value),
            Type::Register(reg) => self.set_register_value(reg, value),
            Type::Immediate(_) => (),
        }
    }

    fn set_register_value(&mut self, reg: Regs, value: u8) {
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
            ((0x100 - u16::from(value)) & 0x007f) as u8
        } else {
            value
        }
    }

    /// The duplicate match arm bodies below mirror the documented DAA lookup
    /// table row-for-row; merging them would obscure the correspondence.
    #[allow(clippy::match_same_arms)]
    fn daa(&mut self) {
        self.flags_written = true;
        let hn = self.registers.reg_a & 0xf0;
        let ln = self.registers.reg_a & 0x0f;
        let cf = self.registers.reg_f.c;
        let hf = self.registers.reg_f.h;
        let nf = self.registers.reg_f.n;
        let diff = match (cf, hn, hf, ln) {
            (false, 0x00..=0x90, false, 0x00..=0x09) => 0x00,
            (false, 0x00..=0x90, true, 0x00..=0x09) => 0x06,
            (false, 0x00..=0x80, _, 0x0a..=0x0f) => 0x06,
            (false, 0xa0..=0xf0, false, 0x00..=0x09) => 0x60,
            (true, _, false, 0x00..=0x09) => 0x60,
            (true, _, true, 0x00..=0x09) => 0x66,
            (true, _, _, 0x0a..=0x0f) => 0x66,
            (false, 0x90..=0xf0, _, 0x0a..=0x0f) => 0x66,
            (false, 0xa0..=0xf0, true, 0x00..=0x09) => 0x66,
            _ => unreachable!(),
        };

        let carry = match (cf, hn, ln) {
            (false, 0x00..=0x90, 0x00..=0x09) => 0,
            (false, 0x00..=0x80, 0x0a..=0x0f) => 0,
            (false, 0x90..=0xf0, 0x0a..=0x0f) => CF,
            (false, 0xa0..=0xf0, 0x00..=0x09) => CF,
            (true, _, _) => CF,
            _ => unreachable!(),
        };

        let hcarry = match (nf, hf, ln) {
            (false, _, 0x00..=0x09) => 0,
            (false, _, 0x0a..=0x0f) => HF,
            (true, false, _) => 0,
            (true, true, 0x06..=0x0f) => 0,
            (true, true, 0x00..=0x05) => HF,
            _ => unreachable!(),
        };

        let a = if nf {
            self.registers.reg_a.wrapping_sub(diff)
        } else {
            self.registers.reg_a.wrapping_add(diff)
        };

        self.registers.reg_f.c = carry == CF;
        self.registers.reg_f.h = hcarry == HF;
        self.registers.reg_f.s = a & SF == SF;
        self.registers.reg_f.y = a & YF == YF;
        self.registers.reg_f.x = a & XF == XF;
        self.registers.reg_f.z = a == 0;
        self.registers.reg_f.p = a.count_ones() & 1 == 0;
        self.registers.reg_a = a;
    }

    fn inc(&mut self, r1: u8) -> u8 {
        self.flags_written = true;
        let value = r1.wrapping_add(1);
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (r1 & 0x0f) + 1 > 0x0f;
        self.registers.reg_f.p = r1 == 0x7f;
        self.registers.reg_f.n = false;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        value
    }

    #[allow(clippy::verbose_bit_mask)]
    fn dec(&mut self, r1: u8) -> u8 {
        self.flags_written = true;
        let value = r1.wrapping_sub(1);
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.p = r1 == 0x80;
        self.registers.reg_f.h = (r1 & 0x0f) == 0;
        self.registers.reg_f.n = true;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        value
    }

    /// Signed reinterpretation is intentional: used to detect the V (overflow) flag.
    #[allow(clippy::cast_possible_wrap)]
    fn add(&mut self, r1: u8) {
        self.flags_written = true;
        let a = self.registers.reg_a;
        let value = a.wrapping_add(r1);
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (a & 0x0f) + (r1 & 0x0f) > 0x0f;
        self.registers.reg_f.c = u16::from(a) + u16::from(r1) > 0xff;
        self.registers.reg_f.p = {
            let r = (a as i8).overflowing_add(r1 as i8);
            r.1
        };
        self.registers.reg_f.n = false;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.registers.reg_a = value;
    }

    /// Signed reinterpretation is intentional: used to detect the V (overflow) flag.
    #[allow(clippy::cast_possible_wrap)]
    fn adc(&mut self, r1: u8) {
        self.flags_written = true;
        let carry = u8::from(self.registers.reg_f.c);
        let a = self.registers.reg_a;
        let value = a.wrapping_add(r1).wrapping_add(carry);
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (a & 0x0f) + (r1 & 0x0f) + carry > 0x0f;
        self.registers.reg_f.c = u16::from(a) + u16::from(r1) + u16::from(carry) > 0xff;
        self.registers.reg_f.p = {
            let r = (a as i8).overflowing_add(r1.wrapping_add(carry) as i8);
            r.1
        };
        self.registers.reg_f.n = false;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.registers.reg_a = value;
    }

    fn add16(&mut self, r1: u16, r2: u16) -> u16 {
        self.flags_written = true;
        let v = r1.wrapping_add(r2);
        self.registers.reg_f.c = u32::from(r1) + u32::from(r2) > 0xffff;
        self.registers.reg_f.h = (r1 & 0x0fff) + (r2 & 0x0fff) > 0x0fff;
        self.registers.reg_f.n = false;
        self.registers.reg_f.y = (v >> 8) as u8 & YF == YF;
        self.registers.reg_f.x = (v >> 8) as u8 & XF == XF;
        v
    }

    /// Signed reinterpretation is intentional: used to detect the V (overflow) flag.
    #[allow(clippy::cast_possible_wrap)]
    fn adc16(&mut self, r1: u16) {
        self.flags_written = true;
        let c = u16::from(self.registers.reg_f.c);
        let hl = self.registers.get_hl();
        let value = hl.wrapping_add(r1).wrapping_add(c);
        self.registers.set_hl(value);
        self.registers.reg_f.s = value & 0x8000 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (hl & 0x0fff) + (r1 & 0x0fff) + c > 0x0fff;
        self.registers.reg_f.c = u32::from(hl) + u32::from(r1) + u32::from(c) > 0xffff;
        self.registers.reg_f.p = {
            let r = (hl as i16).overflowing_add((r1 + c) as i16);
            r.1
        };
        self.registers.reg_f.n = false;
        self.registers.reg_f.y = (value >> 8) as u8 & YF == YF;
        self.registers.reg_f.x = (value >> 8) as u8 & XF == XF;
    }

    /// Substract `r1` from register A
    ///
    /// r1: Register to substract from A
    ///
    /// Signed reinterpretation is intentional: used to detect the V (overflow) flag.
    #[allow(clippy::cast_possible_wrap)]
    fn sub(&mut self, r1: u8) {
        self.flags_written = true;
        let a = self.registers.reg_a;
        let value = a.wrapping_sub(r1);
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (a & 0x0f) < (value & 0x0f);
        self.registers.reg_f.c = u16::from(a) < u16::from(r1);
        self.registers.reg_f.p = {
            let r = (a as i8).overflowing_sub(value as i8);
            r.1
        };
        self.registers.reg_f.n = true;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.registers.reg_a = value;
    }

    /// Signed reinterpretation is intentional: used to detect the V (overflow) flag.
    #[allow(clippy::cast_possible_wrap)]
    fn sbc(&mut self, r1: u8) {
        self.flags_written = true;
        let carry = u8::from(self.registers.reg_f.c);
        let a = self.registers.reg_a;
        let value = a.wrapping_sub(r1.wrapping_add(carry));
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (a & 0x0f) < (r1 & 0x0f).wrapping_add(carry);
        self.registers.reg_f.c = u16::from(a) < (u16::from(r1) + u16::from(carry));
        self.registers.reg_f.p = {
            let r = (a as i8).overflowing_sub(r1.wrapping_add(carry) as i8);
            r.1
        };
        self.registers.reg_f.n = true;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.registers.reg_a = value;
    }

    /// Signed reinterpretation is intentional: used to detect the V (overflow) flag.
    #[allow(clippy::cast_possible_wrap)]
    fn sbc16(&mut self, r1: u16) {
        self.flags_written = true;
        let carry: u16 = u16::from(self.registers.reg_f.c);
        let hl = self.registers.get_hl();
        let value = hl.wrapping_sub(r1).wrapping_sub(carry);
        self.registers.set_hl(value);
        self.registers.reg_f.s = value & 0x8000 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = (hl & 0x0fff) < (r1 & 0x0fff) + carry;
        self.registers.reg_f.p = {
            let r = (hl as i16).overflowing_sub((r1 + carry) as i16);
            r.1
        };
        self.registers.reg_f.n = true;
        self.registers.reg_f.c = hl < r1 + carry;
        self.registers.reg_f.y = (value >> 8) as u8 & YF == YF;
        self.registers.reg_f.x = (value >> 8) as u8 & XF == XF;
    }

    fn and(&mut self, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        let a = self.registers.reg_a;
        let value = a & r1;
        self.registers.reg_a = value;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = true;
        self.registers.reg_f.p = value.count_ones() & 1 == 0;
        self.registers.reg_f.n = false;
        self.registers.reg_f.c = false;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
    }

    fn or(&mut self, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        let a = self.registers.reg_a;
        let value = a | r1;
        self.registers.reg_a = value;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = false;
        self.registers.reg_f.p = value.count_ones() & 1 == 0;
        self.registers.reg_f.n = false;
        self.registers.reg_f.c = false;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
    }

    fn xor(&mut self, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        let a = self.registers.reg_a;
        let value = a ^ r1;
        self.registers.reg_a = value;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = false;
        self.registers.reg_f.p = value.count_ones() & 1 == 0;
        self.registers.reg_f.n = false;
        self.registers.reg_f.c = false;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
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

    pub(crate) fn pop_stack(&mut self) -> u16 {
        let value = self.bus.read_mem_u16(self.registers.reg_sp);
        self.registers.reg_sp = self.registers.reg_sp.wrapping_add(2);
        value
    }

    pub(crate) fn push_stack(&mut self, value: u16) {
        self.registers.reg_sp = self.registers.reg_sp.wrapping_sub(2);
        self.bus.write_mem_u16(self.registers.reg_sp, value);
    }

    /// Rotate left carry direct
    fn rlc(&mut self, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        let value = (r1 << 1) | u8::from(self.registers.reg_f.c);
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.p = value.count_ones() & 0x01 == 0x00;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.set_value(t, value);
    }

    fn rrc(&mut self, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        let value = if self.registers.reg_f.c { 0x80 | r1 >> 1 } else { r1 >> 1 };
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.p = value.count_ones() & 0x01 == 0x00;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.set_value(t, value);
    }

    fn rl(&mut self, t: Type) {
        self.flags_written = true;
        let c = self.registers.reg_f.c;
        let r1 = self.get_value(t);
        let value = if c { (r1 << 1) | 1 } else { r1 << 1 };
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.p = value.count_ones() & 0x01 == 0x00;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.set_value(t, value);
    }

    fn rr(&mut self, t: Type) {
        self.flags_written = true;
        let c = self.registers.reg_f.c;
        let r1 = self.get_value(t);
        let value = if c { 0x80 | r1 >> 1 } else { r1 >> 1 };
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.p = value.count_ones() & 0x01 == 0x00;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.set_value(t, value);
    }

    fn sla(&mut self, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        let value = r1 << 1;
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.p = value.count_ones() & 0x01 == 0x00;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.set_value(t, value);
    }

    fn sll(&mut self, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        let value = (r1 << 1) | 1;
        self.registers.reg_f.c = r1 & 0x80 == 0x80;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.p = value.count_ones() & 0x01 == 0x00;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.set_value(t, value);
    }

    /// Signed reinterpretation is intentional: arithmetic shift right preserves the sign bit.
    #[allow(clippy::cast_possible_wrap, clippy::cast_sign_loss)]
    fn sra(&mut self, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        let value = ((r1 as i8) >> 1) as u8;
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.p = value.count_ones() & 0x01 == 0x00;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.set_value(t, value);
    }

    fn srl(&mut self, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        let value = r1 >> 1;
        self.registers.reg_f.c = r1 & 0x01 == 0x01;
        self.registers.reg_f.h = false;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.s = value & 0x80 != 0;
        self.registers.reg_f.p = value.count_ones() & 0x01 == 0x00;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
        self.set_value(t, value);
    }

    fn bit(&mut self, bit: u8, t: Type) {
        self.flags_written = true;
        let r1 = self.get_value(t);
        self.registers.reg_f.h = true;
        self.registers.reg_f.n = false;
        self.registers.reg_f.z = r1 & (1 << bit) != (1 << bit);
        self.registers.reg_f.s = !self.registers.reg_f.z && bit == 7 && r1 & 0x80 == 0x80;
        self.registers.reg_f.p = self.registers.reg_f.z;
        self.registers.reg_f.y = r1 & YF == YF;
        self.registers.reg_f.x = r1 & XF == XF;
    }

    fn res(bit: u8, r1: u8) -> u8 {
        r1 & !(1 << bit)
    }

    fn set(bit: u8, r1: u8) -> u8 {
        r1 | (1 << bit)
    }

    /// Decode and execute a DDCB/FDCB-prefixed opcode against `addr` (the
    /// resolved (ix+d)/(iy+d) address). Every opcode outside the documented
    /// ".../(HL)-equivalent" column (col == 6) also copies the computed
    /// result into an 8-bit register (undocumented behavior).
    fn indexed_cb(&mut self, addr: u16, opcode: u8) {
        let row = (opcode >> 3) & 0x07;
        let col = opcode & 0x07;
        match opcode >> 6 {
            0b00 => {
                match row {
                    0 => self.rlc(Type::Direct(addr)),
                    1 => self.rrc(Type::Direct(addr)),
                    2 => self.rl(Type::Direct(addr)),
                    3 => self.rr(Type::Direct(addr)),
                    4 => self.sla(Type::Direct(addr)),
                    5 => self.sra(Type::Direct(addr)),
                    6 => self.sll(Type::Direct(addr)),
                    7 => self.srl(Type::Direct(addr)),
                    _ => unreachable!(),
                }
                if col != 6 {
                    let value = self.bus.read_mem(addr);
                    self.set_register_value(Cpu::cb_col_to_reg(col), value);
                }
            }
            0b01 => {
                let value = self.bus.read_mem(addr);
                self.bit(row, Type::Immediate(value));
            }
            0b10 => {
                let value = Self::res(row, self.bus.read_mem(addr));
                self.bus.write_mem(addr, value);
                if col != 6 {
                    self.set_register_value(Cpu::cb_col_to_reg(col), value);
                }
            }
            0b11 => {
                let value = Self::set(row, self.bus.read_mem(addr));
                self.bus.write_mem(addr, value);
                if col != 6 {
                    self.set_register_value(Cpu::cb_col_to_reg(col), value);
                }
            }
            _ => unreachable!(),
        }
    }

    fn cb_col_to_reg(col: u8) -> Regs {
        match col {
            0 => Regs::B,
            1 => Regs::C,
            2 => Regs::D,
            3 => Regs::E,
            4 => Regs::H,
            5 => Regs::L,
            7 => Regs::A,
            _ => unreachable!(),
        }
    }

    fn cpi(&mut self) {
        self.flags_written = true;
        let bc = self.registers.get_bc();
        let hl = self.registers.get_hl();
        let value = self.bus.read_mem(hl);
        let result = self.registers.reg_a.wrapping_sub(value);

        self.registers.set_hl(hl.wrapping_add(1));
        self.registers.set_bc(bc.wrapping_sub(1));

        self.registers.reg_f.s = result & 0x80 != 0;
        self.registers.reg_f.z = self.registers.reg_a == value;
        self.registers.reg_f.h = (self.registers.reg_a & 0x0f) < (value & 0x0f);
        self.registers.reg_f.p = self.registers.get_bc() != 0;
        self.registers.reg_f.n = true;
        let n = result.wrapping_sub(u8::from(self.registers.reg_f.h));
        self.registers.reg_f.y = n & 0x02 != 0;
        self.registers.reg_f.x = n & 0x08 != 0;
    }

    fn cpd(&mut self) {
        self.flags_written = true;
        let bc = self.registers.get_bc();
        let hl = self.registers.get_hl();
        let value = self.bus.read_mem(hl);
        let result = self.registers.reg_a.wrapping_sub(value);

        self.registers.set_hl(hl.wrapping_sub(1));
        self.registers.set_bc(bc.wrapping_sub(1));

        self.registers.reg_f.s = result & 0x80 == 0x80;
        self.registers.reg_f.z = self.registers.reg_a == value;
        self.registers.reg_f.h = (self.registers.reg_a & 0x0f) < (value & 0x0f);
        self.registers.reg_f.p = self.registers.get_bc() != 0;
        self.registers.reg_f.n = true;
        let n = result.wrapping_sub(u8::from(self.registers.reg_f.h));
        self.registers.reg_f.y = n & 0x02 != 0;
        self.registers.reg_f.x = n & 0x08 != 0;
    }

    /// Truncation to u8 is intentional: only the low byte of `k` is needed.
    #[allow(clippy::cast_possible_truncation)]
    fn ini(&mut self) {
        self.flags_written = true;
        let hl = self.registers.get_hl();
        let bc = self.registers.get_bc();
        let value = self.bus.read_io(bc);
        self.bus.write_mem(hl, value);
        self.registers.set_hl(hl.wrapping_add(1));
        let b = self.registers.reg_b.wrapping_sub(1);
        self.registers.reg_b = b;
        let k = u16::from(value) + u16::from(self.registers.reg_c.wrapping_add(1));
        self.registers.reg_f.c = k > 0xff;
        self.registers.reg_f.h = k > 0xff;
        self.registers.reg_f.p = ((k as u8 & 0x07) ^ b).count_ones() & 1 == 0;
        self.registers.reg_f.n = value & 0x80 == 0x80;
        self.registers.reg_f.z = b == 0;
        self.registers.reg_f.s = b & 0x80 == 0x80;
        self.registers.reg_f.y = b & YF == YF;
        self.registers.reg_f.x = b & XF == XF;
    }

    /// Truncation to u8 is intentional: only the low byte of `k` is needed.
    #[allow(clippy::cast_possible_truncation)]
    fn ind(&mut self) {
        self.flags_written = true;
        let hl = self.registers.get_hl();
        let bc = self.registers.get_bc();
        let value = self.bus.read_io(bc);
        self.bus.write_mem(hl, value);
        self.registers.set_hl(hl.wrapping_sub(1));
        let b = self.registers.reg_b.wrapping_sub(1);
        self.registers.reg_b = b;
        let k = u16::from(value) + u16::from(self.registers.reg_c.wrapping_sub(1));
        self.registers.reg_f.c = k > 0xff;
        self.registers.reg_f.h = k > 0xff;
        self.registers.reg_f.p = ((k as u8 & 0x07) ^ b).count_ones() & 1 == 0;
        self.registers.reg_f.n = value & 0x80 == 0x80;
        self.registers.reg_f.z = b == 0;
        self.registers.reg_f.s = b & 0x80 == 0x80;
        self.registers.reg_f.y = b & YF == YF;
        self.registers.reg_f.x = b & XF == XF;
    }

    /// Truncation to u8 is intentional: only the low byte of `k` is needed.
    #[allow(clippy::cast_possible_truncation)]
    fn outi(&mut self) {
        self.flags_written = true;
        let hl = self.registers.get_hl();
        let value = self.bus.read_mem(hl);
        self.registers.set_hl(hl.wrapping_add(1));
        let b = self.registers.reg_b.wrapping_sub(1);
        self.registers.reg_b = b;
        self.bus.write_io(self.registers.get_bc(), value);
        let k = u16::from(value) + u16::from(self.registers.reg_l);
        self.registers.reg_f.c = k > 0xff;
        self.registers.reg_f.h = k > 0xff;
        self.registers.reg_f.p = ((k as u8 & 0x07) ^ b).count_ones() & 1 == 0;
        self.registers.reg_f.n = value & 0x80 == 0x80;
        self.registers.reg_f.z = b == 0;
        self.registers.reg_f.s = b & 0x80 == 0x80;
        self.registers.reg_f.y = b & YF == YF;
        self.registers.reg_f.x = b & XF == XF;
    }

    /// Truncation to u8 is intentional: only the low byte of `k` is needed.
    #[allow(clippy::cast_possible_truncation)]
    fn outd(&mut self) {
        self.flags_written = true;
        let hl = self.registers.get_hl();
        let value = self.bus.read_mem(hl);
        self.registers.set_hl(hl.wrapping_sub(1));
        let b = self.registers.reg_b.wrapping_sub(1);
        self.registers.reg_b = b;
        self.bus.write_io(self.registers.get_bc(), value);
        let k = u16::from(value) + u16::from(self.registers.reg_l);
        self.registers.reg_f.c = k > 0xff;
        self.registers.reg_f.h = k > 0xff;
        self.registers.reg_f.p = ((k as u8 & 0x07) ^ b).count_ones() & 1 == 0;
        self.registers.reg_f.n = value & 0x80 == 0x80;
        self.registers.reg_f.z = b == 0;
        self.registers.reg_f.s = b & 0x80 == 0x80;
        self.registers.reg_f.y = b & YF == YF;
        self.registers.reg_f.x = b & XF == XF;
    }

    /// Set flags for `IN r,(C)` (and the undocumented `IN (C)`) from the
    /// value read from the port.
    fn in_flags(&mut self, value: u8) {
        self.flags_written = true;
        self.registers.reg_f.s = value & 0x80 == 0x80;
        self.registers.reg_f.z = value == 0;
        self.registers.reg_f.h = false;
        self.registers.reg_f.p = value.count_ones() & 1 == 0;
        self.registers.reg_f.n = false;
        self.registers.reg_f.y = value & YF == YF;
        self.registers.reg_f.x = value & XF == XF;
    }

    fn neg(&mut self) {
        self.flags_written = true;
        let result = 0_u8.wrapping_sub(self.registers.reg_a);
        self.registers.reg_f.z = result == 0;
        self.registers.reg_f.s = result & 0x80 != 0;
        self.registers.reg_f.p = self.registers.reg_a == 0x80;
        self.registers.reg_f.c = result != 0;
        self.registers.reg_f.n = true;
        self.registers.reg_f.h = (self.registers.reg_a ^ result) & HF == HF;
        self.registers.reg_f.x = result & XF == XF;
        self.registers.reg_f.y = result & YF == YF;
        self.registers.reg_a = result;
    }

    fn process_interrupt(&mut self) -> bool {
        if self.nmi {
            self.nmi = false;
            self.push_stack(self.registers.reg_pc);
            self.registers.reg_pc = 0x0066;
            self.iff2 = self.iff1;
            self.iff1 = false;
            return true;
        }

        if self.iff1 && self.im0data.is_some() && self.im == 0 {
            // The IM 0 instruction sets Interrupt Mode 0. In this mode, the interrupting device can insert
            // any instruction on the data bus for execution by the CPU. The first byte of a multi-byte
            // instruction is read during the interrupt acknowledge cycle. Subsequent bytes are read in by
            // a normal memory read sequence.
            let saved_memory = core::mem::take(&mut self.bus.ram);
            let saved_pc = self.registers.reg_pc;
            self.bus.ram = self.im0data.as_ref().unwrap().to_vec();
            self.registers.reg_pc = 0;
            self.exec_opcode();
            self.registers.reg_pc = saved_pc;
            self.bus.ram = saved_memory;
            self.iff1 = false;
            return true;
        }

        if self.iff1 && self.int.is_some() && self.im == 1 {
            self.int = Some(0xff);
            self.iff1 = false;
            return true;
        }

        if self.iff1 && self.int.is_some() && self.im == 2 {
            self.push_stack(self.registers.reg_pc);
            let hb = u16::from(self.registers.reg_i);
            let lb = u16::from(self.int.unwrap());
            self.registers.reg_pc = (hb << 8) | lb;
            self.iff1 = false;
            self.int = None;
            return true;
        }
        false
    }

    /// Execute opcode at current program counter
    pub fn exec_opcode(&mut self) {
        if self.halt {
            return;
        }

        let opcode = if self.iff1 { match self.int {
            None => self.bus.read_mem(self.registers.reg_pc),
            Some(opcode) => opcode,
        } } else { self.bus.read_mem(self.registers.reg_pc) };
        self.registers.reg_pc = self.registers.reg_pc.wrapping_add(1);
        self.exec_base_opcode(opcode);
    }

    /// Execute a single base opcode byte.
    ///
    /// Also called recursively by the `0xdd`/`0xfd` (IX/IY) prefix handlers
    /// for any opcode that doesn't reference H/L/(HL) — on real Z80 hardware
    /// the DD/FD prefix has no effect on those opcodes (they just cost extra
    /// cycles), so they're executed exactly as their unprefixed form.
    ///
    /// Many arms are intentionally identical (e.g. `LD B,B`/`LD C,C`/... are
    /// all genuine no-ops) — one arm per real opcode is kept for clarity.
    /// This function is inherently long: it's the full Z80 opcode table
    /// (256 base opcodes plus the CB/DD/ED/FD prefix tables), one match arm
    /// per real instruction. Splitting it up would not reduce complexity.
    #[allow(clippy::match_same_arms, clippy::too_many_lines)]
    fn exec_base_opcode(&mut self, opcode: u8) {
        match opcode {
            0x00 => (), // nop
            0x01 => {
                // ld bc,nn
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                self.registers.set_bc(nn);
                self.registers.reg_pc += 2;
            }
            0x02 => {
                // ld (bc),a
                let addr = self.registers.get_bc();
                self.bus.write_mem(addr, self.registers.reg_a);
            }
            0x03 => {
                // inc bc
                let bc = self.registers.get_bc().wrapping_add(1);
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
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_b = n;
                self.registers.reg_pc += 1;
            }
            0x07 => {
                // rlca
                self.flags_written = true;
                let c = self.registers.reg_f.c;
                let lmb = self.registers.reg_a & 0x80;
                let result = self.registers.reg_a << 1 | lmb >> 7_u8;
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = lmb == 0x80;
                self.registers.reg_f.y = result & YF == YF;
                self.registers.reg_f.x = result & XF == XF;
                self.registers.reg_a = result;
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
                self.flags_written = true;
                let carry = self.registers.reg_a & 0x01;
                let a = self.registers.reg_a >> 1 | carry << 7;
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = carry == 0x01;
                self.registers.reg_f.y = a & YF == YF;
                self.registers.reg_f.x = a & XF == XF;
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
                        self.registers.reg_pc -= u16::from(Cpu::abs(value)) - 1;
                    } else {
                        self.registers.reg_pc += 1 + u16::from(value);
                    }
                }
            }
            0x11 => {
                // ld de,nn
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                self.registers.set_de(nn);
                self.registers.reg_pc += 2;
            }
            0x12 => {
                // ld (de),a
                let de = self.registers.get_de();
                self.bus.write_mem(de, self.registers.reg_a);
            }
            0x13 => {
                // inc de
                let de = self.registers.get_de().wrapping_add(1);
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
                self.flags_written = true;
                let c = self.registers.reg_f.c;
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = self.registers.reg_a & 0x80 == 0x80;
                let result = if c { self.registers.reg_a.wrapping_shl(1) | 1 } else { self.registers.reg_a.wrapping_shl(1) };
                self.registers.reg_f.y = result & YF == YF;
                self.registers.reg_f.x = result & XF == XF;
                self.registers.reg_a = result;
            }
            0x18 => {
                // jr $+2
                let value = self.bus.read_mem(self.registers.reg_pc);
                if value & 0x80 == 0x80 {
                    self.registers.reg_pc -= u16::from(Cpu::abs(value)) - 1;
                } else {
                    self.registers.reg_pc += 1 + u16::from(value);
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
                self.flags_written = true;
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                let carry = if self.registers.reg_f.c { 0x80 } else { 0 };
                self.registers.reg_f.c = self.registers.reg_a & 0x01 == 0x01;
                let result = (self.registers.reg_a >> 1) | carry;
                self.registers.reg_f.y = result & YF == YF;
                self.registers.reg_f.x = result & XF == XF;
                self.registers.reg_a = result;
            }
            0x20 => {
                // jr nz,$+2
                if self.registers.reg_f.z {
                    self.registers.reg_pc += 1;
                } else {
                    let value = self.bus.read_mem(self.registers.reg_pc);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc -= u16::from(Cpu::abs(value)) - 1;
                    } else {
                        self.registers.reg_pc += 1 + u16::from(value);
                    }
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
                self.registers.reg_pc += 1;
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
                        self.registers.reg_pc -= u16::from(Cpu::abs(value)) - 1;
                    } else {
                        self.registers.reg_pc += 1 + u16::from(value);
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
                self.flags_written = true;
                let a = !self.registers.reg_a;
                self.registers.reg_f.h = true;
                self.registers.reg_f.n = true;
                self.registers.reg_f.y = a & YF == YF;
                self.registers.reg_f.x = a & XF == XF;
                self.registers.reg_a = a;
            }
            0x30 => {
                // jr nc,$+2
                if self.registers.reg_f.c {
                    self.registers.reg_pc += 1;
                } else {
                    let value = self.bus.read_mem(self.registers.reg_pc);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc -= u16::from(Cpu::abs(value)) - 1;
                    } else {
                        self.registers.reg_pc += 1 + u16::from(value);
                    }
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
                self.flags_written = true;
                let xy = self.registers.reg_a | self.registers.reg_q;
                self.registers.reg_f.y = xy & YF != 0;
                self.registers.reg_f.x = xy & XF != 0;
                self.registers.reg_f.h = false;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = true;
            }
            0x38 => {
                // jr c,$+2
                if self.registers.reg_f.c {
                    let value = self.bus.read_mem(self.registers.reg_pc);
                    if value & 0x80 == 0x80 {
                        self.registers.reg_pc -= u16::from(Cpu::abs(value)) - 1;
                    } else {
                        self.registers.reg_pc += 1 + u16::from(value);
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
                self.registers.reg_a = self.bus.read_mem(nn);
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
                self.flags_written = true;
                let xy = self.registers.reg_a | self.registers.reg_q;
                self.registers.reg_f.y = xy & YF != 0;
                self.registers.reg_f.x = xy & XF != 0;
                self.registers.reg_f.h = self.registers.reg_f.c;
                self.registers.reg_f.n = false;
                self.registers.reg_f.c = !self.registers.reg_f.c;
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
                self.registers.reg_c = self.registers.reg_b;
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
                self.registers.reg_pc = self.registers.reg_pc.wrapping_sub(1);
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
                    self.registers.reg_pc = self.pop_stack();
                }
            }
            0xc1 => {
                // pop bc
                self.registers
                    .set_bc(self.bus.read_mem_u16(self.registers.reg_sp));
                self.registers.reg_sp = self.registers.reg_sp.wrapping_add(2);
            }
            0xc2 => {
                // jp nz,$+3
                let value = self.bus.read_mem_u16(self.registers.reg_pc);
                if self.registers.reg_f.z {
                    self.registers.reg_pc += 2;
                } else {
                    self.registers.reg_pc = value;
                }
            }
            0xc3 => {
                // jp $+3
                self.registers.reg_pc = self.bus.read_mem_u16(self.registers.reg_pc);
            }
            0xc4 => {
                // call nz,nn
                if self.registers.reg_f.z {
                    self.registers.reg_pc += 2;
                } else {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.push_stack(self.registers.reg_pc + 2);
                    self.registers.reg_pc = nn;
                }
            }
            0xc5 => {
                // push bc
                let bc = self.registers.get_bc();
                self.push_stack(bc);
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
                    self.registers.reg_pc = self.pop_stack();
                }
            }
            0xc9 => {
                // ret
                self.registers.reg_pc = self.pop_stack();
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
                let prev_opcode = 0xcb;
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
                        self.bit(0, Type::Register(Regs::B));
                    }
                    0x41 => {
                        // bit 0,c
                        self.bit(0, Type::Register(Regs::C));
                    }
                    0x42 => {
                        // bit 0,d
                        self.bit(0, Type::Register(Regs::D));
                    }
                    0x43 => {
                        // bit 0,e
                        self.bit(0, Type::Register(Regs::E));
                    }
                    0x44 => {
                        // bit 0,h
                        self.bit(0, Type::Register(Regs::H));
                    }
                    0x45 => {
                        // bit 0,l
                        self.bit(0, Type::Register(Regs::L));
                    }
                    0x46 => {
                        // bit 0,(hl)
                        let hl = self.registers.get_hl();
                        self.bit(0, Type::Direct(hl));
                    }
                    0x47 => {
                        // bit 0,a
                        self.bit(0, Type::Register(Regs::A));
                    }
                    0x48 => {
                        // bit 1,b
                        self.bit(1, Type::Register(Regs::B));
                    }
                    0x49 => {
                        // bit 1,c
                        self.bit(1, Type::Register(Regs::C));
                    }
                    0x4a => {
                        // bit 1,d
                        self.bit(1, Type::Register(Regs::D));
                    }
                    0x4b => {
                        // bit 1,e
                        self.bit(1, Type::Register(Regs::E));
                    }
                    0x4c => {
                        // bit 1,h
                        self.bit(1, Type::Register(Regs::H));
                    }
                    0x4d => {
                        // bit 1,l
                        self.bit(1, Type::Register(Regs::L));
                    }
                    0x4e => {
                        // bit 1,(hl)
                        let hl = self.registers.get_hl();
                        self.bit(1, Type::Direct(hl));
                    }
                    0x4f => {
                        // bit 1,a
                        self.bit(1, Type::Register(Regs::A));
                    }
                    0x50 => {
                        // bit 2,b
                        self.bit(2, Type::Register(Regs::B));
                    }
                    0x51 => {
                        // bit 2,c
                        self.bit(2, Type::Register(Regs::C));
                    }
                    0x52 => {
                        // bit 2,d
                        self.bit(2, Type::Register(Regs::D));
                    }
                    0x53 => {
                        // bit 2,e
                        self.bit(2, Type::Register(Regs::E));
                    }
                    0x54 => {
                        // bit 2,h
                        self.bit(2, Type::Register(Regs::H));
                    }
                    0x55 => {
                        // bit 2,l
                        self.bit(2, Type::Register(Regs::L));
                    }
                    0x56 => {
                        // bit 2,(hl)
                        let hl = self.registers.get_hl();
                        self.bit(2, Type::Direct(hl));
                    }
                    0x57 => {
                        // bit 2,a
                        self.bit(2, Type::Register(Regs::A));
                    }
                    0x58 => {
                        // bit 3,b
                        self.bit(3, Type::Register(Regs::B));
                    }
                    0x59 => {
                        // bit 3,c
                        self.bit(3, Type::Register(Regs::C));
                    }
                    0x5a => {
                        // bit 3,d
                        self.bit(3, Type::Register(Regs::D));
                    }
                    0x5b => {
                        // bit 3,e
                        self.bit(3, Type::Register(Regs::E));
                    }
                    0x5c => {
                        // bit 3,h
                        self.bit(3, Type::Register(Regs::H));
                    }
                    0x5d => {
                        // bit 3,l
                        self.bit(3, Type::Register(Regs::L));
                    }
                    0x5e => {
                        // bit 3,(hl)
                        let hl = self.registers.get_hl();
                        self.bit(3, Type::Direct(hl));
                    }
                    0x5f => {
                        // bit 3,a
                        self.bit(3, Type::Register(Regs::A));
                    }
                    0x60 => {
                        // bit 4,b
                        self.bit(4, Type::Register(Regs::B));
                    }
                    0x61 => {
                        // bit 4,c
                        self.bit(4, Type::Register(Regs::C));
                    }
                    0x62 => {
                        // bit 4,d
                        self.bit(4, Type::Register(Regs::D));
                    }
                    0x63 => {
                        // bit 4,e
                        self.bit(4, Type::Register(Regs::E));
                    }
                    0x64 => {
                        // bit 4,h
                        self.bit(4, Type::Register(Regs::H));
                    }
                    0x65 => {
                        // bit 4,l
                        self.bit(4, Type::Register(Regs::L));
                    }
                    0x66 => {
                        // bit 4,(hl)
                        let hl = self.registers.get_hl();
                        self.bit(4, Type::Direct(hl));
                    }
                    0x67 => {
                        // bit 4,a
                        self.bit(4, Type::Register(Regs::A));
                    }
                    0x68 => {
                        // bit 5,b
                        self.bit(5, Type::Register(Regs::B));
                    }
                    0x69 => {
                        // bit 5,c
                        self.bit(5, Type::Register(Regs::C));
                    }
                    0x6a => {
                        // bit 5,d
                        self.bit(5, Type::Register(Regs::D));
                    }
                    0x6b => {
                        // bit 5,e
                        self.bit(5, Type::Register(Regs::E));
                    }
                    0x6c => {
                        // bit 5,h
                        self.bit(5, Type::Register(Regs::H));
                    }
                    0x6d => {
                        // bit 5,l
                        self.bit(5, Type::Register(Regs::L));
                    }
                    0x6e => {
                        // bit 5,(hl)
                        let hl = self.registers.get_hl();
                        self.bit(5, Type::Direct(hl));
                    }
                    0x6f => {
                        // bit 5,a
                        self.bit(5, Type::Register(Regs::A));
                    }
                    0x70 => {
                        // bit 6,b
                        self.bit(6, Type::Register(Regs::B));
                    }
                    0x71 => {
                        // bit 6,c
                        self.bit(6, Type::Register(Regs::C));
                    }
                    0x72 => {
                        // bit 6,d
                        self.bit(6, Type::Register(Regs::D));
                    }
                    0x73 => {
                        // bit 6,e
                        self.bit(6, Type::Register(Regs::E));
                    }
                    0x74 => {
                        // bit 6,h
                        self.bit(6, Type::Register(Regs::H));
                    }
                    0x75 => {
                        // bit 6,l
                        self.bit(6, Type::Register(Regs::L));
                    }
                    0x76 => {
                        // bit 6,(hl)
                        let hl = self.registers.get_hl();
                        self.bit(6, Type::Direct(hl));
                    }
                    0x77 => {
                        // bit 6,a
                        self.bit(6, Type::Register(Regs::A));
                    }
                    0x78 => {
                        // bit 7,b
                        self.bit(7, Type::Register(Regs::B));
                    }
                    0x79 => {
                        // bit 7,c
                        self.bit(7, Type::Register(Regs::C));
                    }
                    0x7a => {
                        // bit 7,d
                        self.bit(7, Type::Register(Regs::D));
                    }
                    0x7b => {
                        // bit 7,e
                        self.bit(7, Type::Register(Regs::E));
                    }
                    0x7c => {
                        // bit 7,h
                        self.bit(7, Type::Register(Regs::H));
                    }
                    0x7d => {
                        // bit 7,l
                        self.bit(7, Type::Register(Regs::L));
                    }
                    0x7e => {
                        // bit 7,(hl)
                        let hl = self.registers.get_hl();
                        self.bit(7, Type::Direct(hl));
                    }
                    0x7f => {
                        // bit 7,a
                        self.bit(7, Type::Register(Regs::A));
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
                if self.registers.reg_f.z {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.push_stack(self.registers.reg_pc + 2);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
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
                    self.registers.reg_pc = self.pop_stack();
                }
            }
            0xd1 => {
                // pop de
                self.registers
                    .set_de(self.bus.read_mem_u16(self.registers.reg_sp));
                self.registers.reg_sp = self.registers.reg_sp.wrapping_add(2);
            }
            0xd2 => {
                // jp nc,$+3
                if self.registers.reg_f.c {
                    self.registers.reg_pc += 2;
                } else {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = nn;
                }
            }
            0xd3 => {
                // out (n),a
                let n = self.bus.read_mem(self.registers.reg_pc);
                let a = u16::from(self.registers.reg_a) << 8;
                self.bus.write_io(u16::from(n) | a, self.registers.reg_a);
                self.registers.reg_pc += 1;
            }
            0xd4 => {
                // call nc,nn
                let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                if self.registers.reg_f.c {
                    self.registers.reg_pc += 2;
                } else {
                    self.push_stack(self.registers.reg_pc + 2);
                    self.registers.reg_pc = nn;
                }
            }
            0xd5 => {
                // push de
                let de = self.registers.get_de();
                self.push_stack(de);
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
                    self.registers.reg_pc = self.pop_stack();
                }
            }
            0xd9 => {
                // exx
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
                    .read_io(u16::from(n) | u16::from(self.registers.reg_a) << 8);
                self.registers.reg_pc += 1;
            }
            0xdc => {
                // call c,nn
                if self.registers.reg_f.c {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.push_stack(self.registers.reg_pc + 2);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xdd => {
                let prev_opcode = 0xdd;
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
                        if n & 0x80 == 0x80 {
                            let addr = ix - u16::from(Cpu::abs(n));
                            let value = self.bus.read_mem(addr);
                            let result = self.inc(value);
                            self.bus.write_mem(addr, result);
                        } else {
                            let addr = ix + u16::from(n);
                            let value = self.bus.read_mem(addr);
                            let result = self.inc(value);
                            self.bus.write_mem(addr, result);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x35 => {
                        // dec (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let ix = self.registers.get_ix();
                        if n & 0x80 == 0x80 {
                            let addr = ix - u16::from(Cpu::abs(n));
                            let value = self.bus.read_mem(addr);
                            let result = self.dec(value);
                            self.bus.write_mem(addr, result);
                        } else {
                            let addr = ix + u16::from(n);
                            let value = self.bus.read_mem(addr);
                            let result = self.dec(value);
                            self.bus.write_mem(addr, result);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x36 => {
                        // ld (ix+n),n
                        let ixn = self.bus.read_mem(self.registers.reg_pc);
                        let n = self.bus.read_mem(self.registers.reg_pc + 1);
                        let ix = self.registers.get_ix();
                        if ixn & 0x80 == 0x80 {
                            let addr = ix - u16::from(Cpu::abs(ixn));
                            self.bus.write_mem(addr, n);
                        } else {
                            let addr = ix + u16::from(ixn);
                            self.bus.write_mem(addr, n);
                        }
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
                        if n & 0x80 == 0x80 {
                            self.registers.reg_b = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                        } else {
                            self.registers.reg_b =
                                self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x4e => {
                        // ld c,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.registers.reg_c = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                        } else {
                            self.registers.reg_c =
                                self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x56 => {
                        // ld d,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.registers.reg_d = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                        } else {
                            self.registers.reg_d =
                                self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x5e => {
                        // ld e,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.registers.reg_e = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                        } else {
                            self.registers.reg_e =
                                self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x66 => {
                        // ld h,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.registers.reg_h = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                        } else {
                            self.registers.reg_h =
                                self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x6e => {
                        // ld l,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.registers.reg_l = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                        } else {
                            self.registers.reg_l =
                                self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x70 => {
                        // ld (ix+n),b
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.bus.write_mem(
                                self.registers.get_ix() - u16::from(Cpu::abs(n)),
                                self.registers.reg_b,
                            );
                        } else {
                            self.bus.write_mem(
                                self.registers.get_ix() + u16::from(n),
                                self.registers.reg_b,
                            );
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x71 => {
                        // ld (ix+n),c
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.bus.write_mem(
                                self.registers.get_ix() - u16::from(Cpu::abs(n)),
                                self.registers.reg_c,
                            );
                        } else {
                            self.bus.write_mem(
                                self.registers.get_ix() + u16::from(n),
                                self.registers.reg_c,
                            );
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x72 => {
                        // ld (ix+n),d
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.bus.write_mem(
                                self.registers.get_ix() - u16::from(Cpu::abs(n)),
                                self.registers.reg_d,
                            );
                        } else {
                            self.bus.write_mem(
                                self.registers.get_ix() + u16::from(n),
                                self.registers.reg_d,
                            );
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x73 => {
                        // ld (ix+n),e
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.bus.write_mem(
                                self.registers.get_ix() - u16::from(Cpu::abs(n)),
                                self.registers.reg_e,
                            );
                        } else {
                            self.bus.write_mem(
                                self.registers.get_ix() + u16::from(n),
                                self.registers.reg_e,
                            );
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x74 => {
                        // ld (ix+n),h
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.bus.write_mem(
                                self.registers.get_ix() - u16::from(Cpu::abs(n)),
                                self.registers.reg_h,
                            );
                        } else {
                            self.bus.write_mem(
                                self.registers.get_ix() + u16::from(n),
                                self.registers.reg_h,
                            );
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x75 => {
                        // ld (ix+n),l
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.bus.write_mem(
                                self.registers.get_ix() - u16::from(Cpu::abs(n)),
                                self.registers.reg_l,
                            );
                        } else {
                            self.bus.write_mem(
                                self.registers.get_ix() + u16::from(n),
                                self.registers.reg_l,
                            );
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x77 => {
                        // ld (ix+n),a
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.bus.write_mem(
                                self.registers.get_ix() - u16::from(Cpu::abs(n)),
                                self.registers.reg_a,
                            );
                        } else {
                            self.bus.write_mem(
                                self.registers.get_ix() + u16::from(n),
                                self.registers.reg_a,
                            );
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x7e => {
                        // ld a,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            self.registers.reg_a = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                        } else {
                            self.registers.reg_a =
                                self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x80 => {
                        // add a,b (dd prefix has no effect)
                        self.add(self.registers.reg_b);
                    }
                    0x81 => {
                        // add a,c (dd prefix has no effect)
                        self.add(self.registers.reg_c);
                    }
                    0x82 => {
                        // add a,d (dd prefix has no effect)
                        self.add(self.registers.reg_d);
                    }
                    0x83 => {
                        // add a,e (dd prefix has no effect)
                        self.add(self.registers.reg_e);
                    }
                    0x87 => {
                        // add a,a (dd prefix has no effect)
                        self.add(self.registers.reg_a);
                    }
                    0x88 => {
                        // adc a,b (dd prefix has no effect)
                        self.adc(self.registers.reg_b);
                    }
                    0x89 => {
                        // adc a,c (dd prefix has no effect)
                        self.adc(self.registers.reg_c);
                    }
                    0x8a => {
                        // adc a,d (dd prefix has no effect)
                        self.adc(self.registers.reg_d);
                    }
                    0x8b => {
                        // adc a,e (dd prefix has no effect)
                        self.adc(self.registers.reg_e);
                    }
                    0x8f => {
                        // adc a,a (dd prefix has no effect)
                        self.adc(self.registers.reg_a);
                    }
                    0x90 => {
                        // sub b (dd prefix has no effect)
                        self.sub(self.registers.reg_b);
                    }
                    0x91 => {
                        // sub c (dd prefix has no effect)
                        self.sub(self.registers.reg_c);
                    }
                    0x92 => {
                        // sub d (dd prefix has no effect)
                        self.sub(self.registers.reg_d);
                    }
                    0x93 => {
                        // sub e (dd prefix has no effect)
                        self.sub(self.registers.reg_e);
                    }
                    0x97 => {
                        // sub a (dd prefix has no effect)
                        self.sub(self.registers.reg_a);
                    }
                    0x98 => {
                        // sbc b (dd prefix has no effect)
                        self.sbc(self.registers.reg_b);
                    }
                    0x99 => {
                        // sbc c (dd prefix has no effect)
                        self.sbc(self.registers.reg_c);
                    }
                    0x9a => {
                        // sbc d (dd prefix has no effect)
                        self.sbc(self.registers.reg_d);
                    }
                    0x9b => {
                        // sbc e (dd prefix has no effect)
                        self.sbc(self.registers.reg_e);
                    }
                    0x9f => {
                        // sbc a (dd prefix has no effect)
                        self.sbc(self.registers.reg_a);
                    }
                    0xa0 => {
                        // and b (dd prefix has no effect)
                        self.and(Type::Register(Regs::B));
                    }
                    0xa1 => {
                        // and c (dd prefix has no effect)
                        self.and(Type::Register(Regs::C));
                    }
                    0xa2 => {
                        // and d (dd prefix has no effect)
                        self.and(Type::Register(Regs::D));
                    }
                    0xa3 => {
                        // and e (dd prefix has no effect)
                        self.and(Type::Register(Regs::E));
                    }
                    0xa7 => {
                        // and a (dd prefix has no effect)
                        self.and(Type::Register(Regs::A));
                    }
                    0xa8 => {
                        // xor b (dd prefix has no effect)
                        self.xor(Type::Register(Regs::B));
                    }
                    0xa9 => {
                        // xor c (dd prefix has no effect)
                        self.xor(Type::Register(Regs::C));
                    }
                    0xaa => {
                        // xor d (dd prefix has no effect)
                        self.xor(Type::Register(Regs::D));
                    }
                    0xab => {
                        // xor e (dd prefix has no effect)
                        self.xor(Type::Register(Regs::E));
                    }
                    0xaf => {
                        // xor a (dd prefix has no effect)
                        self.xor(Type::Register(Regs::A));
                    }
                    0xb0 => {
                        // or b (dd prefix has no effect)
                        self.or(Type::Register(Regs::B));
                    }
                    0xb1 => {
                        // or c (dd prefix has no effect)
                        self.or(Type::Register(Regs::C));
                    }
                    0xb2 => {
                        // or d (dd prefix has no effect)
                        self.or(Type::Register(Regs::D));
                    }
                    0xb3 => {
                        // or e (dd prefix has no effect)
                        self.or(Type::Register(Regs::E));
                    }
                    0xb7 => {
                        // or a (dd prefix has no effect)
                        self.or(Type::Register(Regs::A));
                    }
                    0xb8 => {
                        // cp b (dd prefix has no effect)
                        self.cp(self.registers.reg_b);
                    }
                    0xb9 => {
                        // cp c (dd prefix has no effect)
                        self.cp(self.registers.reg_c);
                    }
                    0xba => {
                        // cp d (dd prefix has no effect)
                        self.cp(self.registers.reg_d);
                    }
                    0xbb => {
                        // cp e (dd prefix has no effect)
                        self.cp(self.registers.reg_e);
                    }
                    0xbf => {
                        // cp a (dd prefix has no effect)
                        self.cp(self.registers.reg_a);
                    }
                    0x84 => {
                        // add a,ixh (undocumented)
                        let ixh: u8 = (self.registers.get_ix() >> 8) as u8;
                        self.add(ixh);
                    }
                    0x85 => {
                        // add a,ixl (undocumented)
                        let ixl: u8 = (self.registers.get_ix() & 0xff) as u8;
                        self.add(ixl);
                    }
                    0x86 => {
                        // add a,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            let value = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                            self.add(value);
                        } else {
                            let value = self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                            self.add(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x8c => {
                        // adc a,ixh (undocumented)
                        let ixh: u8 = (self.registers.get_ix() >> 8) as u8;
                        self.adc(ixh);
                    }
                    0x8d => {
                        // adc a,ixl (undocumented)
                        let ixl: u8 = (self.registers.get_ix() & 0xff) as u8;
                        self.adc(ixl);
                    }
                    0x8e => {
                        // adc a,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            let value = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                            self.adc(value);
                        } else {
                            let value = self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                            self.adc(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x94 => {
                        // sub a,ixh (undocumented)
                        let ixh: u8 = (self.registers.get_ix() >> 8) as u8;
                        self.sub(ixh);
                    }
                    0x95 => {
                        // sub a,ixl (undocumented)
                        let ixl: u8 = (self.registers.get_ix() & 0xff) as u8;
                        self.sub(ixl);
                    }
                    0x96 => {
                        // sub (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            let value = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                            self.sub(value);
                        } else {
                            let value = self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                            self.sub(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x9c => {
                        // sbc a,ixh (undocumented)
                        let ixh: u8 = (self.registers.get_ix() >> 8) as u8;
                        self.sbc(ixh);
                    }
                    0x9d => {
                        // sbc a,ixl (undocumented)
                        let ixl: u8 = (self.registers.get_ix() & 0xff) as u8;
                        self.sbc(ixl);
                    }
                    0x9e => {
                        // sbc a,(ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            let value = self
                                .bus
                                .read_mem(self.registers.get_ix() - u16::from(Cpu::abs(n)));
                            self.sbc(value);
                        } else {
                            let value = self.bus.read_mem(self.registers.get_ix() + u16::from(n));
                            self.sbc(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0xa4 => {
                        // and ixh (undocumented)
                        self.and(Type::Register(Regs::IXH));
                    }
                    0xa5 => {
                        // and ixl (undocumented)
                        self.and(Type::Register(Regs::IXL));
                    }
                    0xa6 => {
                        // and (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let ix = self.registers.get_ix();
                        if n & 0x80 == 0x80 {
                            self.and(Type::Direct(ix - u16::from(Cpu::abs(n))));
                        } else {
                            self.and(Type::Direct(ix + u16::from(n)));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0xac => {
                        // xor ixh (undocumented)
                        self.xor(Type::Register(Regs::IXH));
                    }
                    0xad => {
                        // xor ixl (undocumented)
                        self.xor(Type::Register(Regs::IXL));
                    }
                    0xae => {
                        // xor (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let ix = self.registers.get_ix();
                        if n & 0x80 == 0x80 {
                            self.xor(Type::Direct(ix - u16::from(Cpu::abs(n))));
                        } else {
                            self.xor(Type::Direct(ix + u16::from(n)));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0xb4 => {
                        // or ixh (undocumented)
                        self.or(Type::Register(Regs::IXH));
                    }
                    0xb5 => {
                        // or ixl (undocumented)
                        self.or(Type::Register(Regs::IXL));
                    }
                    0xb6 => {
                        // or (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let ix = self.registers.get_ix();
                        if n & 0x80 == 0x80 {
                            self.or(Type::Direct(ix - u16::from(Cpu::abs(n))));
                        } else {
                            self.or(Type::Direct(ix + u16::from(n)));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0xbc => {
                        // cp ixh (undocumented)
                        self.cp(self.registers.reg_ixh);
                    }
                    0xbd => {
                        // cp ixl (undocumented)
                        self.cp(self.registers.reg_ixl);
                    }
                    0xbe => {
                        // cp (ix+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        if n & 0x80 == 0x80 {
                            let ix = self.registers.get_ix().wrapping_sub(u16::from(Cpu::abs(n)));
                            let value = self.bus.read_mem(ix);
                            self.cp(value);
                        } else {
                            let ix = self.registers.get_ix().wrapping_add(u16::from(n));
                            let value = self.bus.read_mem(ix);
                            self.cp(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x24 => {
                        // inc ixh (undocumented)
                        self.registers.reg_ixh = self.inc(self.registers.reg_ixh);
                    }
                    0x25 => {
                        // dec ixh (undocumented)
                        self.registers.reg_ixh = self.dec(self.registers.reg_ixh);
                    }
                    0x26 => {
                        // ld ixh,n (undocumented)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_ixh = n;
                        self.registers.reg_pc += 1;
                    }
                    0x2c => {
                        // inc ixl (undocumented)
                        self.registers.reg_ixl = self.inc(self.registers.reg_ixl);
                    }
                    0x2d => {
                        // dec ixl (undocumented)
                        self.registers.reg_ixl = self.dec(self.registers.reg_ixl);
                    }
                    0x2e => {
                        // ld ixl,n (undocumented)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_ixl = n;
                        self.registers.reg_pc += 1;
                    }
                    0x44 => {
                        // ld b,ixh (undocumented)
                        self.registers.reg_b = self.registers.reg_ixh;
                    }
                    0x45 => {
                        // ld b,ixl (undocumented)
                        self.registers.reg_b = self.registers.reg_ixl;
                    }
                    0x4c => {
                        // ld c,ixh (undocumented)
                        self.registers.reg_c = self.registers.reg_ixh;
                    }
                    0x4d => {
                        // ld c,ixl (undocumented)
                        self.registers.reg_c = self.registers.reg_ixl;
                    }
                    0x54 => {
                        // ld d,ixh (undocumented)
                        self.registers.reg_d = self.registers.reg_ixh;
                    }
                    0x55 => {
                        // ld d,ixl (undocumented)
                        self.registers.reg_d = self.registers.reg_ixl;
                    }
                    0x5c => {
                        // ld e,ixh (undocumented)
                        self.registers.reg_e = self.registers.reg_ixh;
                    }
                    0x5d => {
                        // ld e,ixl (undocumented)
                        self.registers.reg_e = self.registers.reg_ixl;
                    }
                    0x60 => {
                        // ld ixh,b (undocumented)
                        self.registers.reg_ixh = self.registers.reg_b;
                    }
                    0x61 => {
                        // ld ixh,c (undocumented)
                        self.registers.reg_ixh = self.registers.reg_c;
                    }
                    0x62 => {
                        // ld ixh,d (undocumented)
                        self.registers.reg_ixh = self.registers.reg_d;
                    }
                    0x63 => {
                        // ld ixh,e (undocumented)
                        self.registers.reg_ixh = self.registers.reg_e;
                    }
                    0x64 => {
                        // ld ixh,ixh (undocumented)
                    }
                    0x65 => {
                        // ld ixh,ixl (undocumented)
                        self.registers.reg_ixh = self.registers.reg_ixl;
                    }
                    0x67 => {
                        // ld ixh,a (undocumented)
                        self.registers.reg_ixh = self.registers.reg_a;
                    }
                    0x68 => {
                        // ld ixl,b (undocumented)
                        self.registers.reg_ixl = self.registers.reg_b;
                    }
                    0x69 => {
                        // ld ixl,c (undocumented)
                        self.registers.reg_ixl = self.registers.reg_c;
                    }
                    0x6a => {
                        // ld ixl,d (undocumented)
                        self.registers.reg_ixl = self.registers.reg_d;
                    }
                    0x6b => {
                        // ld ixl,e (undocumented)
                        self.registers.reg_ixl = self.registers.reg_e;
                    }
                    0x6c => {
                        // ld ixl,ixh (undocumented)
                        self.registers.reg_ixl = self.registers.reg_ixh;
                    }
                    0x6d => {
                        // ld ixl,ixl (undocumented)
                    }
                    0x6f => {
                        // ld ixl,a (undocumented)
                        self.registers.reg_ixl = self.registers.reg_a;
                    }
                    0x7c => {
                        // ld a,ixh (undocumented)
                        self.registers.reg_a = self.registers.reg_ixh;
                    }
                    0x7d => {
                        // ld a,ixl (undocumented)
                        self.registers.reg_a = self.registers.reg_ixl;
                    }
                    0x40 => { // ld b,b (dd prefix has no effect)
                    }
                    0x41 => {
                        // ld b,c (dd prefix has no effect)
                        self.registers.reg_b = self.registers.reg_c;
                    }
                    0x42 => {
                        // ld b,d (dd prefix has no effect)
                        self.registers.reg_b = self.registers.reg_d;
                    }
                    0x43 => {
                        // ld b,e (dd prefix has no effect)
                        self.registers.reg_b = self.registers.reg_e;
                    }
                    0x47 => {
                        // ld b,a (dd prefix has no effect)
                        self.registers.reg_b = self.registers.reg_a;
                    }
                    0x48 => {
                        // ld c,b (dd prefix has no effect)
                        self.registers.reg_c = self.registers.reg_b;
                    }
                    0x49 => { // ld c,c (dd prefix has no effect)
                    }
                    0x4a => {
                        // ld c,d (dd prefix has no effect)
                        self.registers.reg_c = self.registers.reg_d;
                    }
                    0x4b => {
                        // ld c,e (dd prefix has no effect)
                        self.registers.reg_c = self.registers.reg_e;
                    }
                    0x4f => {
                        // ld c,a (dd prefix has no effect)
                        self.registers.reg_c = self.registers.reg_a;
                    }
                    0x50 => {
                        // ld d,b (dd prefix has no effect)
                        self.registers.reg_d = self.registers.reg_b;
                    }
                    0x51 => {
                        // ld d,c (dd prefix has no effect)
                        self.registers.reg_d = self.registers.reg_c;
                    }
                    0x52 => { // ld d,d (dd prefix has no effect)
                    }
                    0x53 => {
                        // ld d,e (dd prefix has no effect)
                        self.registers.reg_d = self.registers.reg_e;
                    }
                    0x57 => {
                        // ld d,a (dd prefix has no effect)
                        self.registers.reg_d = self.registers.reg_a;
                    }
                    0x58 => {
                        // ld e,b (dd prefix has no effect)
                        self.registers.reg_e = self.registers.reg_b;
                    }
                    0x59 => {
                        // ld e,c (dd prefix has no effect)
                        self.registers.reg_e = self.registers.reg_c;
                    }
                    0x5a => {
                        // ld e,d (dd prefix has no effect)
                        self.registers.reg_e = self.registers.reg_d;
                    }
                    0x5b => { // ld e,e (dd prefix has no effect)
                    }
                    0x5f => {
                        // ld e,a (dd prefix has no effect)
                        self.registers.reg_e = self.registers.reg_a;
                    }
                    0x76 => {
                        // halt (dd prefix has no effect)
                        self.halt = true;
                        self.registers.reg_pc = self.registers.reg_pc.wrapping_sub(1);
                    }
                    0x78 => {
                        // ld a,b (dd prefix has no effect)
                        self.registers.reg_a = self.registers.reg_b;
                    }
                    0x79 => {
                        // ld a,c (dd prefix has no effect)
                        self.registers.reg_a = self.registers.reg_c;
                    }
                    0x7a => {
                        // ld a,d (dd prefix has no effect)
                        self.registers.reg_a = self.registers.reg_d;
                    }
                    0x7b => {
                        // ld a,e (dd prefix has no effect)
                        self.registers.reg_a = self.registers.reg_e;
                    }
                    0x7f => { // ld a,a (dd prefix has no effect)
                    }
                    0xcb => {
                        // 0xddcb - IX Bit Instructions
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let opcode = self.bus.read_mem(self.registers.reg_pc + 1);
                        self.registers.reg_pc += 2;
                        let ix = self.registers.get_ix();
                        let addr = if n & 0x80 == 0x80 {
                            ix - u16::from(Cpu::abs(n))
                        } else {
                            ix + u16::from(n)
                        };
                        self.indexed_cb(addr, opcode);
                    }
                    0xe1 => {
                        // pop ix
                        self.registers
                            .set_ix(self.bus.read_mem_u16(self.registers.reg_sp));
                        self.registers.reg_sp = self.registers.reg_sp.wrapping_add(2);
                    }
                    0xe3 => {
                        // ex (sp),ix
                        let sp = self.registers.reg_sp;
                        let value = self.bus.read_mem_u16(sp);
                        self.bus.write_mem_u16(sp, self.registers.get_ix());
                        self.registers.set_ix(value);
                    }
                    0xe5 => {
                        // push ix
                        let ix = self.registers.get_ix();
                        self.push_stack(ix);
                    }
                    0xe9 => {
                        // jp (ix)
                        let ix = self.registers.get_ix();
                        self.registers.reg_pc = ix;
                    }
                    0xf9 => {
                        // ld sp,ix
                        self.registers.reg_sp = self.registers.get_ix();
                    }
                    _ => {
                        // DD prefix has no effect on this opcode (real Z80 behavior)
                        self.exec_base_opcode(opcode);
                    }
                }
            }
            0xde => {
                // sbc a,n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.sbc(n);
                self.registers.reg_pc += 1;
            }
            0xdf => {
                // rst 18h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0018;
            }
            0xe0 => {
                // ret po
                if !self.registers.reg_f.p {
                    self.registers.reg_pc = self.pop_stack();
                }
            }
            0xe1 => {
                // pop hl
                self.registers
                    .set_hl(self.bus.read_mem_u16(self.registers.reg_sp));
                self.registers.reg_sp = self.registers.reg_sp.wrapping_add(2);
            }
            0xe2 => {
                // jp po,$+3
                if self.registers.reg_f.p {
                    self.registers.reg_pc += 2;
                } else {
                    let value = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = value;
                }
            }
            0xe3 => {
                // ex (sp),hl
                let sp = self.registers.reg_sp;
                let value = self.bus.read_mem_u16(self.registers.reg_sp);
                self.bus
                    .write_mem_u16(self.registers.reg_sp, self.registers.get_hl());
                self.registers.set_hl(value);
            }
            0xe4 => {
                // call po,nn
                if self.registers.reg_f.p {
                    self.registers.reg_pc += 2;
                } else {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.push_stack(self.registers.reg_pc + 2);
                    self.registers.reg_pc = nn;
                }
            }
            0xe5 => {
                // push hl
                let hl = self.registers.get_hl();
                self.push_stack(hl);
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
                    self.registers.reg_pc = self.pop_stack();
                }
            }
            0xe9 => {
                // jp (hl)
                let hl = self.registers.get_hl();
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
                    self.push_stack(self.registers.reg_pc + 2);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xed => {
                // 0xdded prefix
                let prev_opcode = 0xdded;
                let opcode = self.bus.read_mem(self.registers.reg_pc);
                self.registers.reg_pc += 1;
                match opcode {
                    0x40 => {
                        // in b,(c)
                        let value = self.bus.read_io(self.registers.get_bc());
                        self.in_flags(value);
                        self.registers.reg_b = value;
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
                        self.neg();
                    }
                    0x45 => {
                        // retn
                        self.iff1 = self.iff2;
                        self.registers.reg_pc = self.pop_stack();
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
                        let value = self.bus.read_io(self.registers.get_bc());
                        self.in_flags(value);
                        self.registers.reg_c = value;
                    }
                    0x49 => {
                        // out (c),c
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_c);
                    }
                    0x4a => {
                        // adc hl,bc
                        let hl = self.registers.get_hl();
                        let bc = self.registers.get_bc();
                        self.adc16(bc);
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
                        self.registers.reg_pc = self.pop_stack();
                    }
                    0x4f => {
                        // ld r,a
                        self.registers.reg_r = self.registers.reg_a;
                    }
                    0x50 => {
                        // in d,(c)
                        let value = self.bus.read_io(self.registers.get_bc());
                        self.in_flags(value);
                        self.registers.reg_d = value;
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
                        self.flags_written = true;
                        self.registers.reg_a = self.registers.reg_i;
                        self.registers.reg_f.z = self.registers.reg_i == 0;
                        self.registers.reg_f.s = self.registers.reg_i & 0x80 != 0;
                        self.registers.reg_f.p = self.iff2;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.h = false;
                        self.registers.reg_f.y = self.registers.reg_i & YF == YF;
                        self.registers.reg_f.x = self.registers.reg_i & XF == XF;
                    }
                    0x58 => {
                        // in e,(c)
                        let value = self.bus.read_io(self.registers.get_bc());
                        self.in_flags(value);
                        self.registers.reg_e = value;
                    }
                    0x59 => {
                        // out (c),e
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_e);
                    }
                    0x5a => {
                        // adc hl,de
                        let de = self.registers.get_de();
                        self.adc16(de);
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
                        self.flags_written = true;
                        self.registers.reg_a = self.registers.reg_r;
                        self.registers.reg_f.z = self.registers.reg_r == 0;
                        self.registers.reg_f.s = self.registers.reg_r & 0x80 != 0;
                        self.registers.reg_f.p = self.iff2;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.h = false;
                        self.registers.reg_f.y = self.registers.reg_r & YF == YF;
                        self.registers.reg_f.x = self.registers.reg_r & XF == XF;
                    }
                    0x60 => {
                        // in h,(c)
                        let value = self.bus.read_io(self.registers.get_bc());
                        self.in_flags(value);
                        self.registers.reg_h = value;
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
                    0x63 => {
                        // ld (nn),hl
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        self.bus.write_mem_u16(nn, self.registers.get_hl());
                        self.registers.reg_pc += 2;
                    }
                    0x67 => {
                        // rrd
                        self.flags_written = true;
                        let value = self.bus.read_mem(self.registers.get_hl());
                        let a = self.registers.reg_a;
                        self.registers.reg_a = (a & 0xf0) | (value & 0x0f);
                        self.registers.reg_f.h = false;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.z = self.registers.reg_a == 0;
                        self.registers.reg_f.s = self.registers.reg_a & 0x80 != 0;
                        self.registers.reg_f.p = self.registers.reg_a.count_ones() & 0x01 == 0x00;
                        self.registers.reg_f.y = self.registers.reg_a & YF == YF;
                        self.registers.reg_f.x = self.registers.reg_a & XF == XF;
                        self.bus
                            .write_mem(self.registers.get_hl(), (a << 4) | (value >> 4));
                    }
                    0x68 => {
                        // in l,(c)
                        let value = self.bus.read_io(self.registers.get_bc());
                        self.in_flags(value);
                        self.registers.reg_l = value;
                    }
                    0x69 => {
                        // out (c),l
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_l);
                    }
                    0x6a => {
                        // adc hl,hl
                        let hl = self.registers.get_hl();
                        self.adc16(hl);
                    }
                    0x6b => {
                        // ld hl,(nn)
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        let n = self.bus.read_mem_u16(nn);
                        self.registers.set_hl(n);
                        self.registers.reg_pc += 2;
                    }
                    0x6f => {
                        // rld
                        self.flags_written = true;
                        let value = self.bus.read_mem(self.registers.get_hl());
                        let a = self.registers.reg_a;
                        self.registers.reg_a = (value >> 4) | (a & 0xf0);
                        self.registers.reg_f.h = false;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.z = self.registers.reg_a == 0;
                        self.registers.reg_f.s = self.registers.reg_a & 0x80 != 0;
                        self.registers.reg_f.p = self.registers.reg_a.count_ones() & 0x01 == 0x00;
                        self.registers.reg_f.y = self.registers.reg_a & YF == YF;
                        self.registers.reg_f.x = self.registers.reg_a & XF == XF;
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
                    0x70 => {
                        // in (c) (undocumented)
                        let value = self.bus.read_io(self.registers.get_bc());
                        self.in_flags(value);
                    }
                    0x71 => {
                        // out (c),0 (undocumented)
                        self.bus.write_io(self.registers.get_bc(), 0);
                    }
                    0x78 => {
                        // in a,(c)
                        let value = self.bus.read_io(self.registers.get_bc());
                        self.in_flags(value);
                        self.registers.reg_a = value;
                    }
                    0x79 => {
                        // out (c),a
                        self.bus
                            .write_io(self.registers.get_bc(), self.registers.reg_a);
                    }
                    0x7a => {
                        // adc hl,sp
                        let sp = self.registers.get_sp();
                        self.adc16(sp);
                    }
                    0x7b => {
                        // ld sp,(nn)
                        let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                        let n = self.bus.read_mem_u16(nn);
                        self.registers.set_sp(n);
                        self.registers.reg_pc += 2;
                    }
                    0x7c | 0x74 | 0x6c | 0x64 | 0x5c | 0x54 | 0x4c => {
                        // neg (undocumented)
                        self.neg();
                    }
                    0xa0 => {
                        // ldi
                        self.flags_written = true;
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
                        let n = self.registers.reg_a.wrapping_add(value);
                        self.registers.reg_f.y = n & 0x02 != 0;
                        self.registers.reg_f.x = n & 0x08 != 0;
                    }
                    0xa1 => {
                        // cpi
                        self.cpi();
                    }
                    0xa2 => {
                        // ini
                        self.ini();
                    }
                    0xa3 => {
                        // outi
                        self.outi();
                    }
                    0xa8 => {
                        // ldd
                        self.flags_written = true;
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
                        let n = self.registers.reg_a.wrapping_add(value);
                        self.registers.reg_f.y = n & 0x02 != 0;
                        self.registers.reg_f.x = n & 0x08 != 0;
                    }
                    0xa9 => {
                        // cpd
                        self.cpd();
                    }
                    0xaa => {
                        // ind
                        self.ind();
                    }
                    0xab => {
                        // outd
                        self.outd();
                    }
                    0xb0 => {
                        // ldir
                        self.flags_written = true;
                        let mut hl = self.registers.get_hl();
                        let mut de = self.registers.get_de();
                        let mut bc = self.registers.get_bc();
                        let mut value = 0;
                        while bc != 0 {
                            value = self.bus.read_mem(hl);
                            self.bus.write_mem(de, value);
                            hl = hl.wrapping_add(1);
                            de = de.wrapping_add(1);
                            bc = bc.wrapping_sub(1);
                        }
                        self.registers.set_hl(hl);
                        self.registers.set_de(de);
                        self.registers.set_bc(bc);
                        self.registers.reg_f.h = false;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.p = bc != 0;
                        let n = self.registers.reg_a.wrapping_add(value);
                        self.registers.reg_f.y = n & 0x02 != 0;
                        self.registers.reg_f.x = n & 0x08 != 0;
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
                    0xb2 => {
                        // inir
                        loop {
                            self.ini();
                            if self.registers.reg_b == 0 {
                                break;
                            }
                        }
                    }
                    0xb3 => {
                        // otir
                        loop {
                            self.outi();
                            if self.registers.reg_b == 0 {
                                break;
                            }
                        }
                    }
                    0xb8 => {
                        // lddr
                        self.flags_written = true;
                        let mut hl = self.registers.get_hl();
                        let mut de = self.registers.get_de();
                        let mut bc = self.registers.get_bc();
                        let mut value = 0;
                        while bc > 0 {
                            value = self.bus.read_mem(hl);
                            self.bus.write_mem(de, value);
                            hl = hl.wrapping_sub(1);
                            de = de.wrapping_sub(1);
                            bc = bc.wrapping_sub(1);
                        }
                        self.registers.set_hl(hl);
                        self.registers.set_de(de);
                        self.registers.set_bc(bc);
                        self.registers.reg_f.h = false;
                        self.registers.reg_f.n = false;
                        self.registers.reg_f.p = bc != 0;
                        let n = self.registers.reg_a.wrapping_add(value);
                        self.registers.reg_f.y = n & 0x02 != 0;
                        self.registers.reg_f.x = n & 0x08 != 0;
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
                    0xba => {
                        // indr
                        loop {
                            self.ind();
                            if self.registers.reg_b == 0 {
                                break;
                            }
                        }
                    }
                    0xbb => {
                        // otdr
                        loop {
                            self.outd();
                            if self.registers.reg_b == 0 {
                                break;
                            }
                        }
                    }
                    _ => {
                        // Undefined ED-prefixed opcode: real Z80 hardware treats
                        // any ED byte not otherwise assigned as a 2-byte NOP.
                    }
                }
            }
            0xee => {
                // xor n
                let n = self.bus.read_mem(self.registers.reg_pc);
                self.xor(Type::Immediate(n));
                self.registers.reg_pc += 1;
            }
            0xef => {
                // rst 28h
                self.push_stack(self.registers.reg_pc);
                self.registers.reg_pc = 0x0028;
            }
            0xf0 => {
                // ret p
                if !self.registers.reg_f.s {
                    self.registers.reg_pc = self.pop_stack();
                }
            }
            0xf1 => {
                // pop af
                self.registers.reg_f = self.bus.read_mem(self.registers.reg_sp).into();
                self.registers.reg_a = self.bus.read_mem(self.registers.reg_sp + 1);
                self.registers.reg_sp = self.registers.reg_sp.wrapping_add(2);
            }
            0xf2 => {
                // jp p,$+3
                if self.registers.reg_f.s {
                    self.registers.reg_pc += 2;
                } else {
                    let value = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.registers.reg_pc = value;
                }
            }
            0xf3 => {
                // di
                self.iff1 = false;
                self.iff2 = false;
            }
            0xf4 => {
                // call p,nn
                if self.registers.reg_f.s {
                    self.registers.reg_pc += 2;
                } else {
                    let value = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.push_stack(self.registers.reg_pc + 2);
                    self.registers.reg_pc = value;
                }
            }
            0xf5 => {
                // push af
                let af = self.registers.get_af();
                self.push_stack(af);
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
                    self.registers.reg_pc = self.pop_stack();
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
                self.iff1 = true;
                self.iff2 = true;
            }
            0xfc => {
                // call m,nn
                if self.registers.reg_f.s {
                    let nn = self.bus.read_mem_u16(self.registers.reg_pc);
                    self.push_stack(self.registers.reg_pc + 2);
                    self.registers.reg_pc = nn;
                } else {
                    self.registers.reg_pc += 2;
                }
            }
            0xfd => {
                // IY prefix
                let prev_opcode = opcode;
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
                        if n & 0x80 == 0x80 {
                            let addr = iy - u16::from(Cpu::abs(n));
                            let value = self.bus.read_mem(addr);
                            let result = self.inc(value);
                            self.bus.write_mem(addr, result);
                        } else {
                            let addr = iy + u16::from(n);
                            let value = self.bus.read_mem(addr);
                            let result = self.inc(value);
                            self.bus.write_mem(addr, result);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x35 => {
                        // dec (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let addr = iy - u16::from(Cpu::abs(n));
                            let value = self.bus.read_mem(addr);
                            let result = self.dec(value);
                            self.bus.write_mem(addr, result);
                        } else {
                            let addr = iy + u16::from(n);
                            let value = self.bus.read_mem(addr);
                            let result = self.dec(value);
                            self.bus.write_mem(addr, result);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x36 => {
                        // ld (iy+n),n
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(self.registers.reg_pc + 1);
                            self.bus.write_mem(iy - u16::from(Cpu::abs(n)), value);
                        } else {
                            let value = self.bus.read_mem(self.registers.reg_pc + 1);
                            self.bus.write_mem(iy + u16::from(n), value);
                        }
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
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.registers.reg_b = value;
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.registers.reg_b = value;
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x4e => {
                        // ld c,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.registers.reg_c = value;
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.registers.reg_c = value;
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x56 => {
                        // ld d,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.registers.reg_d = value;
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.registers.reg_d = value;
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x5e => {
                        // ld e,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.registers.reg_e = value;
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.registers.reg_e = value;
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x66 => {
                        // ld h,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.registers.reg_h = value;
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.registers.reg_h = value;
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x6e => {
                        // ld l,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.registers.reg_l = value;
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.registers.reg_l = value;
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x70 => {
                        // ld (iy+n),b
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.bus
                                .write_mem(iy - u16::from(Cpu::abs(n)), self.registers.reg_b);
                        } else {
                            self.bus.write_mem(iy + u16::from(n), self.registers.reg_b);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x71 => {
                        // ld (iy+n),c
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.bus
                                .write_mem(iy - u16::from(Cpu::abs(n)), self.registers.reg_c);
                        } else {
                            self.bus.write_mem(iy + u16::from(n), self.registers.reg_c);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x72 => {
                        // ld (iy+n),d
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.bus
                                .write_mem(iy - u16::from(Cpu::abs(n)), self.registers.reg_d);
                        } else {
                            self.bus.write_mem(iy + u16::from(n), self.registers.reg_d);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x73 => {
                        // ld (iy+n),e
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.bus
                                .write_mem(iy - u16::from(Cpu::abs(n)), self.registers.reg_e);
                        } else {
                            self.bus.write_mem(iy + u16::from(n), self.registers.reg_e);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x74 => {
                        // ld (iy+n),h
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.bus
                                .write_mem(iy - u16::from(Cpu::abs(n)), self.registers.reg_h);
                        } else {
                            self.bus.write_mem(iy + u16::from(n), self.registers.reg_h);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x75 => {
                        // ld (iy+n),l
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.bus
                                .write_mem(iy - u16::from(Cpu::abs(n)), self.registers.reg_l);
                        } else {
                            self.bus.write_mem(iy + u16::from(n), self.registers.reg_l);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x77 => {
                        // ld (iy+n),a
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.bus
                                .write_mem(iy - u16::from(Cpu::abs(n)), self.registers.reg_a);
                        } else {
                            self.bus.write_mem(iy + u16::from(n), self.registers.reg_a);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x7e => {
                        // ld a,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.registers.reg_a = value;
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.registers.reg_a = value;
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x80 => {
                        // add a,b (fd prefix has no effect)
                        self.add(self.registers.reg_b);
                    }
                    0x81 => {
                        // add a,c (fd prefix has no effect)
                        self.add(self.registers.reg_c);
                    }
                    0x82 => {
                        // add a,d (fd prefix has no effect)
                        self.add(self.registers.reg_d);
                    }
                    0x83 => {
                        // add a,e (fd prefix has no effect)
                        self.add(self.registers.reg_e);
                    }
                    0x87 => {
                        // add a,a (fd prefix has no effect)
                        self.add(self.registers.reg_a);
                    }
                    0x88 => {
                        // adc a,b (fd prefix has no effect)
                        self.adc(self.registers.reg_b);
                    }
                    0x89 => {
                        // adc a,c (fd prefix has no effect)
                        self.adc(self.registers.reg_c);
                    }
                    0x8a => {
                        // adc a,d (fd prefix has no effect)
                        self.adc(self.registers.reg_d);
                    }
                    0x8b => {
                        // adc a,e (fd prefix has no effect)
                        self.adc(self.registers.reg_e);
                    }
                    0x8f => {
                        // adc a,a (fd prefix has no effect)
                        self.adc(self.registers.reg_a);
                    }
                    0x90 => {
                        // sub b (fd prefix has no effect)
                        self.sub(self.registers.reg_b);
                    }
                    0x91 => {
                        // sub c (fd prefix has no effect)
                        self.sub(self.registers.reg_c);
                    }
                    0x92 => {
                        // sub d (fd prefix has no effect)
                        self.sub(self.registers.reg_d);
                    }
                    0x93 => {
                        // sub e (fd prefix has no effect)
                        self.sub(self.registers.reg_e);
                    }
                    0x97 => {
                        // sub a (fd prefix has no effect)
                        self.sub(self.registers.reg_a);
                    }
                    0x98 => {
                        // sbc b (fd prefix has no effect)
                        self.sbc(self.registers.reg_b);
                    }
                    0x99 => {
                        // sbc c (fd prefix has no effect)
                        self.sbc(self.registers.reg_c);
                    }
                    0x9a => {
                        // sbc d (fd prefix has no effect)
                        self.sbc(self.registers.reg_d);
                    }
                    0x9b => {
                        // sbc e (fd prefix has no effect)
                        self.sbc(self.registers.reg_e);
                    }
                    0x9f => {
                        // sbc a (fd prefix has no effect)
                        self.sbc(self.registers.reg_a);
                    }
                    0xa0 => {
                        // and b (fd prefix has no effect)
                        self.and(Type::Register(Regs::B));
                    }
                    0xa1 => {
                        // and c (fd prefix has no effect)
                        self.and(Type::Register(Regs::C));
                    }
                    0xa2 => {
                        // and d (fd prefix has no effect)
                        self.and(Type::Register(Regs::D));
                    }
                    0xa3 => {
                        // and e (fd prefix has no effect)
                        self.and(Type::Register(Regs::E));
                    }
                    0xa7 => {
                        // and a (fd prefix has no effect)
                        self.and(Type::Register(Regs::A));
                    }
                    0xa8 => {
                        // xor b (fd prefix has no effect)
                        self.xor(Type::Register(Regs::B));
                    }
                    0xa9 => {
                        // xor c (fd prefix has no effect)
                        self.xor(Type::Register(Regs::C));
                    }
                    0xaa => {
                        // xor d (fd prefix has no effect)
                        self.xor(Type::Register(Regs::D));
                    }
                    0xab => {
                        // xor e (fd prefix has no effect)
                        self.xor(Type::Register(Regs::E));
                    }
                    0xaf => {
                        // xor a (fd prefix has no effect)
                        self.xor(Type::Register(Regs::A));
                    }
                    0xb0 => {
                        // or b (fd prefix has no effect)
                        self.or(Type::Register(Regs::B));
                    }
                    0xb1 => {
                        // or c (fd prefix has no effect)
                        self.or(Type::Register(Regs::C));
                    }
                    0xb2 => {
                        // or d (fd prefix has no effect)
                        self.or(Type::Register(Regs::D));
                    }
                    0xb3 => {
                        // or e (fd prefix has no effect)
                        self.or(Type::Register(Regs::E));
                    }
                    0xb7 => {
                        // or a (fd prefix has no effect)
                        self.or(Type::Register(Regs::A));
                    }
                    0xb8 => {
                        // cp b (fd prefix has no effect)
                        self.cp(self.registers.reg_b);
                    }
                    0xb9 => {
                        // cp c (fd prefix has no effect)
                        self.cp(self.registers.reg_c);
                    }
                    0xba => {
                        // cp d (fd prefix has no effect)
                        self.cp(self.registers.reg_d);
                    }
                    0xbb => {
                        // cp e (fd prefix has no effect)
                        self.cp(self.registers.reg_e);
                    }
                    0xbf => {
                        // cp a (fd prefix has no effect)
                        self.cp(self.registers.reg_a);
                    }
                    0x84 => {
                        // add a,iyh (undocumented)
                        let iyh: u8 = (self.registers.get_iy() >> 8) as u8;
                        self.add(iyh);
                    }
                    0x85 => {
                        // add a,iyl (undocumented)
                        let iyl: u8 = (self.registers.get_iy() & 0xff) as u8;
                        self.add(iyl);
                    }
                    0x86 => {
                        // add a,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.add(value);
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.add(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x8c => {
                        // adc iyh (undocumented)
                        let iyh: u8 = (self.registers.get_iy() >> 8) as u8;
                        self.adc(iyh);
                    }
                    0x8d => {
                        // adc iyl (undocumented)
                        let iyl: u8 = (self.registers.get_iy() & 0xff) as u8;
                        self.adc(iyl);
                    }
                    0x8e => {
                        // adc a,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.adc(value);
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.adc(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x94 => {
                        // sub a,iyh (undocumented)
                        let iyh: u8 = (self.registers.get_iy() >> 8) as u8;
                        self.sub(iyh);
                    }
                    0x95 => {
                        // sub a,iyl (undocumented)
                        let iyl: u8 = (self.registers.get_iy() & 0xff) as u8;
                        self.sub(iyl);
                    }
                    0x96 => {
                        // sub (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.sub(value);
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.sub(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x9c => {
                        // sbc a,iyh (undocumented)
                        let iyh: u8 = (self.registers.get_iy() >> 8) as u8;
                        self.sbc(iyh);
                    }
                    0x9d => {
                        // sbc a,iyl (undocumented)
                        let iyl: u8 = (self.registers.get_iy() & 0xff) as u8;
                        self.sbc(iyl);
                    }
                    0x9e => {
                        // sbc a,(iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy - u16::from(Cpu::abs(n)));
                            self.sbc(value);
                        } else {
                            let value = self.bus.read_mem(iy + u16::from(n));
                            self.sbc(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0xa4 => {
                        // and iyh (undocumented)
                        self.and(Type::Register(Regs::IYH));
                    }
                    0xa5 => {
                        // and iyl (undocumented)
                        self.and(Type::Register(Regs::IYL));
                    }
                    0xa6 => {
                        // and (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.and(Type::Direct(iy - u16::from(Cpu::abs(n))));
                        } else {
                            self.and(Type::Direct(iy + u16::from(n)));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0xac => {
                        // xor iyh (undocumented)
                        self.xor(Type::Register(Regs::IYH));
                    }
                    0xad => {
                        // xor iyl (undocumented)
                        self.xor(Type::Register(Regs::IYL));
                    }
                    0xae => {
                        // xor (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.xor(Type::Direct(iy - u16::from(Cpu::abs(n))));
                        } else {
                            self.xor(Type::Direct(iy + u16::from(n)));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0xb4 => {
                        // or iyh (undocumented)
                        self.or(Type::Register(Regs::IYH));
                    }
                    0xb5 => {
                        // or iyl (undocumented)
                        self.or(Type::Register(Regs::IYL));
                    }
                    0xb6 => {
                        // or (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            self.or(Type::Direct(iy - u16::from(Cpu::abs(n))));
                        } else {
                            self.or(Type::Direct(iy + u16::from(n)));
                        }
                        self.registers.reg_pc += 1;
                    }
                    0xbc => {
                        // cp iyh (undocumented)
                        self.cp(self.registers.reg_iyh);
                    }
                    0xbd => {
                        // cp iyl (undocumented)
                        self.cp(self.registers.reg_iyl);
                    }
                    0xbe => {
                        // cp (iy+n)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let iy = self.registers.get_iy();
                        if n & 0x80 == 0x80 {
                            let value = self.bus.read_mem(iy.wrapping_sub(u16::from(Cpu::abs(n))));
                            self.cp(value);
                        } else {
                            let value = self.bus.read_mem(iy.wrapping_add(u16::from(n)));
                            self.cp(value);
                        }
                        self.registers.reg_pc += 1;
                    }
                    0x24 => {
                        // inc iyh (undocumented)
                        self.registers.reg_iyh = self.inc(self.registers.reg_iyh);
                    }
                    0x25 => {
                        // dec iyh (undocumented)
                        self.registers.reg_iyh = self.dec(self.registers.reg_iyh);
                    }
                    0x26 => {
                        // ld iyh,n (undocumented)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_iyh = n;
                        self.registers.reg_pc += 1;
                    }
                    0x2c => {
                        // inc iyl (undocumented)
                        self.registers.reg_iyl = self.inc(self.registers.reg_iyl);
                    }
                    0x2d => {
                        // dec iyl (undocumented)
                        self.registers.reg_iyl = self.dec(self.registers.reg_iyl);
                    }
                    0x2e => {
                        // ld iyl,n (undocumented)
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        self.registers.reg_iyl = n;
                        self.registers.reg_pc += 1;
                    }
                    0x44 => {
                        // ld b,iyh (undocumented)
                        self.registers.reg_b = self.registers.reg_iyh;
                    }
                    0x45 => {
                        // ld b,iyl (undocumented)
                        self.registers.reg_b = self.registers.reg_iyl;
                    }
                    0x4c => {
                        // ld c,iyh (undocumented)
                        self.registers.reg_c = self.registers.reg_iyh;
                    }
                    0x4d => {
                        // ld c,iyl (undocumented)
                        self.registers.reg_c = self.registers.reg_iyl;
                    }
                    0x54 => {
                        // ld d,iyh (undocumented)
                        self.registers.reg_d = self.registers.reg_iyh;
                    }
                    0x55 => {
                        // ld d,iyl (undocumented)
                        self.registers.reg_d = self.registers.reg_iyl;
                    }
                    0x5c => {
                        // ld e,iyh (undocumented)
                        self.registers.reg_e = self.registers.reg_iyh;
                    }
                    0x5d => {
                        // ld e,iyl (undocumented)
                        self.registers.reg_e = self.registers.reg_iyl;
                    }
                    0x60 => {
                        // ld iyh,b (undocumented)
                        self.registers.reg_iyh = self.registers.reg_b;
                    }
                    0x61 => {
                        // ld iyh,c (undocumented)
                        self.registers.reg_iyh = self.registers.reg_c;
                    }
                    0x62 => {
                        // ld iyh,d (undocumented)
                        self.registers.reg_iyh = self.registers.reg_d;
                    }
                    0x63 => {
                        // ld iyh,e (undocumented)
                        self.registers.reg_iyh = self.registers.reg_e;
                    }
                    0x64 => {
                        // ld iyh,iyh (undocumented)
                    }
                    0x65 => {
                        // ld iyh,iyl (undocumented)
                        self.registers.reg_iyh = self.registers.reg_iyl;
                    }
                    0x67 => {
                        // ld iyh,a (undocumented)
                        self.registers.reg_iyh = self.registers.reg_a;
                    }
                    0x68 => {
                        // ld iyl,b (undocumented)
                        self.registers.reg_iyl = self.registers.reg_b;
                    }
                    0x69 => {
                        // ld iyl,c (undocumented)
                        self.registers.reg_iyl = self.registers.reg_c;
                    }
                    0x6a => {
                        // ld iyl,d (undocumented)
                        self.registers.reg_iyl = self.registers.reg_d;
                    }
                    0x6b => {
                        // ld iyl,e (undocumented)
                        self.registers.reg_iyl = self.registers.reg_e;
                    }
                    0x6c => {
                        // ld iyl,iyh (undocumented)
                        self.registers.reg_iyl = self.registers.reg_iyh;
                    }
                    0x6d => {
                        // ld iyl,iyl (undocumented)
                    }
                    0x6f => {
                        // ld iyl,a (undocumented)
                        self.registers.reg_iyl = self.registers.reg_a;
                    }
                    0x7c => {
                        // ld a,iyh (undocumented)
                        self.registers.reg_a = self.registers.reg_iyh;
                    }
                    0x7d => {
                        // ld a,iyl (undocumented)
                        self.registers.reg_a = self.registers.reg_iyl;
                    }
                    0x40 => { // ld b,b (fd prefix has no effect)
                    }
                    0x41 => {
                        // ld b,c (fd prefix has no effect)
                        self.registers.reg_b = self.registers.reg_c;
                    }
                    0x42 => {
                        // ld b,d (fd prefix has no effect)
                        self.registers.reg_b = self.registers.reg_d;
                    }
                    0x43 => {
                        // ld b,e (fd prefix has no effect)
                        self.registers.reg_b = self.registers.reg_e;
                    }
                    0x47 => {
                        // ld b,a (fd prefix has no effect)
                        self.registers.reg_b = self.registers.reg_a;
                    }
                    0x48 => {
                        // ld c,b (fd prefix has no effect)
                        self.registers.reg_c = self.registers.reg_b;
                    }
                    0x49 => { // ld c,c (fd prefix has no effect)
                    }
                    0x4a => {
                        // ld c,d (fd prefix has no effect)
                        self.registers.reg_c = self.registers.reg_d;
                    }
                    0x4b => {
                        // ld c,e (fd prefix has no effect)
                        self.registers.reg_c = self.registers.reg_e;
                    }
                    0x4f => {
                        // ld c,a (fd prefix has no effect)
                        self.registers.reg_c = self.registers.reg_a;
                    }
                    0x50 => {
                        // ld d,b (fd prefix has no effect)
                        self.registers.reg_d = self.registers.reg_b;
                    }
                    0x51 => {
                        // ld d,c (fd prefix has no effect)
                        self.registers.reg_d = self.registers.reg_c;
                    }
                    0x52 => { // ld d,d (fd prefix has no effect)
                    }
                    0x53 => {
                        // ld d,e (fd prefix has no effect)
                        self.registers.reg_d = self.registers.reg_e;
                    }
                    0x57 => {
                        // ld d,a (fd prefix has no effect)
                        self.registers.reg_d = self.registers.reg_a;
                    }
                    0x58 => {
                        // ld e,b (fd prefix has no effect)
                        self.registers.reg_e = self.registers.reg_b;
                    }
                    0x59 => {
                        // ld e,c (fd prefix has no effect)
                        self.registers.reg_e = self.registers.reg_c;
                    }
                    0x5a => {
                        // ld e,d (fd prefix has no effect)
                        self.registers.reg_e = self.registers.reg_d;
                    }
                    0x5b => { // ld e,e (fd prefix has no effect)
                    }
                    0x5f => {
                        // ld e,a (fd prefix has no effect)
                        self.registers.reg_e = self.registers.reg_a;
                    }
                    0x76 => {
                        // halt (fd prefix has no effect)
                        self.halt = true;
                        self.registers.reg_pc = self.registers.reg_pc.wrapping_sub(1);
                    }
                    0x78 => {
                        // ld a,b (fd prefix has no effect)
                        self.registers.reg_a = self.registers.reg_b;
                    }
                    0x79 => {
                        // ld a,c (fd prefix has no effect)
                        self.registers.reg_a = self.registers.reg_c;
                    }
                    0x7a => {
                        // ld a,d (fd prefix has no effect)
                        self.registers.reg_a = self.registers.reg_d;
                    }
                    0x7b => {
                        // ld a,e (fd prefix has no effect)
                        self.registers.reg_a = self.registers.reg_e;
                    }
                    0x7f => { // ld a,a (fd prefix has no effect)
                    }
                    0xcb => {
                        // 0xfdcb - IY Bit Instructions
                        let n = self.bus.read_mem(self.registers.reg_pc);
                        let opcode = self.bus.read_mem(self.registers.reg_pc + 1);
                        self.registers.reg_pc += 2;
                        let iy = self.registers.get_iy();
                        let addr = if n & 0x80 == 0x80 {
                            iy - u16::from(Cpu::abs(n))
                        } else {
                            iy + u16::from(n)
                        };
                        self.indexed_cb(addr, opcode);
                    }
                    0xe1 => {
                        // pop iy
                        self.registers
                            .set_iy(self.bus.read_mem_u16(self.registers.reg_sp));
                        self.registers.reg_sp = self.registers.reg_sp.wrapping_add(2);
                    }
                    0xe3 => {
                        // ex (sp),iy
                        let sp = self.registers.reg_sp;
                        let value = self.bus.read_mem_u16(sp);
                        self.bus.write_mem_u16(sp, self.registers.get_iy());
                        self.registers.set_iy(value);
                    }
                    0xe5 => {
                        // push iy
                        let iy = self.registers.get_iy();
                        self.push_stack(iy);
                    }
                    0xe9 => {
                        // jp (iy)
                        let iy = self.registers.get_iy();
                        self.registers.reg_pc = iy;
                    }
                    0xf9 => {
                        // ld sp,iy
                        self.registers.reg_sp = self.registers.get_iy();
                    }
                    _ => {
                        // FD prefix has no effect on this opcode (real Z80 behavior)
                        self.exec_base_opcode(opcode);
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
        self.int = None;
    }

    pub fn run(&mut self) {}

    /// Execute one opcode
    pub fn step(&mut self) {
        if self.int.is_some() {
            self.process_interrupt();
        }
        self.flags_written = false;
        self.exec_opcode();
        self.registers.reg_q = if self.flags_written {
            self.registers.reg_f.to_byte()
        } else {
            0
        };
        let rhb = self.registers.reg_r & 0x80;
        self.registers.reg_r = (self.registers.reg_r.wrapping_add(1) & 0x7f) | rhb;
    }

    /// Execute `no_steps` opcodes
    pub fn steps(&mut self, no_steps: u16) {
        for _ in 0..no_steps {
            self.step();
        }
    }

    /// Reset the Cpu
    pub fn reset(&mut self) {
        self.reset = true;
        self.hard_reset = false;
        self.registers = Registers::default();
    }

    /// Hard reset the Cpu
    pub fn hard_reset(&mut self) {
        self.reset = false;
        self.hard_reset = true;
        self.registers = Registers::default();
    }
}

#[cfg(test)]
#[allow(clippy::cast_possible_truncation)] // test fixtures are always well under 64KB
mod tests {
    extern crate std;
    use super::Cpu;
    use super::Type;

    #[test]
    fn testing_abs_function() {
        let value = Cpu::abs(0xfe);
        assert_eq!(value, 0x02);
    }

    #[test]
    fn testing_push_pop_af() {
        use crate::flags;

        let mut cpu = Cpu::new(None);

        cpu.bus.write_mem(0x1000, flags::ZF | flags::CF | flags::PF);
        cpu.bus.write_mem(0x1001, 0x55);
        cpu.bus.write_mem(0x2000, 0xf1); // POP AF

        cpu.registers.reg_sp = 0x1000;
        cpu.registers.reg_pc = 0x2000;

        cpu.exec_opcode();

        assert_eq!(cpu.registers.reg_sp, 0x1002);
        assert_eq!(cpu.registers.reg_pc, 0x2001);
        assert_eq!(
            cpu.registers.reg_f.to_byte(),
            flags::ZF | flags::CF | flags::PF
        );
        assert_eq!(cpu.registers.reg_a, 0x55);
    }

    #[test]
    fn testing_cpu_execution() {
        let program = std::vec![
            0x3e, 0xff, 0x06, 0x80, 0x0e, 0xaa, 0x16, 0x55, 0x1e, 0x10, 0x26, 0x20, 0x2e, 0x40,
            0xd9, 0xcb, 0x17, 0xdd, 0x09,
        ];

        let mut cpu = Cpu::new(None);
        for (addr, &opcode) in program.iter().enumerate() {
            cpu.bus.write_mem(addr as u16, opcode);
        }
        cpu.bus.write_mem(0x2000, 0xaa);

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
        assert!(cpu.registers.reg_f.c);
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
}

#![allow(dead_code)]
use crate::flags::Flags;

macro_rules! z80_reg_pair {
    ($get_fn:ident, $set_fn:ident, $reg_h:ident, $reg_l:ident) => {
        pub fn $get_fn(&mut self) -> u16 {
            ((self.$reg_h as u16) << 8 | self.$reg_l as u16) as u16
        }

        pub fn $set_fn(&mut self, value: u16) {
            self.$reg_h = (value >> 8 & 0xff) as u8;
            self.$reg_l = (value & 0xff) as u8;
        }
    };
}

pub enum Regs {
    A,
    B,
    C,
    D,
    E,
    H,
    L,
    BC,
    DE,
    HL,
    IX,
    IY,
    SP,
}

#[derive(Default)]
pub struct Registers {
    // Main registers
    pub reg_f: Flags,
    pub reg_a: u8,
    pub reg_b: u8,
    pub reg_c: u8,
    pub reg_d: u8,
    pub reg_e: u8,
    pub reg_h: u8,
    pub reg_l: u8,
    // Special purpose registers
    pub reg_i: u8,
    pub reg_r: u8,
    pub reg_ixh: u8,
    pub reg_ixl: u8,
    pub reg_iyh: u8,
    pub reg_iyl: u8,
    pub reg_sp: u16,
    pub reg_pc: u16,
}

impl Registers {
    pub fn new() -> Self {
        Self {
            reg_f: Flags::new(),
            reg_a: 0xff,
            reg_sp: 0xffff,
            reg_ixl: 0xff,
            reg_ixh: 0xff,
            reg_iyl: 0xff,
            reg_iyh: 0xff,
            ..Default::default()
        }
    }

    pub fn get_af(&self) -> u16 {
        (self.reg_a as u16) << 8 | self.reg_f.to_byte() as u16
    }

    pub fn set_af(&mut self, value: u16) {
        self.reg_a = ((value & 0xff00) >> 8) as u8;
        self.reg_f.from((value & 0xff) as u8);
    }

    pub fn get_sp(&self) -> u16 {
        self.reg_sp
    }

    pub fn set_sp(&mut self, value: u16) {
        self.reg_sp = value;
    }

    z80_reg_pair!(get_bc, set_bc, reg_b, reg_c);
    z80_reg_pair!(get_de, set_de, reg_d, reg_e);
    z80_reg_pair!(get_hl, set_hl, reg_h, reg_l);
    z80_reg_pair!(get_ix, set_ix, reg_ixh, reg_ixl);
    z80_reg_pair!(get_iy, set_iy, reg_iyh, reg_iyl);
}

#[cfg(test)]
mod tests {
    use super::Registers;

    #[test]
    fn test_basic_register_functions() {
        let mut registers = Registers::new();
        registers.set_ix(0xaa55);
        assert_eq!(registers.reg_ixh, 0xaa);
        assert_eq!(registers.reg_ixl, 0x55);
    }
}

#![allow(dead_code)]
use crate::flags::Flags;

macro_rules! z80_reg_pair {
    ($(#[$m:meta])* $get_fn:ident, $set_fn:ident, $reg_h:ident, $reg_l:ident) => {
        #[doc="Get "]
        $(#[$m])*
        #[doc=" register"]
        pub fn $get_fn(&mut self) -> u16 {
            ((self.$reg_h as u16) << 8 | self.$reg_l as u16) as u16
        }

        #[doc="Set "]
        $(#[$m])*
        #[doc=" register"]
        pub fn $set_fn(&mut self, value: u16) {
            self.$reg_h = (value >> 8 & 0xff) as u8;
            self.$reg_l = (value & 0xff) as u8;
        }
    };
}

pub enum Regs {
    /// Accumulator
    A,
    /// B register
    B,
    /// C register
    C,
    /// D register
    D,
    /// E register
    E,
    /// H register
    H,
    /// L register
    L,
    /// BC register
    BC,
    /// DE register
    DE,
    /// HL register
    HL,
    /// Index X register
    IX,
    IXL,
    IXH,
    /// Index Y register
    IY,
    IYL,
    IYH,
    /// Stack Pointer
    SP,
}

#[derive(Default)]
pub struct Registers {
    /// Flags register
    pub reg_f: Flags,
    /// Accumulator
    pub reg_a: u8,
    /// B register
    pub reg_b: u8,
    /// C register
    pub reg_c: u8,
    /// D register
    pub reg_d: u8,
    /// E register
    pub reg_e: u8,
    /// H register
    pub reg_h: u8,
    /// L register
    pub reg_l: u8,
    /// Interrupt register
    pub reg_i: u8,
    /// Refresh register
    pub reg_r: u8,
    /// Upper half of X register
    pub reg_ixh: u8,
    /// Lower half of X register
    pub reg_ixl: u8,
    /// Upper half of Y register
    pub reg_iyh: u8,
    /// Lower half of Y register
    pub reg_iyl: u8,
    /// Stack Pointer
    pub reg_sp: u16,
    /// Program Counter
    pub reg_pc: u16,
}

impl Registers {
    /// Create new instance of registers
    pub fn new() -> Self {
        Self {
            reg_f: Flags::new(),
            reg_ixl: 0xff,
            reg_ixh: 0xff,
            reg_iyl: 0xff,
            reg_iyh: 0xff,
            ..Default::default()
        }
    }

    /// Get AF register
    pub fn get_af(&self) -> u16 {
        (self.reg_a as u16) << 8 | self.reg_f.to_byte() as u16
    }

    /// Set AF register
    pub fn set_af(&mut self, value: u16) {
        self.reg_a = ((value & 0xff00) >> 8) as u8;
        self.reg_f.from((value & 0xff) as u8);
    }

    /// Get SP register
    pub fn get_sp(&self) -> u16 {
        self.reg_sp
    }

    /// Set SP register
    pub fn set_sp(&mut self, value: u16) {
        self.reg_sp = value;
    }

    z80_reg_pair!(
        /// BC
        get_bc, set_bc, reg_b, reg_c
    );
    z80_reg_pair!(
    /// DE
    get_de, set_de, reg_d, reg_e
    );
    z80_reg_pair!(
        /// HL
        get_hl, set_hl, reg_h, reg_l
    );
    z80_reg_pair!(
        /// IX
        get_ix, set_ix, reg_ixh, reg_ixl
    );
    z80_reg_pair!(
        /// IY
        get_iy, set_iy, reg_iyh, reg_iyl
    );
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

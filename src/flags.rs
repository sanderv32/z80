/// Sign flag
pub const SF: u8 = 0x80;
/// Zero flag
pub const ZF: u8 = 0x40;
/// Unused flag
pub const XF: u8 = 0x20;
/// Half carry flag
pub const HF: u8 = 0x10;
/// Unused flag
pub const YF: u8 = 0x08;
/// Parity flag
pub const PF: u8 = 0x04;
/// Add/Subtract flag
pub const NF: u8 = 0x02;
/// Carry flag
pub const CF: u8 = 0x01;

#[derive(Default, Debug)]
pub struct Flags {
    /// Sign flag
    pub s: bool, // bit7
    /// Zero flag
    pub z: bool, // bit6
    /// Unused flag
    pub x: bool, // bit5
    /// Half carry flag
    pub h: bool, // bit4
    /// Unused flag
    pub y: bool, // bit3
    /// Parity flag
    pub p: bool, // bit2
    /// Add/Subtract flag
    pub n: bool, // bit1
    /// Carry flag
    pub c: bool, // bit0
}

impl Flags {
    pub fn new() -> Self {
        Self {
            s: false,
            z: false,
            x: false,
            h: false,
            y: false,
            p: false,
            n: false,
            c: false,
        }
    }

    pub fn to_byte(&self) -> u8 {
        let s = if self.s { 1 << 7 } else { 0 };
        let z = if self.z { 1 << 6 } else { 0 };
        let x = if self.x { 1 << 5 } else { 0 };
        let h = if self.h { 1 << 4 } else { 0 };
        let y = if self.y { 1 << 3 } else { 0 };
        let p = if self.p { 1 << 2 } else { 0 };
        let n = if self.n { 1 << 1 } else { 0 };
        let c = if self.c { 1 } else { 0 };
        s | z | x | h | y | p | n | c
    }

    pub fn from(&mut self, flags: u8) {
        self.s = (flags & 0x80) != 0;
        self.z = (flags & 0x40) != 0;
        self.x = (flags & 0x20) != 0;
        self.h = (flags & 0x10) != 0;
        self.y = (flags & 0x08) != 0;
        self.p = (flags & 0x04) != 0;
        self.n = (flags & 0x02) != 0;
        self.c = (flags & 0x01) != 0;
    }
}

impl From<u8> for Flags {
    fn from(flags: u8) -> Self {
        Flags {
            s: (flags & 0x80) != 0,
            z: (flags & 0x40) != 0,
            x: (flags & 0x20) != 0,
            h: (flags & 0x10) != 0,
            y: (flags & 0x08) != 0,
            p: (flags & 0x04) != 0,
            n: (flags & 0x02) != 0,
            c: (flags & 0x01) != 0,
        }
    }
}

#[cfg(test)]
mod tests {
    use crate::registers::Registers;

    #[test]
    fn testing_flags_functions() {
        let mut registers = Registers::new();
        registers.reg_f = 0x80.into();
        assert_eq!(registers.reg_f.to_byte(), 0x80);
        let flags = &registers.reg_f;
        assert_eq!(flags.s, true);

        registers.reg_f.c = true;
        assert_eq!(registers.reg_f.to_byte(), 0x81);
    }
}

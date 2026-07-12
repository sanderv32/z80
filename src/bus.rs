extern crate alloc;
use alloc::vec;
use alloc::vec::Vec;

pub trait Io {
    /// Write `value` to IO port `address`
    ///
    /// Upper half of the address is set on address
    /// lines A15-A8 and the lower half on A7-A0 which
    /// is the 8 bit port number. `value` is written
    /// to the port.
    fn write_io(&mut self, address: u16, value: u8);

    /// Read value from IO port `address`
    ///
    /// See `write_io`
    fn read_io(&mut self, address: u16) -> u8;
}

pub trait MemoryAccess {
    /// Read u8 value from `address`
    fn read_mem(&self, address: u16) -> u8;
    /// Read u16 value from `address`
    fn read_mem_u16(&self, address: u16) -> u16;
    /// Write u8 `value` to `address`
    fn write_mem(&mut self, address: u16, value: u8);
    /// Write u16 `value` to `address`
    fn write_mem_u16(&mut self, address: u16, value: u16);
    /// Read opcode byte from `pc` during an M1 (opcode fetch) cycle
    ///
    /// `ir` is the combined I/R register pair at the time of fetch.
    fn read_opcode(&mut self, pc: u16, ir: u16) -> u8;
}

struct Rom {
    pub start: u16,
    pub end: u16,
}

pub struct Bus {
    pub ram: Vec<u8>,
    rom: Option<Rom>,
    pub io: Vec<u8>,
}

impl Io for Bus {
    fn write_io(&mut self, address: u16, value: u8) {
        self.io[(address & 0xff) as usize] = value;
    }

    fn read_io(&mut self, address: u16) -> u8 {
        self.io[(address & 0xff) as usize]
    }
}

impl Bus {
    /// Create new bus with memory
    ///
    /// Creates a new bus with `size` of memory in bytes.
    #[must_use]
    pub fn new(size: u16) -> Self {
        Self {
            ram: vec![0; (size as usize) + 1],
            rom: None,
            io: vec![0; 256],
        }
    }

    /// Set ROM range
    ///
    /// This sets the rom range and make memory between `start` and `end`
    /// write only. First load the ROM contents on the location and then
    /// use `set_rom`.
    pub fn set_rom(&mut self, mut start: u16, mut end: u16) {
        if start > end {
            core::mem::swap(&mut start, &mut end);
        }
        self.rom = Some(Rom { start, end });
    }

    /// Read u8 value from `address`
    #[must_use]
    pub fn read_mem(&self, address: u16) -> u8 {
        self.ram[usize::from(address)]
    }

    /// Read u16 value from `address`
    #[must_use]
    pub fn read_mem_u16(&self, address: u16) -> u16 {
        u16::from(self.ram[usize::from(address)])
            | u16::from(self.ram[usize::from(address + 1)]) << 8
    }

    /// Write `value` to `address`
    pub fn write_mem(&mut self, address: u16, value: u8) {
        if let Some(rom) = &self.rom {
            if address >= rom.start && address <= rom.end {
                return;
            }
        }
        self.ram[usize::from(address)] = value;
    }

    /// Write u16 `value` to `address`
    pub fn write_mem_u16(&mut self, address: u16, value: u16) {
        if let Some(rom) = &self.rom {
            if address >= rom.start && address <= rom.end {
                return;
            }
        }
        let lb = (value & 0xff) as u8;
        let hb = ((value >> 8) & 0xff) as u8;
        self.ram[usize::from(address)] = lb;
        self.ram[usize::from(address + 1)] = hb;
    }
}

impl MemoryAccess for Bus {
    fn read_mem(&self, address: u16) -> u8 {
        self.read_mem(address)
    }

    fn read_mem_u16(&self, address: u16) -> u16 {
        self.read_mem_u16(address)
    }

    fn write_mem(&mut self, address: u16, value: u8) {
        self.write_mem(address, value);
    }

    fn write_mem_u16(&mut self, address: u16, value: u16) {
        self.write_mem_u16(address, value);
    }

    fn read_opcode(&mut self, pc: u16, _ir: u16) -> u8 {
        self.read_mem(pc)
    }
}

#[cfg(test)]
mod tests {
    use super::Bus;

    #[test]
    fn testing_bus() {
        let mut bus = Bus::new(65535);
        bus.write_mem(0xffff, 0xaa);
        assert_eq!(bus.read_mem(0xffff), 0xaa);
    }

    #[test]
    fn testing_rom() {
        let mut bus = Bus::new(65535);
        for addr in 0x1000..0x13ff {
            bus.write_mem(addr, 1);
        }
        bus.set_rom(0x1000, 0x13ff);
        bus.write_mem(0x1100, 2);
        bus.write_mem(0x1100, 3);
        bus.write_mem(0x13ff, 4);
        bus.write_mem(0x1400, 5);
        assert_ne!(bus.read_mem(0x1100), 2);
        assert_ne!(bus.read_mem(0x1200), 3);
        assert_ne!(bus.read_mem(0x13ff), 4);
        assert_eq!(bus.read_mem(0x1400), 5);
    }
}

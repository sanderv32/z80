#![allow(dead_code)] // TODO: Remove this!
use std::fs::File;
use std::io::{self, Read};

pub trait Io {
    fn write_io(&mut self, address: u16, value: u8);
    fn read_io(&self, address: u16) -> u8;
}

pub struct Bus {
    ram: Vec<u8>,
    rom: Option<Rom>,
    io: Vec<u8>,
}

struct Rom {
    pub start: u16,
    pub end: u16,
}

impl Io for Bus {
    fn write_io(&mut self, address: u16, value: u8) {
        // println!("Writing to IO: {:04x} = {:02x}", address, value);
        self.io[(address & 0xff) as usize] = value;
    }

    fn read_io(&self, address: u16) -> u8 {
        // println!("Reading from IO: {:04x}", address);
        if (address & 0xff) == 0xfe {
            0xbf
        } else {
            self.io[(address & 0xff) as usize]
        }
    }
}

impl Bus {
    /// Create new bus with memory
    ///
    /// Creates a new bus with `size` of memory in bytes.
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
    /// use [set_rom].
    pub fn set_rom(&mut self, mut start: u16, mut end: u16) {
        if start > end {
            let tmp = start;
            start = end;
            end = tmp;
        }
        self.rom = Some(Rom { start, end });
    }

    /// Read u8 value from `address`
    pub fn read_mem(&self, address: u16) -> u8 {
        self.ram[usize::from(address)]
    }

    /// Read u16 value from `address`
    pub fn read_mem_u16(&self, address: u16) -> u16 {
        u16::from(self.ram[usize::from(address)])
            | u16::from(self.ram[usize::from(address + 1)]) << 8
    }

    /// Write `value` to `address`
    pub fn write_mem(&mut self, address: u16, value: u8) {
        if self.rom.is_some()
            && address >= self.rom.as_ref().unwrap().start
            && address <= self.rom.as_ref().unwrap().end
        {
            return;
        }
        self.ram[usize::from(address)] = value;
    }

    /// Write u16 `value` to `address`
    pub fn write_mem_u16(&mut self, address: u16, value: u16) {
        if self.rom.is_some()
            && address >= self.rom.as_ref().unwrap().start
            && address <= self.rom.as_ref().unwrap().end
        {
            return;
        }
        let lb = (value & 0xff) as u8;
        let hb = ((value >> 8) & 0xff) as u8;
        self.ram[usize::from(address)] = lb;
        self.ram[usize::from(address + 1)] = hb;
    }

    pub fn load_bin(&mut self, file: &str, org: u16) -> io::Result<usize> {
        if org as usize >= self.ram.len() {
            panic!("Write operation after the end of address space !")
        }
        let mut f = File::open(file)?;
        let mut buf = Vec::new();
        let s = f.read_to_end(&mut buf)?;
        self.ram[org as usize..(buf.len() + org as usize)].clone_from_slice(&buf[..]);
        Ok(s)
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

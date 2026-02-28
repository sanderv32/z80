// Contains the full Z80 test suite
//

#[cfg(test)]
mod tests {
    use crate::cpu::Cpu;
    use std::io::Write;

    pub struct SpeccyPrint {
        xpos: u8,
        tab: bool,
        tmp_string: String,
    }

    impl SpeccyPrint {
        pub fn new() -> SpeccyPrint {
            SpeccyPrint {
                xpos: 0,
                tab: false,
                tmp_string: String::new(),
            }
        }

        pub fn print(&mut self, a: u8) {
            std::io::stdout().flush().unwrap();
            if self.tab {
                let pos = a - self.xpos;
                self.tmp_string
                    .push_str(&format!("{}", " ".repeat(pos as usize)));
                self.tab = false;
            } else {
                match a {
                    13 => {
                        self.xpos = 0;
                        println!("{}", self.tmp_string);
                        self.tmp_string = String::new();
                    }
                    16..=22 => (),
                    23 => {
                        self.tab = true;
                    }
                    32..=127 => {
                        self.tmp_string.push(a as char);
                        self.xpos += 1;
                    }
                    _ => (),
                }
            }
            std::io::stdout().flush().unwrap();
        }
    }

    #[test]
    fn testing_cpu_full_test() {
        let mut speccy_print = SpeccyPrint::new();
        let program = include_bytes!("../tests.old/z80full.bin").to_vec();

        let mut cpu = Cpu::new(None);
        for (offset, &opcode) in program.iter().enumerate() {
            cpu.bus.write_mem(0x8000 + offset as u16, opcode);
        }
        // Patch location 0x1601 where ZX Spectrum selects channel.
        cpu.bus.write_mem(0x1601, 0xc9);
        // Patch RST10 location with HALT
        cpu.bus.write_mem(0x0010, 0x76);

        cpu.registers.reg_pc = 0x8000;
        cpu.registers.set_sp(0);

        while cpu.registers.reg_pc != 0x8094 {
            // println!("PC: {:#04x}", cpu.registers.reg_pc);
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            cpu.step();
        }

        assert_eq!(cpu.registers.reg_pc, 0x8094);
    }

    #[test]
    fn testing_cpu_doc_test() {
        let mut speccy_print = SpeccyPrint::new();
        let program = include_bytes!("../tests.old/z80doc.bin").to_vec();

        let mut cpu = Cpu::new(None);
        for (offset, &opcode) in program.iter().enumerate() {
            cpu.bus.write_mem(0x8000 + offset as u16, opcode);
        }
        // Patch location 0x1601 where ZX Spectrum selects channel.
        cpu.bus.write_mem(0x1601, 0xc9);
        // Patch RST10 location with HALT
        cpu.bus.write_mem(0x0010, 0x76);

        cpu.registers.reg_pc = 0x8000;
        cpu.registers.set_sp(0);

        while cpu.registers.reg_pc != 0x8094 {
            // println!("PC: {:#04x}", cpu.registers.reg_pc);
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            cpu.step();
        }

        assert_eq!(cpu.registers.reg_pc, 0x8094);
    }

    #[test]
    fn testing_cpu_ccf_test() {
        let mut speccy_print = SpeccyPrint::new();
        let program = include_bytes!("../tests.old/z80ccf.bin").to_vec();

        let mut cpu = Cpu::new(None);
        for (offset, &opcode) in program.iter().enumerate() {
            cpu.bus.write_mem(0x8000 + offset as u16, opcode);
        }
        // Patch location 0x1601 where ZX Spectrum selects channel.
        cpu.bus.write_mem(0x1601, 0xc9);
        // Patch RST10 location with HALT
        cpu.bus.write_mem(0x0010, 0x76);

        cpu.registers.reg_pc = 0x8000;
        cpu.registers.set_sp(0x0000);

        while cpu.registers.reg_pc != 0x8094 {
            // println!("PC: {:#04x}", cpu.registers.reg_pc);
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            cpu.step();
        }

        assert_eq!(cpu.registers.reg_pc, 0x8094);
    }

    #[test]
    fn testing_cpu_flags_test() {
        let mut speccy_print = SpeccyPrint::new();
        let program = include_bytes!("../tests.old/z80flags.bin").to_vec();

        let mut cpu = Cpu::new(None);
        for (offset, &opcode) in program.iter().enumerate() {
            cpu.bus.write_mem(0x8000 + offset as u16, opcode);
        }
        // Patch location 0x1601 where ZX Spectrum selects channel.
        cpu.bus.write_mem(0x1601, 0xc9);
        // Patch RST10 location with HALT
        cpu.bus.write_mem(0x0010, 0x76);

        cpu.registers.reg_pc = 0x8000;
        cpu.registers.set_sp(0xffff);

        while cpu.registers.reg_pc != 0x8094 {
            // println!("PC: {:#04x}", cpu.registers.reg_pc);
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            cpu.step();
        }

        assert_eq!(cpu.registers.reg_pc, 0x8094);
    }

    #[test]
    fn testing_cpu_docflags_test() {
        let mut speccy_print = SpeccyPrint::new();
        let program = include_bytes!("../tests.old/z80docflags.bin").to_vec();

        let mut cpu = Cpu::new(None);
        for (offset, &opcode) in program.iter().enumerate() {
            cpu.bus.write_mem(0x8000 + offset as u16, opcode);
        }
        // Patch location 0x1601 where ZX Spectrum selects channel.
        cpu.bus.write_mem(0x1601, 0xc9);
        // Patch RST10 location with HALT
        cpu.bus.write_mem(0x0010, 0x76);

        cpu.registers.reg_a = 0xff;
        cpu.registers.reg_pc = 0x8000;
        cpu.registers.set_sp(0xffff);

        while cpu.registers.reg_pc != 0x8094 {
            // println!("PC: {:#04x}", cpu.registers.reg_pc);
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            cpu.step();
        }

        assert_eq!(cpu.registers.reg_pc, 0x8094);
    }

    #[test]
    fn testing_cpu_zexall_test() {
        let mut speccy_print = SpeccyPrint::new();
        let program = include_bytes!("../tests.old/zexall.bin").to_vec();

        let mut cpu = Cpu::new(None);
        for (offset, &opcode) in program.iter().enumerate() {
            cpu.bus.write_mem(0x8000 + offset as u16, opcode);
        }
        // Patch location 0x1601 where ZX Spectrum selects channel.
        cpu.bus.write_mem(0x1601, 0xc9);
        // Patch RST10 location with HALT
        cpu.bus.write_mem(0x0010, 0x76);

        cpu.registers.reg_pc = 0x8000;
        cpu.registers.set_sp(0);

        while cpu.registers.reg_pc != 0x803d {
            // println!("PC: {:#04x}", cpu.registers.reg_pc);
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            cpu.step();
        }

        assert_eq!(cpu.registers.reg_pc, 0x803d);
    }
}

// Contains the full Z80 test suite
//

#[cfg(all(test, feature = "slow-tests"))]
#[allow(clippy::cast_possible_truncation)] // ROM fixtures are always well under 64KB
#[allow(clippy::module_inception)]
mod tests {
    use crate::cpu::Cpu;
    use ntest::timeout;
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
                let pos = a.saturating_sub(self.xpos);
                self.tmp_string.push_str(&" ".repeat(pos as usize));
                self.tab = false;
            } else {
                match a {
                    13 => {
                        self.xpos = 0;
                        println!("{}", self.tmp_string);
                        self.tmp_string = String::new();
                    }
                    23 => {
                        self.tab = true;
                    }
                    32..=127 => {
                        self.tmp_string.push(a as char);
                        self.xpos = self.xpos.wrapping_add(1);
                    }
                    _ => (),
                }
            }
            std::io::stdout().flush().unwrap();
        }
    }

    #[test]
    #[timeout(60_000)]
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

        let mut steps: u64 = 0;
        loop {
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            let pc_before = cpu.registers.reg_pc;
            cpu.step();
            steps += 1;
            assert!(
                steps <= 5_000_000_000,
                "exceeded max steps (possible infinite loop), PC={:#06x}",
                cpu.registers.reg_pc
            );
            // Program finished: either it parked itself in a JP $ self-trap
            // (PC unchanged after a step, but not from HALT — HALT also
            // leaves PC unchanged since it re-executes itself until an
            // interrupt, and this harness relies on HALT for RST10 printing),
            // or it RET-ed all the way back to an uninitialized/zero caller.
            if (!cpu.halt && cpu.registers.reg_pc == pc_before) || cpu.registers.reg_pc == 0x0000 {
                break;
            }
        }
    }

    #[test]
    #[timeout(120_000)]
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

        let mut steps: u64 = 0;
        loop {
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            let pc_before = cpu.registers.reg_pc;
            cpu.step();
            steps += 1;
            assert!(
                steps <= 5_000_000_000,
                "exceeded max steps (possible infinite loop), PC={:#06x}",
                cpu.registers.reg_pc
            );
            // Program finished: either it parked itself in a JP $ self-trap
            // (PC unchanged after a step, but not from HALT — HALT also
            // leaves PC unchanged since it re-executes itself until an
            // interrupt, and this harness relies on HALT for RST10 printing),
            // or it RET-ed all the way back to an uninitialized/zero caller.
            if (!cpu.halt && cpu.registers.reg_pc == pc_before) || cpu.registers.reg_pc == 0x0000 {
                break;
            }
        }
    }

    #[test]
    #[timeout(60_000)]
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

        let mut steps: u64 = 0;
        loop {
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            let pc_before = cpu.registers.reg_pc;
            cpu.step();
            steps += 1;
            assert!(
                steps <= 5_000_000_000,
                "exceeded max steps (possible infinite loop), PC={:#06x}",
                cpu.registers.reg_pc
            );
            // Program finished: either it parked itself in a JP $ self-trap
            // (PC unchanged after a step, but not from HALT — HALT also
            // leaves PC unchanged since it re-executes itself until an
            // interrupt, and this harness relies on HALT for RST10 printing),
            // or it RET-ed all the way back to an uninitialized/zero caller.
            if (!cpu.halt && cpu.registers.reg_pc == pc_before) || cpu.registers.reg_pc == 0x0000 {
                break;
            }
        }
    }

    #[test]
    #[timeout(60_000)]
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

        let mut steps: u64 = 0;
        loop {
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            let pc_before = cpu.registers.reg_pc;
            cpu.step();
            steps += 1;
            assert!(
                steps <= 5_000_000_000,
                "exceeded max steps (possible infinite loop), PC={:#06x}",
                cpu.registers.reg_pc
            );
            // Program finished: either it parked itself in a JP $ self-trap
            // (PC unchanged after a step, but not from HALT — HALT also
            // leaves PC unchanged since it re-executes itself until an
            // interrupt, and this harness relies on HALT for RST10 printing),
            // or it RET-ed all the way back to an uninitialized/zero caller.
            if (!cpu.halt && cpu.registers.reg_pc == pc_before) || cpu.registers.reg_pc == 0x0000 {
                break;
            }
        }
    }

    #[test]
    #[timeout(60_000)]
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

        let mut steps: u64 = 0;
        loop {
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            let pc_before = cpu.registers.reg_pc;
            cpu.step();
            steps += 1;
            assert!(
                steps <= 5_000_000_000,
                "exceeded max steps (possible infinite loop), PC={:#06x}",
                cpu.registers.reg_pc
            );
            // Program finished: either it parked itself in a JP $ self-trap
            // (PC unchanged after a step, but not from HALT — HALT also
            // leaves PC unchanged since it re-executes itself until an
            // interrupt, and this harness relies on HALT for RST10 printing),
            // or it RET-ed all the way back to an uninitialized/zero caller.
            if (!cpu.halt && cpu.registers.reg_pc == pc_before) || cpu.registers.reg_pc == 0x0000 {
                break;
            }
        }
    }

    #[test]
    #[timeout(60_000)]
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

        let mut steps: u64 = 0;
        loop {
            if cpu.halt {
                // dbg!("HALT");
                speccy_print.print(cpu.registers.reg_a);
                cpu.registers.reg_pc = cpu.pop_stack();
                cpu.halt = false;
            }
            let pc_before = cpu.registers.reg_pc;
            cpu.step();
            steps += 1;
            assert!(
                steps <= 5_000_000_000,
                "exceeded max steps (possible infinite loop), PC={:#06x}",
                cpu.registers.reg_pc
            );
            // Program finished: either it parked itself in a JP $ self-trap
            // (PC unchanged after a step, but not from HALT — HALT also
            // leaves PC unchanged since it re-executes itself until an
            // interrupt, and this harness relies on HALT for RST10 printing),
            // or it RET-ed all the way back to an uninitialized/zero caller.
            if (!cpu.halt && cpu.registers.reg_pc == pc_before) || cpu.registers.reg_pc == 0x0000 {
                break;
            }
        }
    }
}

#![doc(hidden)]
use z80emu::bus::Bus;
use z80emu::cpu::Cpu;

fn main() {
    let bus = Bus::new(0xffff);
    let _cpu = Cpu::new(Some(bus));

    println!("Hello, world!");
}

mod bus;
use crate::bus::Bus;

mod flags;
mod registers;
mod cpu;

fn main() {
    let bus = Bus::new(65535);
    let _cpu = cpu::Cpu::new(bus);
    println!("Hello, world!");
}

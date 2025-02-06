mod bus;
use crate::bus::Bus;

mod cpu;
mod flags;
mod registers;

fn main() {
    let bus = Bus::new(65535);
    let _cpu = cpu::Cpu::new(bus);
    println!("Hello, world!");
}

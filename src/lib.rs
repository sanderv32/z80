#![cfg_attr(not(test), no_std)]
pub mod bus;
pub mod cpu;
pub mod flags;
pub mod registers;

pub use bus::{Bus, Io, MemoryAccess};
pub use cpu::{Cpu, InterruptMode};

#[cfg(test)]
mod opcode_test;
#[cfg(test)]
mod tests;

#![cfg_attr(not(test), no_std)]
pub mod bus;
pub mod cpu;
pub mod flags;
pub mod registers;

#[cfg(test)]
mod opcode_test;
#[cfg(test)]
mod tests;

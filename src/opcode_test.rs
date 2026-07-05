extern crate alloc;
extern crate std;
use alloc::vec::Vec;
use std::io::{self, Read};

use crate::cpu::Cpu;

// carry flag
const CF: u8 = 1 << 0;

// add/subtract flag
const NF: u8 = 1 << 1;

// overflow flag (same as parity)
const VF: u8 = 1 << 2;

// parity flag (same as overflow)
const PF: u8 = 1 << 2;

// undocumented 'Y' flag
const YF: u8 = 1 << 3;

// half carry flag
const HF: u8 = 1 << 4;

// undocumented 'X' flag
const XF: u8 = 1 << 5;

// zero flag
const ZF: u8 = 1 << 6;

// sign flag
const SF: u8 = 1 << 7;

pub fn load_bin(file: &str, ram: &mut [u8], org: u16) -> io::Result<usize> {
    assert!(
        (org as usize) < ram.len(),
        "Write operation after the end of address space !"
    );
    let mut f = std::fs::File::open(file)?;
    let mut buf = Vec::new();
    let s = f.read_to_end(&mut buf)?;
    ram[org as usize..(buf.len() + org as usize)].clone_from_slice(&buf[..]);
    Ok(s)
}

#[test]
fn ld_r_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_r_r.bin", &mut c.bus.ram, 0).unwrap();
    c.registers.reg_a = 0x12;
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x12); // LD B,A
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x12); // LD C,A
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x12); // LD D,A
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x12); // LD E,A
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x12); // LD H,A
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x12); // LD L,A
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x12); // LD A,A
    c.registers.reg_b = 0x13;
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x13); // LD C,B
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x13); // LD D,C
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x13); // LD E,D
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x13); // LD H,E
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x13); // LD L,H
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x13); // LD A,L
}

#[test]
fn ld_hl_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_hl.bin", &mut c.bus.ram, 0x0100).unwrap();
    c.registers.reg_a = 0x33;
    c.registers.set_hl(0x1000);
    c.registers.reg_pc = 0x0100;
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x1000), 0x33); // LD (HL),A
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x33); // LD B,(HL)
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x33); // LD C,(HL)
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x33); // LD D,(HL)
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x33); // LD E,(HL)
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x33); // LD H,(HL)
}

#[test]
fn ld_hl_n_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_hl_n.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(c.registers.get_hl(), 0x2000); // LD HL,0x2000
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x2000), 0x33); // LD (HL),0x33
    c.exec_opcode();
    assert_eq!(c.registers.get_hl(), 0x1000); // LD HL,0x1000
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x1000), 0x65); // LD (HL),0x65
}

#[test]
fn ld_ix_iy_n_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_ix_iy_n.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(c.registers.get_ix(), 0x2000); // LD IX,0x2000
    c.exec_opcode();
    assert_eq!(0x33, c.bus.read_mem(0x2002)); // LD (IX+2),0x33
    c.exec_opcode();
    assert_eq!(0x11, c.bus.read_mem(0x1FFE)); // LD (IX-2),0x11
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_iy()); // LD IY,0x1000
    c.exec_opcode();
    assert_eq!(0x22, c.bus.read_mem(0x1001)); // LD (IY+1),0x22
    c.exec_opcode();
    assert_eq!(0x44, c.bus.read_mem(0x0FFF)); // LD (IY-1),0x44
}

#[test]
fn ld_hl_dd_ix_iy_inn_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x02);
    c.bus.write_mem(0x1002, 0x03);
    c.bus.write_mem(0x1003, 0x04);
    c.bus.write_mem(0x1004, 0x05);
    c.bus.write_mem(0x1005, 0x06);
    c.bus.write_mem(0x1006, 0x07);
    c.bus.write_mem(0x1007, 0x08);
    load_bin("tests/ld_hl_dd_ix_iy_inn.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x0201, c.registers.get_hl()); // LD HL,(0x1000)
    c.exec_opcode();
    assert_eq!(0x0302, c.registers.get_bc()); // LD BC,(0x1001)
    c.exec_opcode();
    assert_eq!(0x0403, c.registers.get_de()); // LD DE,(0x1002)
    c.exec_opcode();
    assert_eq!(0x0504, c.registers.get_hl()); // LD HL,(0x1003)
    c.exec_opcode();
    assert_eq!(0x0605, c.registers.reg_sp); // LD SP,(0x1004)
    c.exec_opcode();
    assert_eq!(0x0706, c.registers.get_ix(),); // LD IX,(0x1004)
    c.exec_opcode();
    assert_eq!(0x0807, c.registers.get_iy()); // LD IY,(0x1005)
}

#[test]
fn ld_ix_iy_nn_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_ix_iy_nn.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.get_bc()); // LD BC,0x1234
    c.exec_opcode();
    assert_eq!(0x5678, c.registers.get_de()); // LD DE,0x5678
    c.exec_opcode();
    assert_eq!(0x9ABC, c.registers.get_hl()); // LD HL,0x9ABC
    c.exec_opcode();
    assert_eq!(0x1368, c.registers.reg_sp); // LD SP,0x1368
    c.exec_opcode();
    assert_eq!(0x4321, c.registers.get_ix(),); // LD IX,0x4321
    c.exec_opcode();
    assert_eq!(0x8765, c.registers.get_iy()); // LD IY,0x8765
}

#[test]
fn ld_sp_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_sp_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.get_hl()); // LD HL,0x1234
    c.exec_opcode();
    assert_eq!(0x5678, c.registers.get_ix(),); // LD IX,0x5678
    c.exec_opcode();
    assert_eq!(0x9ABC, c.registers.get_iy()); // LD IY,0x9ABC
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.reg_sp); // LD SP,HL
    c.exec_opcode();
    assert_eq!(0x5678, c.registers.reg_sp); // LD SP,IX
    c.exec_opcode();
    assert_eq!(0x9ABC, c.registers.reg_sp); // LD SP,IY
}

#[test]
fn ld_r_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x02);
    c.bus.write_mem(0x1002, 0x03);
    c.bus.write_mem(0x1003, 0x04);
    c.bus.write_mem(0x1004, 0x05);
    c.bus.write_mem(0x1005, 0x06);
    c.bus.write_mem(0x1006, 0x07);
    c.bus.write_mem(0x1007, 0x08);
    load_bin("tests/ld_r_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_ix(),); // LD  IX,0x1003
    c.exec_opcode();
    assert_eq!(4, c.registers.reg_a); // LD  A,(IX+0)
    c.exec_opcode();
    assert_eq!(5, c.registers.reg_b); // LD  B,(IX+1)
    c.exec_opcode();
    assert_eq!(6, c.registers.reg_c); // LD  C,(IX+2)
    c.exec_opcode();
    assert_eq!(3, c.registers.reg_d); // LD  D,(IX-1)
    c.exec_opcode();
    assert_eq!(2, c.registers.reg_e); // LD  E,(IX-2)
    c.exec_opcode();
    assert_eq!(7, c.registers.reg_h); // LD  H,(IX+3)
    c.exec_opcode();
    assert_eq!(1, c.registers.reg_l); // LD  L,(IX-3)
    c.exec_opcode();
    assert_eq!(0x1004, c.registers.get_iy()); // LD  IY,0x1004
    c.exec_opcode();
    assert_eq!(5, c.registers.reg_a); // LD  A,(IY+0)
    c.exec_opcode();
    assert_eq!(6, c.registers.reg_b); // LD  B,(IY+1)
    c.exec_opcode();
    assert_eq!(7, c.registers.reg_c); // LD  C,(IY+2)
    c.exec_opcode();
    assert_eq!(4, c.registers.reg_d); // LD  D,(IY-1)
    c.exec_opcode();
    assert_eq!(3, c.registers.reg_e); // LD  E,(IY-2)
    c.exec_opcode();
    assert_eq!(8, c.registers.reg_h); // LD  H,(IY+3)
    c.exec_opcode();
    assert_eq!(2, c.registers.reg_l); // LD  L,(IY-3)
}

#[test]
fn ld_ix_iy_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_ix_iy_r.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_ix(),);
    c.exec_opcode();
    assert_eq!(0x12, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x12, c.bus.read_mem(0x1003));
    c.exec_opcode();
    assert_eq!(0x13, c.registers.reg_b);
    c.exec_opcode();
    assert_eq!(0x13, c.bus.read_mem(0x1004));
    c.exec_opcode();
    assert_eq!(0x14, c.registers.reg_c);
    c.exec_opcode();
    assert_eq!(0x14, c.bus.read_mem(0x1005));
    c.exec_opcode();
    assert_eq!(0x15, c.registers.reg_d);
    c.exec_opcode();
    assert_eq!(0x15, c.bus.read_mem(0x1002));
    c.exec_opcode();
    assert_eq!(0x16, c.registers.reg_e);
    c.exec_opcode();
    assert_eq!(0x16, c.bus.read_mem(0x1001));
    c.exec_opcode();
    assert_eq!(0x17, c.registers.reg_h);
    c.exec_opcode();
    assert_eq!(0x17, c.bus.read_mem(0x1006));
    c.exec_opcode();
    assert_eq!(0x18, c.registers.reg_l);
    c.exec_opcode();
    assert_eq!(0x18, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_iy());
    c.exec_opcode();
    assert_eq!(0x12, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x12, c.bus.read_mem(0x1003));
    c.exec_opcode();
    assert_eq!(0x13, c.registers.reg_b);
    c.exec_opcode();
    assert_eq!(0x13, c.bus.read_mem(0x1004));
    c.exec_opcode();
    assert_eq!(0x14, c.registers.reg_c);
    c.exec_opcode();
    assert_eq!(0x14, c.bus.read_mem(0x1005));
    c.exec_opcode();
    assert_eq!(0x15, c.registers.reg_d);
    c.exec_opcode();
    assert_eq!(0x15, c.bus.read_mem(0x1002));
    c.exec_opcode();
    assert_eq!(0x16, c.registers.reg_e);
    c.exec_opcode();
    assert_eq!(0x16, c.bus.read_mem(0x1001));
    c.exec_opcode();
    assert_eq!(0x17, c.registers.reg_h);
    c.exec_opcode();
    assert_eq!(0x17, c.bus.read_mem(0x1006));
    c.exec_opcode();
    assert_eq!(0x18, c.registers.reg_l);
    c.exec_opcode();
    assert_eq!(0x18, c.bus.read_mem(0x1000));
}

#[test]
fn push_pop_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/push_pop.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.get_bc()); // LD BC,0x1234
    c.exec_opcode();
    assert_eq!(0x5678, c.registers.get_de()); // LD DE,0x5678
    c.exec_opcode();
    assert_eq!(0x9ABC, c.registers.get_hl()); // LD HL,0x9ABC
    c.exec_opcode();
    assert_eq!(0xEF00, c.registers.get_af()); // LD A,0xEF
    c.exec_opcode();
    assert_eq!(0x2345, c.registers.get_ix(),); // LD IX,0x2345
    c.exec_opcode();
    assert_eq!(0x6789, c.registers.get_iy()); // LD IY,0x6789
    c.exec_opcode();
    assert_eq!(0x0100, c.registers.reg_sp); // LD SP,0x0100
    c.exec_opcode();
    assert_eq!(0xEF00, c.bus.read_mem_u16(0x00FE));
    assert_eq!(0x00FE, c.registers.reg_sp); // PUSH AF
    c.exec_opcode();
    assert_eq!(0x1234, c.bus.read_mem_u16(0x00FC));
    assert_eq!(0x00FC, c.registers.reg_sp); // PUSH BC
    c.exec_opcode();
    assert_eq!(0x5678, c.bus.read_mem_u16(0x00FA));
    assert_eq!(0x00FA, c.registers.reg_sp); // PUSH DE
    c.exec_opcode();
    assert_eq!(0x9ABC, c.bus.read_mem_u16(0x00F8));
    assert_eq!(0x00F8, c.registers.reg_sp); // PUSH HL
    c.exec_opcode();
    assert_eq!(0x2345, c.bus.read_mem_u16(0x00F6));
    assert_eq!(0x00F6, c.registers.reg_sp); // PUSH IX
    c.exec_opcode();
    assert_eq!(0x6789, c.bus.read_mem_u16(0x00F4));
    assert_eq!(0x00F4, c.registers.reg_sp); // PUSH IY
    c.exec_opcode();
    assert_eq!(0x6789, c.registers.get_af());
    assert_eq!(0x00F6, c.registers.reg_sp); // POP AF
    c.exec_opcode();
    assert_eq!(0x2345, c.registers.get_bc());
    assert_eq!(0x00F8, c.registers.reg_sp); // POP BC
    c.exec_opcode();
    assert_eq!(0x9ABC, c.registers.get_de());
    assert_eq!(0x00FA, c.registers.reg_sp); // POP DE
    c.exec_opcode();
    assert_eq!(0x5678, c.registers.get_hl());
    assert_eq!(0x00FC, c.registers.reg_sp); // POP HL
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.get_ix(),);
    assert_eq!(0x00FE, c.registers.reg_sp); // POP IX
    c.exec_opcode();
    assert_eq!(0xEF00, c.registers.get_iy());
    assert_eq!(0x0100, c.registers.reg_sp); // POP IY
}

#[test]
fn add_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/add_r.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x0F, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // LD A,0x0F
    c.exec_opcode();
    assert_eq!(0x1E, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | YF); // ADD A,A
    c.exec_opcode();
    assert_eq!(0xE0, c.registers.reg_b); // LD B,0xE0
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF | YF); // ADD A,B
    c.exec_opcode();
    assert_eq!(0x81, c.registers.reg_a); // LD A,0x81
    c.exec_opcode();
    assert_eq!(0x80, c.registers.reg_c); // LD C,0x80
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), VF | CF); // ADD A,C
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_d); // LD D,0xFF
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | HF | CF); // ADD A,D
    c.exec_opcode();
    assert_eq!(0x40, c.registers.reg_e); // LD E,0x40
    c.exec_opcode();
    assert_eq!(0x40, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // ADD A,E
    c.exec_opcode();
    assert_eq!(0x80, c.registers.reg_h); // LD H,0x80
    c.exec_opcode();
    assert_eq!(0xC0, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF); // ADD A,H
    c.exec_opcode();
    assert_eq!(0x33, c.registers.reg_l); // LD L,0x33
    c.exec_opcode();
    assert_eq!(0xF3, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF); // ADD A,L
    c.exec_opcode();
    assert_eq!(0x37, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), CF | XF); // ADD A,0x44
}

#[test]
fn add_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x41);
    c.bus.write_mem(0x1001, 0x61);
    c.bus.write_mem(0x1002, 0x81);
    load_bin("tests/add_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_hl()); // LD HL,0x1000
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_ix(),); // LD IX,0x1000
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_iy()); // LD IY,0x1003
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a); // LD A,0x00
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // ADD A,(HL)
    c.exec_opcode();
    assert_eq!(0xA2, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | VF | XF); // ADD A,(IX+1)
    c.exec_opcode();
    assert_eq!(0x23, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), VF | CF | XF); // ADD A,(IY-1)
}

#[test]
fn add_ixh_ixl_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/add_a_ixh_ixl.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x0F, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // LD A,0x0F
    c.exec_opcode();
    assert_eq!(0x1E, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | YF); // ADD A,A
    c.exec_opcode();
    assert_eq!(0xE080, c.registers.get_ix(),); // LD  IX,0xE080
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF | YF); // ADD A,IXH
    c.exec_opcode();
    assert_eq!(0x81, c.registers.reg_a); // LD  A,0x81
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), VF | CF); // ADD A,IXL
}

#[test]
fn add_a_iyh_iyl_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/add_a_iyh_iyl.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x0F, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // LD A,0x0F
    c.exec_opcode();
    assert_eq!(0x1E, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | YF); // ADD A,A
    c.exec_opcode();
    assert_eq!(0xE080, c.registers.get_iy()); // LD  IY,0xE080
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF | YF); // ADD A,IYH
    c.exec_opcode();
    assert_eq!(0x81, c.registers.reg_a); // LD  A,0x81
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), VF | CF); // ADD A,IYL
}

#[test]
fn adc_a_ixh_ixl_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/adc_a_ixh_ixl.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a); // LD A,0x00
    c.exec_opcode();
    assert_eq!(0x4161, c.registers.get_ix(),); // LD IX,0x4161
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF); // ADC A,A
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // ADC A,IXH
    c.exec_opcode();
    assert_eq!(0xA2, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | VF | XF); // ADC A,IXL
}

#[test]
fn adc_a_iyh_iyl_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/adc_a_iyh_iyl.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a); // LD A,0x00
    c.exec_opcode();
    assert_eq!(0x4161, c.registers.get_iy()); // LD IY,0x4161
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF); // ADC A,A
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // ADC A,IYH
    c.exec_opcode();
    assert_eq!(0xA2, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | VF | XF); // ADC A,IYL
}

#[test]
fn adc_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/adc_r.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a); // LD A,0x00
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_b); // LD B,0x41
    c.exec_opcode();
    assert_eq!(0x61, c.registers.reg_c); // LD C,0x61
    c.exec_opcode();
    assert_eq!(0x81, c.registers.reg_d); // LD D,0x81
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_e); // LD E,0x41
    c.exec_opcode();
    assert_eq!(0x61, c.registers.reg_h); // LD H,0x61
    c.exec_opcode();
    assert_eq!(0x81, c.registers.reg_l); // LD L,0x81
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF); // ADC A,A
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // ADC A,B
    c.exec_opcode();
    assert_eq!(0xA2, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | VF | XF); // ADC A,C
    c.exec_opcode();
    assert_eq!(0x23, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), VF | CF | XF); // ADC A,D
    c.exec_opcode();
    assert_eq!(0x65, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), XF); // ADC A,E
    c.exec_opcode();
    assert_eq!(0xC6, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | VF); // ADC A,H
    c.exec_opcode();
    assert_eq!(0x47, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), VF | CF); // ADC A,L
    c.exec_opcode();
    assert_eq!(0x49, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), YF); // ADC A,0x01
    c.exec_opcode();
    assert_eq!(0x0F, c.registers.reg_a); // LD A,0x0F
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_b); // LD B,0x01
    c.exec_opcode();
    assert_eq!(0x10, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF); // ADC A,B
}

#[test]
fn adc_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x41);
    c.bus.write_mem(0x1001, 0x61);
    c.bus.write_mem(0x1002, 0x81);
    c.bus.write_mem(0x1003, 0x02);
    load_bin("tests/adc_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_hl()); // LD HL,0x1000
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_ix(),); // LD IX,0x1000
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_iy()); // LD IY,0x1003
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a); // LD A,0x00
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // ADD A,(HL)
    c.exec_opcode();
    assert_eq!(0xA2, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | VF | XF); // ADC A,(IX+1)
    c.exec_opcode();
    assert_eq!(0x23, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), VF | CF | XF); // ADC A,(IY-1)
    c.exec_opcode();
    assert_eq!(0x26, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), XF); // ADC A,(IX+3)
}

#[test]
fn sub_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/sub_r.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a); // LD A,0x04
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_b); // LD B,0x01
    c.exec_opcode();
    assert_eq!(0xF8, c.registers.reg_c); // LD C,0xF8
    c.exec_opcode();
    assert_eq!(0x0F, c.registers.reg_d); // LD D,0x0F
    c.exec_opcode();
    assert_eq!(0x79, c.registers.reg_e); // LD E,0x79
    c.exec_opcode();
    assert_eq!(0xC0, c.registers.reg_h); // LD H,0xC0
    c.exec_opcode();
    assert_eq!(0xBF, c.registers.reg_l); // LD L,0xBF
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // SUB A,A
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SUB A,B
    c.exec_opcode();
    assert_eq!(0x07, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // SUB A,C
    c.exec_opcode();
    assert_eq!(0xF8, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SUB A,D
    c.exec_opcode();
    assert_eq!(0x7F, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | VF | NF | XF | YF); // SUB A,E
    c.exec_opcode();
    assert_eq!(0xBF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | VF | NF | CF | XF | YF); // SUB A,H
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // SUB A,L
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SUB A,0x01
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // SUB A,0xFE
}

#[test]
fn sub_ixh_ixl_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/sub_ixh_ixl.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a); // LD A,0x04
    c.exec_opcode();
    assert_eq!(0x01F8, c.registers.get_ix(),); // LD B,0x01
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // SUB A,A
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SUB A,IXH
    c.exec_opcode();
    assert_eq!(0x07, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // SUB A,IXL
}

#[test]
fn sub_iyh_iyl_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/sub_iyh_iyl.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a); // LD A,0x04
    c.exec_opcode();
    assert_eq!(0x01F8, c.registers.get_iy()); // LD B,0x01
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // SUB A,A
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SUB A,IXH
    c.exec_opcode();
    assert_eq!(0x07, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // SUB A,IXL
}

#[test]
fn cp_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/cp_r.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a); // LD A,0x04
    c.exec_opcode();
    assert_eq!(0x05, c.registers.reg_b); // LD B,0x05
    c.exec_opcode();
    assert_eq!(0x03, c.registers.reg_c); // LD C,0x03
    c.exec_opcode();
    assert_eq!(0xff, c.registers.reg_d); // LD D,0xff
    c.exec_opcode();
    assert_eq!(0xaa, c.registers.reg_e); // LD E,0xaa
    c.exec_opcode();
    assert_eq!(0x80, c.registers.reg_h); // LD H,0x80
    c.exec_opcode();
    assert_eq!(0x7f, c.registers.reg_l); // LD L,0x7f
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // CP A
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // CP B
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // CP C
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | NF | CF); // CP D
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | NF | CF | YF); // CP E
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | VF | NF | CF); // CP H
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF); // CP L
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // CP 0x04
}

#[test]
fn sub_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x41);
    c.bus.write_mem(0x1001, 0x61);
    c.bus.write_mem(0x1002, 0x81);
    load_bin("tests/sub_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_hl()); // LD HL,0x1000
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_ix(),); // LD IX,0x1000
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_iy()); // LD IY,0x1003
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a); // LD A,0x00
    c.exec_opcode();
    assert_eq!(0xBF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SUB A,(HL)
    c.exec_opcode();
    assert_eq!(0x5E, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), VF | NF | YF); // SUB A,(IX+1)
    c.exec_opcode();
    assert_eq!(0xFD, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | NF | CF | XF | YF); // SUB A,(IY-2)
}

#[test]
fn cp_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x41);
    c.bus.write_mem(0x1001, 0x61);
    c.bus.write_mem(0x1002, 0x22);
    load_bin("tests/cp_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_hl()); // LD HL,0x1000
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_ix(),); // LD IX,0x1000
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_iy()); // LD IY,0x1003
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a); // LD A,0x41
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // CP (HL)
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | NF | CF | XF); // CP (IX+1)
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | NF | YF); // CP (IY-1)
}

#[test]
fn sbc_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/sbc_r.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..7 {
        c.exec_opcode();
    }
    // LD  A,0x04
    // LD  B,0x01
    // LD  C,0xF8
    // LD  D,0x0F
    // LD  E,0x79
    // LD  H,0xC0
    // LD  L,0xBF
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // SUB A,A
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SBC A,B (0x00 - 0x01)
    c.exec_opcode();
    assert_eq!(0x06, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // SBC A,C (0xFF - 0xF8 - carry)
    c.exec_opcode();
    assert_eq!(0xF7, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF); // SBC A,D (0x06 - 0x0F)
    c.exec_opcode();
    assert_eq!(0x7D, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | VF | NF | XF | YF); // SBC A,E (0xF7 - 0x79)
    c.exec_opcode();
    assert_eq!(0xBD, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | VF | NF | CF | XF | YF); // SBC A,H (0x7D - 0xC0)
    c.exec_opcode();
    assert_eq!(0xFD, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SBC A,L (0xBD - 0xBF - carry ) should set HF
    c.exec_opcode();
    assert_eq!(0xFB, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | NF | XF | YF); // SBC A,0x01
    c.exec_opcode();
    assert_eq!(0xFD, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SBC A,0xFE
}

#[test]
fn sbc_ixyh_ixyl_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/sbc_ixyh_ixyl.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    c.exec_opcode();
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // SUB A,A
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SBC A,IXH
    c.exec_opcode();
    assert_eq!(0x06, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // SBC A,IXL
    c.exec_opcode();
    c.exec_opcode();
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // SUB A,A
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // SBC A,IYH
    c.exec_opcode();
    assert_eq!(0x06, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // SBC A,IYL
}

#[test]
fn sbc_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x41);
    c.bus.write_mem(0x1001, 0x61);
    c.bus.write_mem(0x1002, 0x81);
    load_bin("tests/sbc_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_ix(),);
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_iy());
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0xBF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x5D, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), VF | NF | YF);
    c.exec_opcode();
    assert_eq!(0xFC, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | NF | CF | XF | YF);
}

#[test]
fn or_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/or_r.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..7 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF); // OR A
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // OR B
    c.exec_opcode();
    assert_eq!(0x03, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF); // OR C
    c.exec_opcode();
    assert_eq!(0x07, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // OR D
    c.exec_opcode();
    assert_eq!(0x0F, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF | YF); // OR E
    c.exec_opcode();
    assert_eq!(0x1F, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), YF); // OR H
    c.exec_opcode();
    assert_eq!(0x3F, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF | XF | YF); // OR L
    c.exec_opcode();
    assert_eq!(0x7F, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), XF | YF); // OR 0x40
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF); // OR 0x80
}

#[test]
fn xor_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/xor_r.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..7 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF); // XOR A
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // XOR B
    c.exec_opcode();
    assert_eq!(0x02, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // XOR C
    c.exec_opcode();
    assert_eq!(0x05, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF); // XOR D
    c.exec_opcode();
    assert_eq!(0x0A, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF | YF); // XOR E
    c.exec_opcode();
    assert_eq!(0x15, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // XOR H
    c.exec_opcode();
    assert_eq!(0x2A, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), XF | YF); // XOR L
    c.exec_opcode();
    assert_eq!(0x55, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF); // XOR 0x7F
    c.exec_opcode();
    assert_eq!(0xAA, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF); // XOR 0xFF
}

#[test]
fn or_xor_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x41);
    c.bus.write_mem(0x1001, 0x62);
    c.bus.write_mem(0x1002, 0x84);
    load_bin("tests/or_xor_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF); // OR (HL)
    c.exec_opcode();
    assert_eq!(0x63, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF | XF); // OR (IX+1)
    c.exec_opcode();
    assert_eq!(0xE7, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF); // OR (IY-1)
    c.exec_opcode();
    assert_eq!(0xA6, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF); // XOR (HL)
    c.exec_opcode();
    assert_eq!(0xC4, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF); // XOR (IX+1)
    c.exec_opcode();
    assert_eq!(0x40, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // XOR (IY-1)
}

#[test]
fn and_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/and_r.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..7 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF); // AND B
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF); // OR 0xFF
    c.exec_opcode();
    assert_eq!(0x03, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | PF); // AND C
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF); // OR 0xFF
    c.exec_opcode();
    assert_eq!(0x04, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF); // AND D
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF); // OR 0xFF
    c.exec_opcode();
    assert_eq!(0x08, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | YF); // AND E
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF); // OR 0xFF
    c.exec_opcode();
    assert_eq!(0x10, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF); // AND H
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF); // OR 0xFF
    c.exec_opcode();
    assert_eq!(0x20, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | XF); // AND L
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF); // OR 0xFF
    c.exec_opcode();
    assert_eq!(0x40, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF); // AND 0x40
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF); // OR 0xFF
    c.exec_opcode();
    assert_eq!(0xAA, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | PF | XF | YF); // AND 0xAA
}

#[test]
fn and_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0xFE);
    c.bus.write_mem(0x1001, 0xAA);
    c.bus.write_mem(0x1002, 0x99);
    load_bin("tests/and_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..4 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | XF | YF); // AND (HL)
    c.exec_opcode();
    assert_eq!(0xAA, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | PF | XF | YF); // AND (IX+1)
    c.exec_opcode();
    assert_eq!(0x88, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | PF | YF); // AND (IY-1)
}

#[test]
fn inc_dec_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/inc_dec_r.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..7 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0); // INC A
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // DEC A
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | HF); // INC B
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | XF | YF); // DEC B
    c.exec_opcode();
    assert_eq!(0x10, c.registers.reg_c);
    assert_eq!(c.registers.reg_f.to_byte(), HF); // INC C
    c.exec_opcode();
    assert_eq!(0x0F, c.registers.reg_c);
    assert_eq!(c.registers.reg_f.to_byte(), HF | NF | YF); // DEC C
    c.exec_opcode();
    assert_eq!(0x0F, c.registers.reg_d);
    assert_eq!(c.registers.reg_f.to_byte(), YF); // INC D
    c.exec_opcode();
    assert_eq!(0x0E, c.registers.reg_d);
    assert_eq!(c.registers.reg_f.to_byte(), NF | YF); // DEC D
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF); // CP 0x01   set carry flag (should be preserved)
    c.exec_opcode();
    assert_eq!(0x80, c.registers.reg_e);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | VF | CF); // INC E
    c.exec_opcode();
    assert_eq!(0x7F, c.registers.reg_e);
    assert_eq!(c.registers.reg_f.to_byte(), HF | VF | NF | CF | XF | YF); // DEC E
    c.exec_opcode();
    assert_eq!(0x3F, c.registers.reg_h);
    assert_eq!(c.registers.reg_f.to_byte(), CF | XF | YF); // INC H
    c.exec_opcode();
    assert_eq!(0x3E, c.registers.reg_h);
    assert_eq!(c.registers.reg_f.to_byte(), NF | CF | XF | YF); // DEC H
    c.exec_opcode();
    assert_eq!(0x24, c.registers.reg_l);
    assert_eq!(c.registers.reg_f.to_byte(), CF | XF); // INC L
    c.exec_opcode();
    assert_eq!(0x23, c.registers.reg_l);
    assert_eq!(c.registers.reg_f.to_byte(), NF | CF | XF); // DEC L
}

#[test]
fn inc_dec_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x00);
    c.bus.write_mem(0x1001, 0x3F);
    c.bus.write_mem(0x1002, 0x7F);
    load_bin("tests/inc_dec_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0xFF, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | XF | YF); // DEC (HL)
    c.exec_opcode();
    assert_eq!(0x00, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), ZF | HF); // INC (HL)
    c.exec_opcode();
    assert_eq!(0x40, c.bus.read_mem(0x1001));
    assert_eq!(c.registers.reg_f.to_byte(), HF); // INC (IX+1)
    c.exec_opcode();
    assert_eq!(0x3F, c.bus.read_mem(0x1001));
    assert_eq!(c.registers.reg_f.to_byte(), HF | NF | XF | YF); // DEC (IX+1)
    c.exec_opcode();
    assert_eq!(0x80, c.bus.read_mem(0x1002));
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | VF); // INC (IY-1)
    c.exec_opcode();
    assert_eq!(0x7F, c.bus.read_mem(0x1002));
    assert_eq!(c.registers.reg_f.to_byte(), HF | PF | NF | XF | YF); // DEC (IY-1)
}

#[test]
fn inc_dec_ss_ix_iy_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/inc_dec_ss_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..6 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0xFFFF, c.registers.get_bc()); // DEC BC
    c.exec_opcode();
    assert_eq!(0x0000, c.registers.get_bc()); // INC BC
    c.exec_opcode();
    assert_eq!(0x0000, c.registers.get_de()); // INC DE
    c.exec_opcode();
    assert_eq!(0xFFFF, c.registers.get_de()); // DEC DE
    c.exec_opcode();
    assert_eq!(0x0100, c.registers.get_hl()); // INC HL
    c.exec_opcode();
    assert_eq!(0x00FF, c.registers.get_hl()); // DEC HL
    c.exec_opcode();
    assert_eq!(0x1112, c.registers.reg_sp); // INC SP
    c.exec_opcode();
    assert_eq!(0x1111, c.registers.reg_sp); // DEC SP
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_ix(),); // INC IX
    c.exec_opcode();
    assert_eq!(0x0FFF, c.registers.get_ix(),); // DEC IX
    c.exec_opcode();
    assert_eq!(0x1235, c.registers.get_iy()); // INC IY
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.get_iy()); // DEC IY
}

#[test]
fn djnz_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/djnz.bin", &mut c.bus.ram, 0x0204).unwrap();
    c.registers.reg_pc = 0x0204;
    c.exec_opcode();
    assert_eq!(0x03, c.registers.reg_b);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x02, c.registers.reg_b);
    assert_eq!(0x0207, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x02, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_b);
    assert_eq!(0x0207, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x03, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_b);
    assert_eq!(0x020A, c.registers.reg_pc);
}

#[test]
fn jr_cc_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/jr_cc.bin", &mut c.bus.ram, 0x0204).unwrap();
    c.registers.reg_pc = 0x0204;
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x0207, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x020A, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x020E, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0211, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x0215, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0218, c.registers.reg_pc);
}

#[test]
fn ld_i_hl_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_i_hl_r.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x12, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x12, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x13, c.registers.reg_b);
    c.exec_opcode();
    assert_eq!(0x13, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x14, c.registers.reg_c);
    c.exec_opcode();
    assert_eq!(0x14, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x15, c.registers.reg_d);
    c.exec_opcode();
    assert_eq!(0x15, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x16, c.registers.reg_e);
    c.exec_opcode();
    assert_eq!(0x16, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x10, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x00, c.bus.read_mem(0x1000));
}

#[test]
fn ld_a_i_bc_de_nn_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_a_i_bc_de_nn.bin", &mut c.bus.ram, 0).unwrap();
    c.bus.write_mem(0x1000, 0x11);
    c.bus.write_mem(0x1001, 0x22);
    c.bus.write_mem(0x1002, 0x33);
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_bc());
    c.exec_opcode();
    assert_eq!(0x1001, c.registers.get_de());
    c.exec_opcode();
    assert_eq!(0x11, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x22, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x33, c.registers.reg_a);
}

#[test]
fn inc_dec_ss_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/inc_dec_ss.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..4 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0xFFFF, c.registers.get_bc());
    c.exec_opcode();
    assert_eq!(0x0000, c.registers.get_bc());
    c.exec_opcode();
    assert_eq!(0x0000, c.registers.get_de());
    c.exec_opcode();
    assert_eq!(0xFFFF, c.registers.get_de());
    c.exec_opcode();
    assert_eq!(0x0100, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x00FF, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x1112, c.registers.reg_sp);
    c.exec_opcode();
    assert_eq!(0x1111, c.registers.reg_sp);
}

#[test]
fn ld_i_bc_de_nn_a_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_i_bc_de_nn_a.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_bc()); // LD BC,0x1000
    c.exec_opcode();
    assert_eq!(0x1001, c.registers.get_de()); // LD DE,0x1001
    c.exec_opcode();
    assert_eq!(0x77, c.registers.reg_a); // LD A,0x77
    c.exec_opcode();
    assert_eq!(0x77, c.bus.read_mem(0x1000)); // LD (BC),A
    c.exec_opcode();
    assert_eq!(0x77, c.bus.read_mem(0x1001)); // LD (DE),A
    c.exec_opcode();
    assert_eq!(0x77, c.bus.read_mem(0x1002)); // LD (0x1002),A
}

#[test]
fn rlca_rla_rrca_rra_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/rlca_rla_rrca_rra.bin", &mut c.bus.ram, 0).unwrap();
    c.registers.reg_f.from(0xFF);
    c.exec_opcode();
    assert_eq!(0xA0, c.registers.reg_a); // LD A,0xA0
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a); // RLCA
    c.exec_opcode();
    assert_eq!(0x82, c.registers.reg_a); // RLCA
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a); // RRCA
    c.exec_opcode();
    assert_eq!(0xA0, c.registers.reg_a); // RRCA
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a); // RLA
    c.exec_opcode();
    assert_eq!(0x83, c.registers.reg_a); // RLA
    c.exec_opcode();
    assert_eq!(0x41, c.registers.reg_a); // RRA
    c.exec_opcode();
    assert_eq!(0xA0, c.registers.reg_a); // RRA
}

#[test]
fn daa_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/daa.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x15, c.registers.reg_a); // LD A,0x15
    c.exec_opcode();
    assert_eq!(0x27, c.registers.reg_b); // LD B,0x27
    c.exec_opcode();
    assert_eq!(0x3C, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), XF | YF); // ADD A,B
    c.exec_opcode();
    assert_eq!(0x42, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | PF); // DAA
    c.exec_opcode();
    assert_eq!(0x1B, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | NF | YF); // SUB B
    c.exec_opcode();
    assert_eq!(0x15, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // DAA
    c.exec_opcode();
    assert_eq!(0x90, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // LD A,0x90
    c.exec_opcode();
    assert_eq!(0x15, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), NF); // LD B,0x15
    c.exec_opcode();
    assert_eq!(0xA5, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF); // ADD A,B
    c.exec_opcode();
    assert_eq!(0x05, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF | CF); // DAA
    c.exec_opcode();
    assert_eq!(0xF0, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | NF | CF | XF); // SUB B
    c.exec_opcode();
    assert_eq!(0x90, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | NF | CF); // DAA
}

#[test]
fn cpl_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/cpl.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // SUB A
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | HF | NF | XF | YF); // CPL
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | HF | NF); // CPL
    c.exec_opcode();
    assert_eq!(0xAA, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF | YF); // ADD A,0xAA
    c.exec_opcode();
    assert_eq!(0x55, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF); // CPL
    c.exec_opcode();
    assert_eq!(0xAA, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | XF | YF); // CPL
}

#[test]
fn ccf_scf_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ccf_scf.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // SUB A
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | CF); // SCF
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | HF); // CCF
    c.exec_opcode();
    assert_eq!(0x34, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), HF | NF | CF | XF); // SUB 0xCC
    c.exec_opcode();
    assert_eq!(0x34, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), XF | HF); // CCF
    c.exec_opcode();
    assert_eq!(0x34, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), XF | CF); // SCF
}

#[test]
fn call_ret_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/call_ret.bin", &mut c.bus.ram, 0x0204).unwrap();
    c.registers.reg_pc = 0x0204;
    c.exec_opcode();
    assert_eq!(0x020A, c.registers.reg_pc);
    assert_eq!(0xFFFE, c.registers.reg_sp);
    assert_eq!(0x0207, c.bus.read_mem_u16(0xFFFE));
    c.exec_opcode();
    assert_eq!(0x0207, c.registers.reg_pc);
    assert_eq!(0x0000, c.registers.reg_sp);
    c.exec_opcode();
    assert_eq!(0x020A, c.registers.reg_pc);
    assert_eq!(0xFFFE, c.registers.reg_sp);
    assert_eq!(0x020A, c.bus.read_mem_u16(0xFFFE));
    c.exec_opcode();
    assert_eq!(0x020A, c.registers.reg_pc);
    assert_eq!(0x0000, c.registers.reg_sp);
}

#[test]
fn call_cc_ret_cc_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/call_cc_ret_cc.bin", &mut c.bus.ram, 0x0204).unwrap();
    c.registers.reg_pc = 0x0204;
    c.registers.reg_sp = 0x0100;
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x0208, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0229, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x022A, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x020B, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x0210, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x022B, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x022C, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0213, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x02, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x0217, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x022D, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x022E, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x021A, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x021F, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x022F, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0230, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0222, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0225, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0231, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0232, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0228, c.registers.reg_pc);
}

#[test]
fn halt_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/halt.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x0000, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0000, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0000, c.registers.reg_pc);
}

#[test]
fn ex_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ex.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x5678, c.registers.get_de());
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.get_de());
    assert_eq!(0x5678, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x1100, c.registers.get_af());
    assert_eq!(0x0000, c.alternate.get_af());
    c.exec_opcode();
    assert_eq!(0x0000, c.registers.get_af());
    assert_eq!(0x1100, c.alternate.get_af());
    c.exec_opcode();
    assert_eq!(0x2200, c.registers.get_af());
    assert_eq!(0x1100, c.alternate.get_af());
    c.exec_opcode();
    assert_eq!(0x1100, c.registers.get_af());
    assert_eq!(0x2200, c.alternate.get_af());
    c.exec_opcode();
    assert_eq!(0x9ABC, c.registers.get_bc());
    c.exec_opcode();
    assert_eq!(0x0000, c.registers.get_hl());
    assert_eq!(0x5678, c.alternate.get_hl());
    assert_eq!(0x0000, c.registers.get_de());
    assert_eq!(0x1234, c.alternate.get_de());
    assert_eq!(0x0000, c.registers.get_bc());
    assert_eq!(0x9ABC, c.alternate.get_bc());
    c.exec_opcode();
    assert_eq!(0x1111, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x2222, c.registers.get_de());
    c.exec_opcode();
    assert_eq!(0x3333, c.registers.get_bc());
    c.exec_opcode();
    assert_eq!(0x5678, c.registers.get_hl());
    assert_eq!(0x1111, c.alternate.get_hl());
    assert_eq!(0x1234, c.registers.get_de());
    assert_eq!(0x2222, c.alternate.get_de());
    assert_eq!(0x9ABC, c.registers.get_bc());
    assert_eq!(0x3333, c.alternate.get_bc());
    c.exec_opcode();
    assert_eq!(0x0100, c.registers.reg_sp);
    c.exec_opcode();
    assert_eq!(0x1234, c.bus.read_mem_u16(0x00FE));
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.get_hl());
    assert_eq!(0x5678, c.bus.read_mem_u16(0x00FE));
    c.exec_opcode();
    assert_eq!(0x8899, c.registers.get_ix(),);
    c.exec_opcode();
    assert_eq!(0x5678, c.registers.get_ix(),);
    assert_eq!(0x8899, c.bus.read_mem_u16(0x00FE));
    c.exec_opcode();
    assert_eq!(0x6677, c.registers.get_iy());
    c.exec_opcode();
    assert_eq!(0x8899, c.registers.get_iy());
    assert_eq!(0x6677, c.bus.read_mem_u16(0x00FE));
}

#[test]
fn jp_cc_nn_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/jp_cc_nn.bin", &mut c.bus.ram, 0x0204).unwrap();
    c.registers.reg_pc = 0x0204;
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF);
    c.exec_opcode();
    assert_eq!(0x0208, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x020C, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x0211, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0215, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x02, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x0219, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x021D, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x0222, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0226, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x022D, c.registers.reg_pc);
}

#[test]
fn jp_jr_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/jp_jr.bin", &mut c.bus.ram, 0x0204).unwrap();
    c.registers.reg_pc = 0x0204;
    c.exec_opcode();
    assert_eq!(0x0216, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x0219, c.registers.get_ix(),);
    c.exec_opcode();
    assert_eq!(0x0221, c.registers.get_iy());
    c.exec_opcode();
    assert_eq!(0x0214, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0212, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0218, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0216, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0219, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0221, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x021B, c.registers.reg_pc);
    c.exec_opcode();
    assert_eq!(0x0223, c.registers.reg_pc);
}

#[test]
fn ldi_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x02);
    c.bus.write_mem(0x1002, 0x03);
    load_bin("tests/ldi.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x1001, c.registers.get_hl());
    assert_eq!(0x2001, c.registers.get_de());
    assert_eq!(0x0002, c.registers.get_bc());
    assert_eq!(0x01, c.bus.read_mem(0x2000));
    assert_eq!(c.registers.reg_f.to_byte(), PF);
    c.exec_opcode();
    assert_eq!(0x1002, c.registers.get_hl());
    assert_eq!(0x2002, c.registers.get_de());
    assert_eq!(0x0001, c.registers.get_bc());
    assert_eq!(0x02, c.bus.read_mem(0x2001));
    assert_eq!(c.registers.reg_f.to_byte(), PF | YF);
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_hl());
    assert_eq!(0x2003, c.registers.get_de());
    assert_eq!(0x0000, c.registers.get_bc());
    assert_eq!(0x03, c.bus.read_mem(0x2002));
    assert_eq!(c.registers.reg_f.to_byte(), YF);
}

#[test]
fn ldir_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x02);
    c.bus.write_mem(0x1002, 0x03);
    load_bin("tests/ldir.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_hl());
    assert_eq!(0x2003, c.registers.get_de());
    assert_eq!(0x0000, c.registers.get_bc());
    assert_eq!(0x03, c.bus.read_mem(0x2002));
    assert_eq!(c.registers.reg_f.to_byte(), YF);
    c.exec_opcode();
    assert_eq!(0x33, c.registers.reg_a);
}

#[test]
fn ldd_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x02);
    c.bus.write_mem(0x1002, 0x03);
    load_bin("tests/ldd.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x1001, c.registers.get_hl());
    assert_eq!(0x2001, c.registers.get_de());
    assert_eq!(0x0002, c.registers.get_bc());
    assert_eq!(0x03, c.bus.read_mem(0x2002));
    assert_eq!(c.registers.reg_f.to_byte(), PF | YF);
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_hl());
    assert_eq!(0x2000, c.registers.get_de());
    assert_eq!(0x0001, c.registers.get_bc());
    assert_eq!(0x02, c.bus.read_mem(0x2001));
    assert_eq!(c.registers.reg_f.to_byte(), PF | YF);
    c.exec_opcode();
    assert_eq!(0x0FFF, c.registers.get_hl());
    assert_eq!(0x1FFF, c.registers.get_de());
    assert_eq!(0x0000, c.registers.get_bc());
    assert_eq!(0x01, c.bus.read_mem(0x2000));
    assert_eq!(c.registers.reg_f.to_byte(), 0);
}

#[test]
fn lddr_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x02);
    c.bus.write_mem(0x1002, 0x03);
    load_bin("tests/lddr.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x0FFF, c.registers.get_hl());
    assert_eq!(0x1FFF, c.registers.get_de());
    assert_eq!(0x0000, c.registers.get_bc());
    assert_eq!(0x01, c.bus.read_mem(0x2000));
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x33, c.registers.reg_a);
}

#[test]
fn cpi_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x02);
    c.bus.write_mem(0x1002, 0x03);
    c.bus.write_mem(0x1003, 0x04);
    load_bin("tests/cpi.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x1001, c.registers.get_hl());
    assert_eq!(0x0003, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), PF | NF | YF);
    let f = c.registers.reg_f.to_byte() | CF;
    c.registers.reg_f.from(f);
    c.exec_opcode();
    assert_eq!(0x1002, c.registers.get_hl());
    assert_eq!(0x0002, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), PF | NF | CF);
    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_hl());
    assert_eq!(0x0001, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | NF | CF);
    c.exec_opcode();
    assert_eq!(0x1004, c.registers.get_hl());
    assert_eq!(0x0000, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | CF | XF | YF);
}

#[test]
fn cpir_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x02);
    c.bus.write_mem(0x1002, 0x03);
    c.bus.write_mem(0x1003, 0x04);
    load_bin("tests/cpir.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }

    c.exec_opcode();
    assert_eq!(0x1003, c.registers.get_hl());
    assert_eq!(0x0001, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | NF);

    c.exec_opcode();
    assert_eq!(0x1004, c.registers.get_hl());
    assert_eq!(0x0000, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | NF | XF | YF);
}

#[test]
fn cpd_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x02);
    c.bus.write_mem(0x1002, 0x03);
    c.bus.write_mem(0x1003, 0x04);
    load_bin("tests/cpd.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x1002, c.registers.get_hl());
    assert_eq!(0x0003, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | PF | NF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x1001, c.registers.get_hl());
    assert_eq!(0x0002, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | NF);
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_hl());
    assert_eq!(0x0001, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), PF | NF);
    c.exec_opcode();
    assert_eq!(0x0FFF, c.registers.get_hl());
    assert_eq!(0x0000, c.registers.get_bc());
    assert_eq!(c.registers.reg_f.to_byte(), NF | YF);
}

#[test]
fn add_adc_sbc_16_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/add_adc_sbc_16.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x00FC, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x0008, c.registers.get_bc());
    c.exec_opcode();
    assert_eq!(0xFFFF, c.registers.get_de());
    c.exec_opcode();
    assert_eq!(0x0104, c.registers.get_hl());
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x0103, c.registers.get_hl());
    assert_eq!(c.registers.reg_f.to_byte(), HF | CF);
    c.exec_opcode();
    assert_eq!(0x010C, c.registers.get_hl());
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x0218, c.registers.get_hl());
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x0217, c.registers.get_hl());
    assert_eq!(c.registers.reg_f.to_byte(), HF | CF);
    c.exec_opcode();
    assert_eq!(0x020E, c.registers.get_hl());
    assert_eq!(c.registers.reg_f.to_byte(), NF);
    c.exec_opcode();
    assert_eq!(0x00FC, c.registers.get_ix(),);
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.reg_sp);
    c.exec_opcode();
    assert_eq!(0x0104, c.registers.get_ix(),);
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x0103, c.registers.get_ix(),);
    assert_eq!(c.registers.reg_f.to_byte(), HF | CF);
    c.exec_opcode();
    assert_eq!(0x0206, c.registers.get_ix(),);
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x1206, c.registers.get_ix(),);
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0xFFFF, c.registers.get_iy());
    c.exec_opcode();
    assert_eq!(0x0007, c.registers.get_iy());
    assert_eq!(c.registers.reg_f.to_byte(), HF | CF);
    c.exec_opcode();
    assert_eq!(0x0006, c.registers.get_iy());
    assert_eq!(c.registers.reg_f.to_byte(), HF | CF);
    c.exec_opcode();
    assert_eq!(0x000C, c.registers.get_iy());
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x100C, c.registers.get_iy());
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x7FFF, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x0001, c.registers.get_bc());
    c.exec_opcode();
    assert_eq!(0x8000, c.registers.get_hl());
    assert_eq!(c.registers.reg_f.to_byte(), SF | HF | PF);
    c.exec_opcode();
    assert_eq!(0x7FFF, c.registers.get_hl());
    assert_eq!(c.registers.reg_f.to_byte(), NF | HF | PF | XF | YF);
}

#[test]
fn ld_inn_hl_dd_ix_iy_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_inn_hl_dd_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x0201, c.registers.get_hl()); // LD HL,0x0201
    c.exec_opcode();
    assert_eq!(0x0201, c.bus.read_mem_u16(0x1000)); // LD (0x1000),HL
    c.exec_opcode();
    assert_eq!(0x1234, c.registers.get_bc()); // LD BC,0x1234
    c.exec_opcode();
    assert_eq!(0x1234, c.bus.read_mem_u16(0x1002)); // LD (0x1002),BC
    c.exec_opcode();
    assert_eq!(0x5678, c.registers.get_de()); // LD DE,0x5678
    c.exec_opcode();
    assert_eq!(0x5678, c.bus.read_mem_u16(0x1004)); // LD (0x1004),DE
    c.exec_opcode();
    assert_eq!(0x9ABC, c.registers.get_hl()); // LD HL,0x9ABC
    c.exec_opcode();
    assert_eq!(0x9ABC, c.bus.read_mem_u16(0x1006)); // LD (0x1006),HL
    c.exec_opcode();
    assert_eq!(0x1368, c.registers.reg_sp); // LD SP,0x1368
    c.exec_opcode();
    assert_eq!(0x1368, c.bus.read_mem_u16(0x1008)); // LD (0x1008),SP
    c.exec_opcode();
    assert_eq!(0x4321, c.registers.get_ix(),); // LD IX,0x4321
    c.exec_opcode();
    assert_eq!(0x4321, c.bus.read_mem_u16(0x100A)); // LD (0x100A),IX
    c.exec_opcode();
    assert_eq!(0x8765, c.registers.get_iy()); // LD IY,0x8765
    c.exec_opcode();
    assert_eq!(0x8765, c.bus.read_mem_u16(0x100C)); // LD (0x100C),IY
}

#[test]
fn ld_a_ir_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_a_ir.bin", &mut c.bus.ram, 0).unwrap();
    c.registers.reg_r = 0x34;
    c.registers.reg_i = 0x1;
    c.registers.reg_f.c = true;
    c.exec_opcode();
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF | CF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF);
    c.exec_opcode();
    assert_eq!(0x34, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), PF | XF);
}

#[test]
fn ld_ir_a_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/ld_ir_a.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x45, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x45, c.registers.reg_i);
    c.exec_opcode();
    assert_eq!(0x45, c.registers.reg_r);
}

#[test]
fn rlc_rl_rrc_rr_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/rlc_rl_rrc_rr_r.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..7 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x80, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), SF | CF);
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), CF);
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x06, c.registers.reg_c);
    assert_eq!(c.registers.reg_f.to_byte(), PF);
    c.exec_opcode();
    assert_eq!(0x03, c.registers.reg_c);
    assert_eq!(c.registers.reg_f.to_byte(), PF);
    c.exec_opcode();
    assert_eq!(0xFD, c.registers.reg_d);
    assert_eq!(c.registers.reg_f.to_byte(), SF | CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_d);
    assert_eq!(c.registers.reg_f.to_byte(), SF | CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x88, c.registers.reg_e);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | YF);
    c.exec_opcode();
    assert_eq!(0x11, c.registers.reg_e);
    assert_eq!(c.registers.reg_f.to_byte(), PF | CF);
    c.exec_opcode();
    assert_eq!(0x7E, c.registers.reg_h);
    assert_eq!(c.registers.reg_f.to_byte(), PF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x3F, c.registers.reg_h);
    assert_eq!(c.registers.reg_f.to_byte(), PF | XF | YF);
    c.exec_opcode();
    assert_eq!(0xE0, c.registers.reg_l);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF);
    c.exec_opcode();
    assert_eq!(0x70, c.registers.reg_l);
    assert_eq!(c.registers.reg_f.to_byte(), XF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | CF);
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x7F, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x06, c.registers.reg_c);
    assert_eq!(c.registers.reg_f.to_byte(), PF);
    c.exec_opcode();
    assert_eq!(0x03, c.registers.reg_c);
    assert_eq!(c.registers.reg_f.to_byte(), PF);
    c.exec_opcode();
    assert_eq!(0xFC, c.registers.reg_d);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_d);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x08, c.registers.reg_e);
    assert_eq!(c.registers.reg_f.to_byte(), CF | YF);
    c.exec_opcode();
    assert_eq!(0x11, c.registers.reg_e);
    assert_eq!(c.registers.reg_f.to_byte(), PF);
    c.exec_opcode();
    assert_eq!(0x7E, c.registers.reg_h);
    assert_eq!(c.registers.reg_f.to_byte(), PF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x3F, c.registers.reg_h);
    assert_eq!(c.registers.reg_f.to_byte(), PF | XF | YF);
    c.exec_opcode();
    assert_eq!(0xE0, c.registers.reg_l);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF);
    c.exec_opcode();
    assert_eq!(0x70, c.registers.reg_l);
    assert_eq!(c.registers.reg_f.to_byte(), XF);
}

#[test]
fn rrc_rlc_rr_rl_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0xFF);
    c.bus.write_mem(0x1002, 0x11);
    load_bin("tests/rrc_rlc_rr_rl_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x80, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), SF | CF); // RRC (HL)
    c.exec_opcode();
    assert_eq!(0x80, c.registers.reg_a); // LD A,(HL)
    c.exec_opcode();
    assert_eq!(0x01, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), CF); // RLC (HL)
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a); // LD A,(HL)
    c.exec_opcode();
    assert_eq!(0xFF, c.bus.read_mem(0x1001));
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | XF | YF); // RRC (IX+1)
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a); // LD A,(IX+1)
    c.exec_opcode();
    assert_eq!(0xFF, c.bus.read_mem(0x1001));
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | XF | YF); // RLC (IX+1)
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a); // LD A,(IX+1)
    c.exec_opcode();
    assert_eq!(0x88, c.bus.read_mem(0x1002));
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | YF); // RRC (IY-1)
    c.exec_opcode();
    assert_eq!(0x88, c.registers.reg_a); // LD A,(IY-1)
    c.exec_opcode();
    assert_eq!(0x11, c.bus.read_mem(0x1002));
    assert_eq!(c.registers.reg_f.to_byte(), PF | CF); // RLC (IY-1)
    c.exec_opcode();
    assert_eq!(0x11, c.registers.reg_a); // LD A,(IY-1)
    c.exec_opcode();
    assert_eq!(0x80, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), SF | CF); // RR (HL)
    c.exec_opcode();
    assert_eq!(0x80, c.registers.reg_a); // LD A,(HL)
    c.exec_opcode();
    assert_eq!(0x01, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), CF); // RL (HL)
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a); // LD A,(HL)
    c.exec_opcode();
    assert_eq!(0xFF, c.bus.read_mem(0x1001));
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | XF | YF); // RR (IX+1)
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a); // LD A,(IX+1)
    c.exec_opcode();
    assert_eq!(0xFF, c.bus.read_mem(0x1001));
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | XF | YF); // RL (IX+1)
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_a); // LD A,(IX+1)
    c.exec_opcode();
    assert_eq!(0x23, c.bus.read_mem(0x1002));
    assert_eq!(c.registers.reg_f.to_byte(), XF); // RL (IY-1)
    c.exec_opcode();
    assert_eq!(0x23, c.registers.reg_a); // LD A,(IY-1)
    c.exec_opcode();
    assert_eq!(0x11, c.bus.read_mem(0x1002));
    assert_eq!(c.registers.reg_f.to_byte(), PF | CF); // RR (IY-1)
    c.exec_opcode();
    assert_eq!(0x11, c.registers.reg_a); // LD A,(IY-1)
}

#[test]
fn sla_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/sla_r.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..7 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x02, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | CF);
    c.exec_opcode();
    assert_eq!(0x54, c.registers.reg_c);
    assert_eq!(c.registers.reg_f.to_byte(), CF);
    c.exec_opcode();
    assert_eq!(0xFC, c.registers.reg_d);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_e);
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x22, c.registers.reg_h);
    assert_eq!(c.registers.reg_f.to_byte(), PF | XF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_l);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF);
}

#[test]
fn sra_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/sra_r.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..7 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | CF);
    c.exec_opcode();
    assert_eq!(0xC0, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF);
    c.exec_opcode();
    assert_eq!(0xD5, c.registers.reg_c);
    assert_eq!(c.registers.reg_f.to_byte(), SF);
    c.exec_opcode();
    assert_eq!(0xFF, c.registers.reg_d);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x3F, c.registers.reg_e);
    assert_eq!(c.registers.reg_f.to_byte(), PF | CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x08, c.registers.reg_h);
    assert_eq!(c.registers.reg_f.to_byte(), CF | YF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_l);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF);
}

#[test]
fn srl_r_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/srl_r.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..7 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | CF);
    c.exec_opcode();
    assert_eq!(0x40, c.registers.reg_b);
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x55, c.registers.reg_c);
    assert_eq!(c.registers.reg_f.to_byte(), PF);
    c.exec_opcode();
    assert_eq!(0x7F, c.registers.reg_d);
    assert_eq!(c.registers.reg_f.to_byte(), XF | YF);
    c.exec_opcode();
    assert_eq!(0x3F, c.registers.reg_e);
    assert_eq!(c.registers.reg_f.to_byte(), PF | CF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x08, c.registers.reg_h);
    assert_eq!(c.registers.reg_f.to_byte(), CF | YF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_l);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF);
}

#[test]
fn sla_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x80);
    c.bus.write_mem(0x1002, 0xAA);
    load_bin("tests/sla_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x02, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x02, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x00, c.bus.read_mem(0x1001));
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | CF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x54, c.bus.read_mem(0x1002));
    assert_eq!(c.registers.reg_f.to_byte(), CF);
    c.exec_opcode();
    assert_eq!(0x54, c.registers.reg_a);
}

#[test]
fn sra_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x80);
    c.bus.write_mem(0x1002, 0xAA);
    load_bin("tests/sra_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x00, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | CF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0xC0, c.bus.read_mem(0x1001));
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF);
    c.exec_opcode();
    assert_eq!(0xC0, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0xD5, c.bus.read_mem(0x1002));
    assert_eq!(c.registers.reg_f.to_byte(), SF);
    c.exec_opcode();
    assert_eq!(0xD5, c.registers.reg_a);
}

#[test]
fn srl_i_hl_ix_iy_asm() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x1000, 0x01);
    c.bus.write_mem(0x1001, 0x80);
    c.bus.write_mem(0x1002, 0xAA);
    load_bin("tests/srl_i_hl_ix_iy.bin", &mut c.bus.ram, 0).unwrap();
    for _ in 0..3 {
        c.exec_opcode();
    }
    c.exec_opcode();
    assert_eq!(0x00, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | CF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x40, c.bus.read_mem(0x1001));
    assert_eq!(c.registers.reg_f.to_byte(), 0);
    c.exec_opcode();
    assert_eq!(0x40, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x55, c.bus.read_mem(0x1002));
    assert_eq!(c.registers.reg_f.to_byte(), PF);
    c.exec_opcode();
    assert_eq!(0x55, c.registers.reg_a);
}

#[test]
fn rld_rrd_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/rld_rrd.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(0x12, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x1000, c.registers.get_hl());
    c.exec_opcode();
    assert_eq!(0x34, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x14, c.registers.reg_a);
    assert_eq!(0x23, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x12, c.registers.reg_a);
    assert_eq!(0x34, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0x34, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x00, c.bus.read_mem(0x1000));
    c.exec_opcode();
    assert_eq!(0xF0, c.registers.reg_a);
    assert_eq!(0x0E, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | XF);
    c.exec_opcode();
    assert_eq!(0xFE, c.registers.reg_a);
    assert_eq!(0x00, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), SF | XF | YF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    c.exec_opcode();
    assert_eq!(0x00, c.bus.read_mem(0x1000));
    c.registers.reg_f.from(CF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
    assert_eq!(0x01, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), ZF | PF | CF);
    c.exec_opcode();
    assert_eq!(0x01, c.registers.reg_a);
    assert_eq!(0x00, c.bus.read_mem(0x1000));
    assert_eq!(c.registers.reg_f.to_byte(), CF);
    c.exec_opcode();
    assert_eq!(0x00, c.registers.reg_a);
}

#[test]
fn ld_inn_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x63);
    c.bus.write_mem(0x0002, 0x06);
    c.bus.write_mem(0x0003, 0x10);
    c.registers.set_hl(0x9ABC);
    c.exec_opcode();
    assert_eq!(0x9ABC, c.bus.read_mem_u16(0x1006));
}

#[test]
fn ld_b() {
    let mut c = Cpu::new(None);
    c.registers.reg_b = 0x11;
    c.registers.reg_c = 0x15;
    c.registers.reg_d = 0x1F;
    c.registers.reg_e = 0x21;
    c.registers.reg_h = 0x25;
    c.registers.reg_l = 0x2F;
    c.bus.write_mem(0x252f, 0x31);
    c.registers.reg_a = 0x3F;
    c.bus.write_mem(0x0000, 0x40);
    c.bus.write_mem(0x0001, 0x41);
    c.bus.write_mem(0x0002, 0x42);
    c.bus.write_mem(0x0003, 0x43);
    c.bus.write_mem(0x0004, 0x44);
    c.bus.write_mem(0x0005, 0x45);
    c.bus.write_mem(0x0006, 0x46);
    c.bus.write_mem(0x0007, 0x47);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x11);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x15);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x1f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x21);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x25);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x2f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x31);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x3f);
    assert_eq!(c.registers.reg_pc, 8);
}

#[test]
fn ld_c() {
    let mut c = Cpu::new(None);
    c.registers.reg_b = 0x11;
    c.registers.reg_c = 0x15;
    c.registers.reg_d = 0x1F;
    c.registers.reg_e = 0x21;
    c.registers.reg_h = 0x25;
    c.registers.reg_l = 0x2F;
    c.bus.write_mem(0x252f, 0x31);
    c.registers.reg_a = 0x3F;
    c.bus.write_mem(0x0000, 0x48);
    c.bus.write_mem(0x0001, 0x49);
    c.bus.write_mem(0x0002, 0x4a);
    c.bus.write_mem(0x0003, 0x4b);
    c.bus.write_mem(0x0004, 0x4c);
    c.bus.write_mem(0x0005, 0x4d);
    c.bus.write_mem(0x0006, 0x4e);
    c.bus.write_mem(0x0007, 0x4f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x11);
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x11);
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x1f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x21);
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x25);
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x2f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x31);
    c.exec_opcode();
    assert_eq!(c.registers.reg_c, 0x3f);
    assert_eq!(c.registers.reg_pc, 8);
}

#[test]
fn ld_d() {
    let mut c = Cpu::new(None);
    c.registers.reg_b = 0x11;
    c.registers.reg_c = 0x15;
    c.registers.reg_d = 0x1F;
    c.registers.reg_e = 0x21;
    c.registers.reg_h = 0x25;
    c.registers.reg_l = 0x2F;
    c.bus.write_mem(0x252f, 0x31);
    c.registers.reg_a = 0x3F;
    c.bus.write_mem(0x0000, 0x50);
    c.bus.write_mem(0x0001, 0x51);
    c.bus.write_mem(0x0002, 0x52);
    c.bus.write_mem(0x0003, 0x53);
    c.bus.write_mem(0x0004, 0x54);
    c.bus.write_mem(0x0005, 0x55);
    c.bus.write_mem(0x0006, 0x56);
    c.bus.write_mem(0x0007, 0x57);
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x11);
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x15);
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x15);
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x21);
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x25);
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x2f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x31);
    c.exec_opcode();
    assert_eq!(c.registers.reg_d, 0x3f);
    assert_eq!(c.registers.reg_pc, 8);
}

#[test]
fn ld_e() {
    let mut c = Cpu::new(None);
    c.registers.reg_b = 0x11;
    c.registers.reg_c = 0x15;
    c.registers.reg_d = 0x1F;
    c.registers.reg_e = 0x21;
    c.registers.reg_h = 0x25;
    c.registers.reg_l = 0x2F;
    c.bus.write_mem(0x252f, 0x31);
    c.registers.reg_a = 0x3F;
    c.bus.write_mem(0x0000, 0x58);
    c.bus.write_mem(0x0001, 0x59);
    c.bus.write_mem(0x0002, 0x5a);
    c.bus.write_mem(0x0003, 0x5b);
    c.bus.write_mem(0x0004, 0x5c);
    c.bus.write_mem(0x0005, 0x5d);
    c.bus.write_mem(0x0006, 0x5e);
    c.bus.write_mem(0x0007, 0x5f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x11);
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x15);
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x1f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x1f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x25);
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x2f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x31);
    c.exec_opcode();
    assert_eq!(c.registers.reg_e, 0x3f);
    assert_eq!(c.registers.reg_pc, 8);
}

#[test]
fn ld_h() {
    let mut c = Cpu::new(None);
    c.registers.reg_b = 0x11;
    c.registers.reg_c = 0x15;
    c.registers.reg_d = 0x1F;
    c.registers.reg_e = 0x21;
    c.registers.reg_h = 0x25;
    c.registers.reg_l = 0x2F;
    c.bus.write_mem(0x2f2f, 0x31);
    c.registers.reg_a = 0x3F;
    c.bus.write_mem(0x0000, 0x60);
    c.bus.write_mem(0x0001, 0x61);
    c.bus.write_mem(0x0002, 0x62);
    c.bus.write_mem(0x0003, 0x63);
    c.bus.write_mem(0x0004, 0x64);
    c.bus.write_mem(0x0005, 0x65);
    c.bus.write_mem(0x0006, 0x66);
    c.bus.write_mem(0x0007, 0x67);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x11);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x15);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x1f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x21);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x21);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x2f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x31);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x3f);
    assert_eq!(c.registers.reg_pc, 8);
}

#[test]
fn ld_l() {
    let mut c = Cpu::new(None);
    c.registers.reg_b = 0x11;
    c.registers.reg_c = 0x15;
    c.registers.reg_d = 0x1F;
    c.registers.reg_e = 0x21;
    c.registers.reg_h = 0x25;
    c.registers.reg_l = 0x2F;
    c.bus.write_mem(0x2525, 0x31);
    c.registers.reg_a = 0x3F;
    c.bus.write_mem(0x0000, 0x68);
    c.bus.write_mem(0x0001, 0x69);
    c.bus.write_mem(0x0002, 0x6a);
    c.bus.write_mem(0x0003, 0x6b);
    c.bus.write_mem(0x0004, 0x6c);
    c.bus.write_mem(0x0005, 0x6d);
    c.bus.write_mem(0x0006, 0x6e);
    c.bus.write_mem(0x0007, 0x6f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x11);
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x15);
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x1f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x21);
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x25);
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x25);
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x31);
    c.exec_opcode();
    assert_eq!(c.registers.reg_l, 0x3f);
    assert_eq!(c.registers.reg_pc, 8);
}

#[test]
fn ld_hl_r() {
    let mut c = Cpu::new(None);
    c.registers.reg_b = 0x11;
    c.registers.reg_c = 0x15;
    c.registers.reg_d = 0x1F;
    c.registers.reg_e = 0x21;
    c.registers.reg_h = 0x25;
    c.registers.reg_l = 0x2F;
    c.bus.write_mem(0x2f2f, 0x31);
    c.registers.reg_a = 0x3F;
    c.bus.write_mem(0x0000, 0x70);
    c.bus.write_mem(0x0001, 0x71);
    c.bus.write_mem(0x0002, 0x72);
    c.bus.write_mem(0x0003, 0x73);
    c.bus.write_mem(0x0004, 0x74);
    c.bus.write_mem(0x0005, 0x75);
    c.bus.write_mem(0x0006, 0x77);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x252f), 0x11);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x252f), 0x15);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x252f), 0x1f);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x252f), 0x21);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x252f), 0x25);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x252f), 0x2f);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x252f), 0x3f);
    assert_eq!(c.registers.reg_pc, 7);
}

#[test]
fn ld_a() {
    let mut c = Cpu::new(None);
    c.registers.reg_b = 0x11;
    c.registers.reg_c = 0x15;
    c.registers.reg_d = 0x1F;
    c.registers.reg_e = 0x21;
    c.registers.reg_h = 0x25;
    c.registers.reg_l = 0x2F;
    c.bus.write_mem(0x252f, 0x31);
    c.registers.reg_a = 0x3F;
    c.bus.write_mem(0x0000, 0x78);
    c.bus.write_mem(0x0001, 0x79);
    c.bus.write_mem(0x0002, 0x7a);
    c.bus.write_mem(0x0003, 0x7b);
    c.bus.write_mem(0x0004, 0x7c);
    c.bus.write_mem(0x0005, 0x7d);
    c.bus.write_mem(0x0006, 0x7e);
    c.bus.write_mem(0x0007, 0x7f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x11);
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x15);
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x1f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x21);
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x25);
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x2f);
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x31);
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x31);
    assert_eq!(c.registers.reg_pc, 8);
}

#[test]
fn hlt() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x76);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0);
}

#[test]
fn ld_b_ix_d() {
    let mut c = Cpu::new(None);
    c.registers.set_ix(0x25AF);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x46);
    c.bus.write_mem(0x0002, 0x19);
    c.bus.write_mem(0x25C8, 0x39);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x39);
    assert_eq!(c.registers.reg_pc, 3);
}

#[test]
fn ld_b_iy_d() {
    let mut c = Cpu::new(None);
    c.registers.set_iy(0x25AF);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x46);
    c.bus.write_mem(0x0002, 0x19);
    c.bus.write_mem(0x25C8, 0x39);
    c.exec_opcode();
    assert_eq!(c.registers.reg_b, 0x39);
    assert_eq!(c.registers.reg_pc, 3);
}

#[test]
fn ld_ix_d_c() {
    let mut c = Cpu::new(None);
    c.registers.reg_c = 0x1C;
    c.registers.set_ix(0x3100);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x71);
    c.bus.write_mem(0x0002, 0x06);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x3106), 0x1C);
    assert_eq!(c.registers.reg_pc, 3);
}

#[test]
fn ld_ix_d_n() {
    let mut c = Cpu::new(None);
    c.registers.set_ix(0x219A);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x36);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x0003, 0x5A);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x219F), 0x5A);
    assert_eq!(c.registers.reg_pc, 4);
}

#[test]
fn ld_a_bc() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x0a);
    c.bus.write_mem(0x100, 0x65);
    c.registers.set_bc(0x100);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0x65);
}

#[test]
fn ld_a_de() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x1a);
    c.bus.write_mem(0x100, 0x65);
    c.registers.set_de(0x100);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0x65);
}

#[test]
fn ld_nn_a() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x32);
    c.bus.write_mem(0x0001, 0x00);
    c.bus.write_mem(0x0002, 0xff);
    c.registers.reg_a = 0x56;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0003);
    assert_eq!(c.bus.read_mem(0xff00), 0x56);
}

#[test]
fn ld_a_r() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x5F);
    c.registers.reg_r = 0x56;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0002);
    assert_eq!(c.registers.reg_a, 0x56);
}

#[test]
fn ld_dd_nn() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x21);
    c.bus.write_mem(0x0001, 0x00);
    c.bus.write_mem(0x0002, 0x50);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0003);
    assert_eq!(c.registers.get_hl(), 0x5000);
}

#[test]
fn ld_ix_nn() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x21);
    c.bus.write_mem(0x0002, 0xA2);
    c.bus.write_mem(0x0003, 0x45);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.registers.get_ix(), 0x45A2);
}

#[test]
fn ld_hl_nn() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x2A);
    c.bus.write_mem(0x0001, 0x45);
    c.bus.write_mem(0x0002, 0x45);
    c.bus.write_mem(0x4545, 0x37);
    c.bus.write_mem(0x4546, 0xA1);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0003);
    assert_eq!(c.registers.get_hl(), 0xA137);
}

#[test]
fn ld_bc_cnn() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x4B);
    c.bus.write_mem(0x0002, 0x30);
    c.bus.write_mem(0x0003, 0x21);
    c.bus.write_mem(0x2130, 0x65);
    c.bus.write_mem(0x2131, 0x78);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.registers.get_bc(), 0x7865);
}

#[test]
fn ld_de_cnn() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x5B);
    c.bus.write_mem(0x0002, 0x30);
    c.bus.write_mem(0x0003, 0x21);
    c.bus.write_mem(0x2130, 0x65);
    c.bus.write_mem(0x2131, 0x78);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.registers.get_de(), 0x7865);
}

#[test]
fn ld_hl_cnn() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x6B);
    c.bus.write_mem(0x0002, 0x30);
    c.bus.write_mem(0x0003, 0x21);
    c.bus.write_mem(0x2130, 0x65);
    c.bus.write_mem(0x2131, 0x78);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.registers.get_hl(), 0x7865);
}

#[test]
fn ld_sp_cnn() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x7B);
    c.bus.write_mem(0x0002, 0x30);
    c.bus.write_mem(0x0003, 0x21);
    c.bus.write_mem(0x2130, 0x65);
    c.bus.write_mem(0x2131, 0x78);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.registers.reg_sp, 0x7865);
}

#[test]
fn ld_ix_cnn() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x2A);
    c.bus.write_mem(0x0002, 0x66);
    c.bus.write_mem(0x0003, 0x66);
    c.bus.write_mem(0x6666, 0x92);
    c.bus.write_mem(0x6667, 0xDA);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.registers.get_ix(), 0xDA92);
}

#[test]
fn ld_iy_cnn() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x2A);
    c.bus.write_mem(0x0002, 0x66);
    c.bus.write_mem(0x0003, 0x66);
    c.bus.write_mem(0x6666, 0x92);
    c.bus.write_mem(0x6667, 0xDA);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.registers.get_iy(), 0xDA92);
}

#[test]
fn ld_cnn_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x22);
    c.bus.write_mem(0x0001, 0x29);
    c.bus.write_mem(0x0002, 0xB2);
    c.registers.set_hl(0x483A);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0003);
    assert_eq!(c.bus.read_mem(0xB229), 0x3A);
    assert_eq!(c.bus.read_mem(0xB22A), 0x48);
}

#[test]
fn ld_ann_bc() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x43);
    c.bus.write_mem(0x0002, 0x00);
    c.bus.write_mem(0x0003, 0x10);
    c.registers.set_bc(0x4644);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.bus.read_mem(0x1000), 0x44);
    assert_eq!(c.bus.read_mem(0x1001), 0x46);
}

#[test]
fn ld_ann_de() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x53);
    c.bus.write_mem(0x0002, 0x00);
    c.bus.write_mem(0x0003, 0x10);
    c.registers.set_de(0x4644);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.bus.read_mem(0x1000), 0x44);
    assert_eq!(c.bus.read_mem(0x1001), 0x46);
}

#[test]
fn ld_ann_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x63);
    c.bus.write_mem(0x0002, 0x00);
    c.bus.write_mem(0x0003, 0x10);
    c.registers.set_hl(0x4644);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.bus.read_mem(0x1000), 0x44);
    assert_eq!(c.bus.read_mem(0x1001), 0x46);
}

#[test]
fn ld_ann_sp() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x73);
    c.bus.write_mem(0x0002, 0x00);
    c.bus.write_mem(0x0003, 0x10);
    c.registers.reg_sp = 0x4644;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.bus.read_mem(0x1000), 0x44);
    assert_eq!(c.bus.read_mem(0x1001), 0x46);
}

#[test]
fn ld_ann_ix() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x22);
    c.bus.write_mem(0x0002, 0x38);
    c.bus.write_mem(0x0003, 0x88);
    c.registers.set_ix(0x4174);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.bus.read_mem(0x8838), 0x74);
    assert_eq!(c.bus.read_mem(0x8839), 0x41);
}

#[test]
fn ld_ann_iy() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x22);
    c.bus.write_mem(0x0002, 0x38);
    c.bus.write_mem(0x0003, 0x88);
    c.registers.set_iy(0x4174);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0004);
    assert_eq!(c.bus.read_mem(0x8838), 0x74);
    assert_eq!(c.bus.read_mem(0x8839), 0x41);
}

#[test]
fn ld_sp_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xF9);
    c.registers.reg_h = 0x50;
    c.registers.reg_l = 0x6c;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_sp, 0x506c);
}

#[test]
fn ld_sp_ix() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xF9);
    c.registers.set_ix(0x98DA);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_sp, 0x98DA);
}

#[test]
fn ld_sp_iy() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xF9);
    c.registers.set_iy(0x98DA);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_sp, 0x98DA);
}

#[test]
fn push_af() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xF5);
    c.registers.reg_a = 0x22;
    c.registers.reg_f.from(0x33);
    c.registers.reg_sp = 0x1007;
    assert_eq!(c.registers.reg_f.to_byte(), 0b0011_0011);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_sp, 0x1005);
    assert_eq!(c.bus.read_mem(0x1005), 0x33);
    assert_eq!(c.bus.read_mem(0x1006), 0x22);
    assert_eq!(c.registers.reg_sp, 0x1005);
}

#[test]
fn push_ix() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xE5);
    c.registers.set_ix(0x2233);
    c.registers.reg_sp = 0x1007;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.bus.read_mem(0x1005), 0x33);
    assert_eq!(c.bus.read_mem(0x1006), 0x22);
    assert_eq!(c.registers.reg_sp, 0x1005);
}

#[test]
fn push_iy() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xE5);
    c.registers.set_iy(0x2233);
    c.registers.reg_sp = 0x1007;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.bus.read_mem(0x1005), 0x33);
    assert_eq!(c.bus.read_mem(0x1006), 0x22);
    assert_eq!(c.registers.reg_sp, 0x1005);
}

#[test]
fn pop_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xE1);
    c.bus.write_mem(0x1000, 0x55);
    c.bus.write_mem(0x1001, 0x33);
    c.registers.reg_sp = 0x1000;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.get_hl(), 0x3355);
    assert_eq!(c.registers.reg_sp, 0x1002);
}

#[test]
fn pop_ix() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xE1);
    c.bus.write_mem(0x1000, 0x55);
    c.bus.write_mem(0x1001, 0x33);
    c.registers.reg_sp = 0x1000;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_ix(), 0x3355);
    assert_eq!(c.registers.reg_sp, 0x1002);
}

#[test]
fn pop_iy() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xE1);
    c.bus.write_mem(0x1000, 0x55);
    c.bus.write_mem(0x1001, 0x33);
    c.registers.reg_sp = 0x1000;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_iy(), 0x3355);
    assert_eq!(c.registers.reg_sp, 0x1002);
}

#[test]
fn ex_de_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xEB);
    c.registers.set_de(0x2822);
    c.registers.set_hl(0x499A);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.get_de(), 0x499A);
    assert_eq!(c.registers.get_hl(), 0x2822);
}

#[test]
fn ex_af_afp() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x08);
    c.registers.set_af(0x9900);
    assert_eq!(c.registers.get_af(), 0x9900);
    c.alternate.set_af(0x5944);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.get_af(), 0x5944);
    assert_eq!(c.alternate.get_af(), 0x9900);
}

#[test]
fn exx() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xD9);
    c.registers.set_bc(0x445A);
    c.registers.set_de(0x3DA2);
    c.registers.set_hl(0x8859);
    c.alternate.set_bc(0x0988);
    c.alternate.set_de(0x9300);
    c.alternate.set_hl(0x00E7);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.get_bc(), 0x0988);
    assert_eq!(c.registers.get_de(), 0x9300);
    assert_eq!(c.registers.get_hl(), 0x00E7);
    assert_eq!(c.alternate.get_bc(), 0x445A);
    assert_eq!(c.alternate.get_de(), 0x3DA2);
    assert_eq!(c.alternate.get_hl(), 0x8859);
}

#[test]
fn ex_sp_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xE3);
    c.registers.set_hl(0x7012);
    c.registers.reg_sp = 0x8856;
    c.bus.write_mem(0x8856, 0x11);
    c.bus.write_mem(0x8857, 0x22);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.get_hl(), 0x2211);
    assert_eq!(c.bus.read_mem(0x8856), 0x12);
    assert_eq!(c.bus.read_mem(0x8857), 0x70);
    assert_eq!(c.registers.reg_sp, 0x8856);
}

#[test]
fn ex_sp_ix() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xE3);
    c.registers.set_ix(0x3988);
    c.registers.reg_sp = 0x0100;
    c.bus.write_mem(0x0100, 0x90);
    c.bus.write_mem(0x0101, 0x48);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_ix(), 0x4890);
    assert_eq!(c.bus.read_mem(0x0100), 0x88);
    assert_eq!(c.bus.read_mem(0x0101), 0x39);
    assert_eq!(c.registers.reg_sp, 0x0100);
}

#[test]
fn ex_sp_iy() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xE3);
    c.registers.set_iy(0x3988);
    c.registers.reg_sp = 0x0100;
    c.bus.write_mem(0x0100, 0x90);
    c.bus.write_mem(0x0101, 0x48);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_iy(), 0x4890);
    assert_eq!(c.bus.read_mem(0x0100), 0x88);
    assert_eq!(c.bus.read_mem(0x0101), 0x39);
    assert_eq!(c.registers.reg_sp, 0x0100);
}

#[test]
fn ldi() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0xA0);
    c.registers.set_hl(0x1111);
    c.registers.set_de(0x2222);
    c.registers.set_bc(0x07);
    c.bus.write_mem(0x1111, 0x88);
    c.bus.write_mem(0x2222, 0x66);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_hl(), 0x1112);
    assert_eq!(c.bus.read_mem(0x1111), 0x88);
    assert_eq!(c.registers.get_de(), 0x2223);
    assert_eq!(c.bus.read_mem(0x2222), 0x88);
    assert_eq!(c.registers.get_bc(), 0x06);
}

#[test]
fn ldir() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0xB0);
    c.registers.set_hl(0x1111);
    c.registers.set_de(0x2222);
    c.registers.set_bc(0x0003);
    c.bus.write_mem(0x1111, 0x88);
    c.bus.write_mem(0x2222, 0x66);
    c.bus.write_mem(0x1112, 0x36);
    c.bus.write_mem(0x2223, 0x59);
    c.bus.write_mem(0x1113, 0xA5);
    c.bus.write_mem(0x2224, 0xC5);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_hl(), 0x1114);
    assert_eq!(c.bus.read_mem(0x1111), 0x88);
    assert_eq!(c.bus.read_mem(0x1112), 0x36);
    assert_eq!(c.bus.read_mem(0x1113), 0xA5);
    assert_eq!(c.registers.get_de(), 0x2225);
    assert_eq!(c.bus.read_mem(0x2222), 0x88);
    assert_eq!(c.bus.read_mem(0x2223), 0x36);
    assert_eq!(c.bus.read_mem(0x2224), 0xA5);
    assert_eq!(c.registers.get_bc(), 0x00);
}

#[test]
fn ldd() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0xA8);
    c.registers.set_hl(0x1111);
    c.registers.set_de(0x2222);
    c.registers.set_bc(0x07);
    c.bus.write_mem(0x1111, 0x88);
    c.bus.write_mem(0x2222, 0x66);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_hl(), 0x1110);
    assert_eq!(c.bus.read_mem(0x1111), 0x88);
    assert_eq!(c.registers.get_de(), 0x2221);
    assert_eq!(c.bus.read_mem(0x2222), 0x88);
    assert_eq!(c.registers.get_bc(), 0x06);
}

#[test]
fn lddr() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0xB8);
    c.registers.set_hl(0x1114);
    c.registers.set_de(0x2225);
    c.registers.set_bc(0x0003);
    c.bus.write_mem(0x1112, 0x88);
    c.bus.write_mem(0x2223, 0x66);
    c.bus.write_mem(0x1113, 0x36);
    c.bus.write_mem(0x2224, 0x59);
    c.bus.write_mem(0x1114, 0xA5);
    c.bus.write_mem(0x2225, 0xC5);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_hl(), 0x1111);
    assert_eq!(c.bus.read_mem(0x1112), 0x88);
    assert_eq!(c.bus.read_mem(0x1113), 0x36);
    assert_eq!(c.bus.read_mem(0x1114), 0xA5);
    assert_eq!(c.registers.get_de(), 0x2222);
    assert_eq!(c.bus.read_mem(0x2223), 0x88);
    assert_eq!(c.bus.read_mem(0x2224), 0x36);
    assert_eq!(c.bus.read_mem(0x2225), 0xA5);
    assert_eq!(c.registers.get_bc(), 0x00);
}

#[test]
fn cpi() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0xA1);
    c.registers.reg_a = 0x3B;
    c.registers.set_hl(0x1111);
    c.registers.set_bc(0x01);
    c.bus.write_mem(0x1111, 0x3B);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_hl(), 0x1112);
    assert_eq!(c.registers.get_bc(), 0);
    assert!(c.registers.reg_f.z);
    assert!(!(c.registers.reg_f.p));
}

#[test]
fn cpir() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0xB1);
    c.registers.reg_a = 0xF3;
    c.registers.set_hl(0x1111);
    c.registers.set_bc(0x07);
    c.bus.write_mem(0x1111, 0x52);
    c.bus.write_mem(0x1112, 0x00);
    c.bus.write_mem(0x1113, 0xF3);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_hl(), 0x1114);
    assert_eq!(c.registers.get_bc(), 4);
    assert!(c.registers.reg_f.z);
    assert!(c.registers.reg_f.p);
}

#[test]
fn cpd() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0xA9);
    c.registers.reg_a = 0x3B;
    c.registers.set_hl(0x1111);
    c.registers.set_bc(0x01);
    c.bus.write_mem(0x1111, 0x3B);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_hl(), 0x1110);
    assert_eq!(c.registers.get_bc(), 0);
    assert!(c.registers.reg_f.z);
    assert!(!(c.registers.reg_f.p));
}

#[test]
fn cpdr() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0xB9);
    c.registers.reg_a = 0xF3;
    c.registers.set_hl(0x1118);
    c.registers.set_bc(0x07);
    c.bus.write_mem(0x1116, 0xF3);
    c.bus.write_mem(0x1117, 0x00);
    c.bus.write_mem(0x1118, 0x52);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_hl(), 0x1115);
    assert_eq!(c.registers.get_bc(), 4);
    assert!(c.registers.reg_f.z);
    assert!(c.registers.reg_f.p);
}

#[test]
fn add_a_r() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x81);
    c.registers.reg_a = 0x44;
    c.registers.reg_c = 0x11;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0x55);
}

#[test]
fn add_a_n() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xC6);
    c.bus.write_mem(0x0001, 0x33);
    c.registers.reg_a = 0x23;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_a, 0x56);
}

#[test]
fn add_a_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x86);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x22);
    c.registers.reg_a = 0x11;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x33);
}

#[test]
fn add_a_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x86);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x22);
    c.registers.reg_a = 0x11;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x33);
}

#[test]
fn addc_a_r() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x8E);
    c.bus.write_mem(0x6666, 0x10);
    c.registers.reg_a = 0x16;
    c.registers.reg_f.c = true;
    c.registers.set_hl(0x6666);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0x27);
}

#[test]
fn addc_a_n() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCE);
    c.bus.write_mem(0x0001, 0x10);
    c.registers.reg_a = 0x16;
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_a, 0x27);
}

#[test]
fn sub_r() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x92);
    c.registers.reg_a = 0x29;
    c.registers.reg_d = 0x11;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0x18);
}

#[test]
fn sub_a_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x96);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x22);
    c.registers.reg_a = 0x63;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x41);
}

#[test]
fn sub_a_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x96);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x22);
    c.registers.reg_a = 0x63;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x41);
}

#[test]
fn sbc_a_r() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x9E);
    c.bus.write_mem(0x3433, 0x05);
    c.registers.reg_a = 0x16;
    c.registers.set_hl(0x3433);
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0x10);
}

#[test]
fn sbc_a_r_ovf() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x9E);
    c.bus.write_mem(0x3433, 0x01);
    c.registers.reg_a = 0x80;
    c.registers.set_hl(0x3433);
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0x7E);
    assert!(c.registers.reg_f.p);
}

#[test]
fn sbc_a_n() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDE);
    c.bus.write_mem(0x0001, 0x05);
    c.registers.reg_a = 0x16;
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_a, 0x10);
}

#[test]
fn sbc_a_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x9E);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x22);
    c.registers.reg_a = 0x63;
    c.registers.reg_f.c = true;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x40);
}

#[test]
fn sbc_a_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x9E);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x22);
    c.registers.reg_a = 0x63;
    c.registers.reg_f.c = true;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x40);
}

#[test]
fn and_r() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xA0);
    c.registers.reg_a = 0xC3;
    c.registers.reg_b = 0x7B;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0x43);
}

#[test]
fn and_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xA6);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x7B);
    c.registers.reg_a = 0xC3;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x43);
}

#[test]
fn and_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xA6);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x7B);
    c.registers.reg_a = 0xC3;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x43);
}

#[test]
fn or_r() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xB4);
    c.registers.reg_a = 0x12;
    c.registers.reg_h = 0x48;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0x5A);
}

#[test]
fn or_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xB6);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x48);
    c.registers.reg_a = 0x12;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x5A);
}

#[test]
fn or_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xB6);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x48);
    c.registers.reg_a = 0x12;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0x5A);
}

#[test]
fn xor_n() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xEE);
    c.bus.write_mem(0x0001, 0x5D);
    c.registers.reg_a = 0x96;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_a, 0xCB);
}

#[test]
fn xor_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xAE);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x5D);
    c.registers.reg_a = 0x96;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0xCB);
}

#[test]
fn xor_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xAE);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x5D);
    c.registers.reg_a = 0x96;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert_eq!(c.registers.reg_a, 0xCB);
}

#[test]
fn cp_r() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xBB);
    c.registers.reg_a = 0x0A;
    c.registers.reg_e = 0x05;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert!(!(c.registers.reg_f.z));
    assert!(!(c.registers.reg_f.c));
}

#[test]
fn cp_n() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFE);
    c.bus.write_mem(0x0001, 0x05);
    c.registers.reg_a = 0x0A;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert!(!(c.registers.reg_f.z));
    assert!(!(c.registers.reg_f.c));
}

#[test]
fn cp_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xBE);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x05);
    c.registers.reg_a = 0x0A;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert!(!(c.registers.reg_f.z));
    assert!(!(c.registers.reg_f.c));
}

#[test]
fn cp_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xBE);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x1005, 0x05);
    c.registers.reg_a = 0x0A;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 3);
    assert!(!(c.registers.reg_f.z));
    assert!(!(c.registers.reg_f.c));
}

#[test]
fn inc_b() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x04);
    c.registers.reg_b = 0xff;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0001);
    assert_eq!(0, c.registers.reg_b);
    assert!(c.registers.reg_f.z);
}

#[test]
fn inc_c() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x0C);
    c.registers.reg_c = 0xff;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0001);
    assert_eq!(0, c.registers.reg_c);
    assert!(c.registers.reg_f.z);
}

#[test]
fn inc_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x14);
    c.registers.reg_d = 0xff;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0001);
    assert_eq!(0, c.registers.reg_d);
    assert!(c.registers.reg_f.z);
}

#[test]
fn inc_e() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x1C);
    c.registers.reg_e = 0xff;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0001);
    assert_eq!(0, c.registers.reg_e);
    assert!(c.registers.reg_f.z);
}

#[test]
fn inc_h() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x24);
    c.registers.reg_h = 0xff;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0001);
    assert_eq!(0, c.registers.reg_h);
    assert!(c.registers.reg_f.z);
}

#[test]
fn inc_l() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x2C);
    c.registers.reg_l = 0xff;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0001);
    assert_eq!(0, c.registers.reg_l);
    assert!(c.registers.reg_f.z);
}

#[test]
fn inc_c_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x34);
    c.bus.write_mem(0x0001, 0x34);
    c.bus.write_mem(0x100, 0xff);
    c.registers.set_hl(0x100);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0001);
    assert_eq!(0, c.bus.read_mem(0x100));
    assert!(c.registers.reg_f.z);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0002);
    assert_eq!(1, c.bus.read_mem(0x100));
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn inc_a() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x3C);
    c.registers.reg_a = 0x0f;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0001);
    assert_eq!(0x10, c.registers.reg_a);
    assert!(!(c.registers.reg_f.z));
    assert!(c.registers.reg_f.h);
}

#[test]
fn inc_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x34);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x105, 0xff);
    c.registers.set_ix(0x100);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x03);
    assert_eq!(0, c.bus.read_mem(0x105));
    assert!(c.registers.reg_f.z);
}

#[test]
fn inc_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x34);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x105, 0xff);
    c.registers.set_iy(0x100);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x03);
    assert_eq!(0, c.bus.read_mem(0x105));
    assert!(c.registers.reg_f.z);
}

#[test]
fn dcr_b() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x05);
    c.bus.write_mem(0x0001, 0x05);
    c.registers.reg_b = 0x01;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(0, c.registers.reg_b);
    assert!(c.registers.reg_f.z);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(0xff, c.registers.reg_b);
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn dcr_c() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x0d);
    c.bus.write_mem(0x0001, 0x0d);
    c.registers.reg_c = 0x01;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(0, c.registers.reg_c);
    assert!(c.registers.reg_f.z);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(0xff, c.registers.reg_c);
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn dcr_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x15);
    c.bus.write_mem(0x0001, 0x15);
    c.registers.reg_d = 0x01;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(0, c.registers.reg_d);
    assert!(c.registers.reg_f.z);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(0xff, c.registers.reg_d);
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn dcr_e() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x1d);
    c.bus.write_mem(0x0001, 0x1d);
    c.registers.reg_e = 0x01;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(0, c.registers.reg_e);
    assert!(c.registers.reg_f.z);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(0xff, c.registers.reg_e);
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn dcr_h() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x25);
    c.bus.write_mem(0x0001, 0x25);
    c.registers.reg_h = 0x01;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(0, c.registers.reg_h);
    assert!(c.registers.reg_f.z);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(0xff, c.registers.reg_h);
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn dcr_l() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x2d);
    c.bus.write_mem(0x0001, 0x2d);
    c.registers.reg_l = 0x01;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(0, c.registers.reg_l);
    assert!(c.registers.reg_f.z);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(0xff, c.registers.reg_l);
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn dcr_m() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x35);
    c.bus.write_mem(0x0001, 0x35);
    c.bus.write_mem(0x100, 0x55);
    c.registers.set_hl(0x0100);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(0x54, c.bus.read_mem(0x0100));
    assert!(!(c.registers.reg_f.z));
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(0x53, c.bus.read_mem(0x0100));
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn dcr_a() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x3d);
    c.bus.write_mem(0x0001, 0x3d);
    c.registers.reg_a = 0x01;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(0, c.registers.reg_a);
    assert!(c.registers.reg_f.z);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(0xff, c.registers.reg_a);
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn dec_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x35);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x105, 0xff);
    c.registers.set_ix(0x100);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x03);
    assert_eq!(0xFE, c.bus.read_mem(0x105));
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn dec_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x35);
    c.bus.write_mem(0x0002, 0x05);
    c.bus.write_mem(0x105, 0xff);
    c.registers.set_iy(0x100);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x03);
    assert_eq!(0xFE, c.bus.read_mem(0x105));
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn daa() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x27);
    c.registers.reg_a = 0x9B;
    c.registers.reg_f.h = false;
    c.registers.reg_f.c = false;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 1);
    assert!(c.registers.reg_f.h);
    assert!(c.registers.reg_f.c);
}

#[test]
fn neg_doc() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x44);
    c.registers.reg_a = 0b1001_1000;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(0b0110_1000, c.registers.reg_a);
}

#[test]
fn neg_asm() {
    let mut c = Cpu::new(None);
    load_bin("tests/neg.bin", &mut c.bus.ram, 0).unwrap();
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x01); // LD A,0x01
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0xFF);
    assert_eq!(c.registers.reg_f.to_byte(), YF | XF | SF | HF | NF | CF); // NEG
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x00);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | HF | CF); // ADD A,0x01
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x00);
    assert_eq!(c.registers.reg_f.to_byte(), ZF | NF); // NEG
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x80);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | NF | CF); // SUB A,0x80
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x80);
    assert_eq!(c.registers.reg_f.to_byte(), SF | PF | NF | CF); // NEG
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0xC0);
    assert_eq!(c.registers.reg_f.to_byte(), SF); // ADD A,0x40
    c.exec_opcode();
    assert_eq!(c.registers.reg_a, 0x40);
    assert_eq!(c.registers.reg_f.to_byte(), NF | CF); // NEG
}

#[test]
fn ccf() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x3f);
    c.bus.write_mem(0x0001, 0x3f);
    c.exec_opcode();
    assert!(c.registers.reg_f.c);
    assert_eq!(c.registers.reg_pc, 0x0001);
    c.exec_opcode();
    assert!(!(c.registers.reg_f.c));
    assert_eq!(c.registers.reg_pc, 0x0002);
}

#[test]
fn scf() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x37);
    c.bus.write_mem(0x0001, 0x37);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0001);
    assert!(c.registers.reg_f.c);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0002);
    assert!(c.registers.reg_f.c);
}

#[test]
fn add_hl_b() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x09);
    c.registers.set_bc(0x339F);
    c.registers.set_hl(0xA17B);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0xD5);
    assert_eq!(c.registers.reg_l, 0x1A);
    assert!(!(c.registers.reg_f.c));
    assert_eq!(c.registers.reg_pc, 1);
}

#[test]
fn add_hl_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x19);
    c.registers.set_de(0x339F);
    c.registers.set_hl(0xA17B);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0xD5);
    assert_eq!(c.registers.reg_l, 0x1A);
    assert!(!(c.registers.reg_f.c));
    assert_eq!(c.registers.reg_pc, 1);
}

#[test]
fn add_hl_h() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x29);
    c.registers.set_hl(0x339F);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x67);
    assert_eq!(c.registers.reg_l, 0x3e);
    assert!(!(c.registers.reg_f.c));
    assert_eq!(c.registers.reg_pc, 1);
}

#[test]
fn add_hl_sp() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x39);
    c.registers.reg_sp = 0x339F;
    c.registers.set_hl(0xA17B);
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0xD5);
    assert_eq!(c.registers.reg_l, 0x1A);
    assert!(!(c.registers.reg_f.c));
    assert_eq!(c.registers.reg_pc, 1);
}

#[test]
fn adc_hl_b() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x4A);
    c.registers.set_bc(0x2222);
    c.registers.set_hl(0x5437);
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x76);
    assert_eq!(c.registers.reg_l, 0x5A);
    assert_eq!(c.registers.reg_pc, 2);
}

#[test]
fn adc_hl_d_ovf() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x5A);
    c.registers.set_de(0x7FF0);
    c.registers.set_hl(0x000F);
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x80);
    assert_eq!(c.registers.reg_l, 0x00);
    assert_eq!(c.registers.reg_pc, 2);
    assert!(c.registers.reg_f.p);
}

#[test]
fn adc_hl_h_ovf() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x6A);
    c.registers.set_hl(0x000F);
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x00);
    assert_eq!(c.registers.reg_l, 0x1F);
    assert_eq!(c.registers.reg_pc, 2);
    assert!(!(c.registers.reg_f.p));
}

#[test]
fn adc_hl_sp_ovf() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x7A);
    c.registers.set_hl(0x7FF0);
    c.registers.reg_sp = 0x000F;
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x80);
    assert_eq!(c.registers.reg_l, 0x00);
    assert_eq!(c.registers.reg_pc, 2);
    assert!(c.registers.reg_f.p);
}

#[test]
fn sbc_hl_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x52);
    c.registers.set_hl(0x9999);
    c.registers.set_de(0x1111);
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_h, 0x88);
    assert_eq!(c.registers.reg_l, 0x87);
    assert_eq!(c.registers.reg_pc, 2);
}

#[test]
fn add_ix_bc() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x09);
    c.registers.set_ix(0x3333);
    c.registers.set_bc(0x5555);
    c.exec_opcode();
    assert_eq!(c.registers.get_ix(), 0x8888);
    assert_eq!(c.registers.reg_pc, 2);
}

#[test]
fn add_iy_bc() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x09);
    c.registers.set_iy(0x3333);
    c.registers.set_bc(0x5555);
    c.exec_opcode();
    assert_eq!(c.registers.get_iy(), 0x8888);
    assert_eq!(c.registers.reg_pc, 2);
}

#[test]
fn inc_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x23);
    c.registers.set_hl(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.get_hl(), 0x1001);
}

#[test]
fn inc_ix() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x23);
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_ix(), 0x1001);
}

#[test]
fn inc_iy() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x23);
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_iy(), 0x1001);
}

#[test]
fn dec_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x2B);
    c.registers.set_hl(0x1001);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.get_hl(), 0x1000);
}

#[test]
fn dec_ix() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0x2B);
    c.registers.set_ix(0x2006);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_ix(), 0x2005);
}

#[test]
fn dec_iy() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0x2B);
    c.registers.set_iy(0x2006);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.get_iy(), 0x2005);
}

#[test]
fn rlca() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x07);
    c.registers.reg_a = 0b1000_1000;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0b0001_0001);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rla() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x17);
    c.registers.reg_a = 0b0111_0110;
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0b1110_1101);
    assert!(!(c.registers.reg_f.c));
}

#[test]
fn rrca() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x0F);
    c.registers.reg_a = 0b0001_0001;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0b1000_1000);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rra() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0x1F);
    c.registers.reg_a = 0b1110_0001;
    c.registers.reg_f.c = false;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 1);
    assert_eq!(c.registers.reg_a, 0b0111_0000);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rlc_a() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0x07);
    c.registers.reg_a = 0b1000_1000;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_a, 0b0001_0001);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rlc_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0x06);
    c.bus.write_mem(0x2828, 0b1000_1000);
    c.registers.set_hl(0x2828);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.bus.read_mem(0x2828), 0b0001_0001);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rlc_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x06);
    c.bus.write_mem(0x1002, 0b1000_1000);
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b0001_0001);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rlc_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x06);
    c.bus.write_mem(0x1002, 0b1000_1000);
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b0001_0001);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rl_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0x12);
    c.registers.reg_d = 0b1000_1111;
    c.registers.reg_f.c = false;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_d, 0b0001_1110);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rl_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x16);
    c.bus.write_mem(0x1002, 0b1000_1111);
    c.registers.reg_f.c = false;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b0001_1110);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rl_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x16);
    c.bus.write_mem(0x1002, 0b1000_1111);
    c.registers.reg_f.c = false;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b0001_1110);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rrc_a() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0x0F);
    c.registers.reg_a = 0b0011_0001;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_a, 0b1001_1000);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rrc_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x0E);
    c.bus.write_mem(0x1002, 0b0011_0001);
    c.registers.reg_f.c = false;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b1001_1000);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rrc_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x0E);
    c.bus.write_mem(0x1002, 0b0011_0001);
    c.registers.reg_f.c = false;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b1001_1000);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rr_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0x1E);
    c.bus.write_mem(0x4343, 0b1101_1101);
    c.registers.set_hl(0x4343);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.bus.read_mem(0x4343), 0b0110_1110);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rr_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x1E);
    c.bus.write_mem(0x1002, 0b1101_1101);
    c.registers.reg_f.c = false;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b0110_1110);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rr_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x1E);
    c.bus.write_mem(0x1002, 0b1101_1101);
    c.registers.reg_f.c = false;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b0110_1110);
    assert!(c.registers.reg_f.c);
}

#[test]
fn sla_l() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0x25);
    c.registers.reg_l = 0b1011_0001;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_l, 0b0110_0010);
    assert!(c.registers.reg_f.c);
}

#[test]
fn sla_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x26);
    c.bus.write_mem(0x1002, 0b1011_0001);
    c.registers.reg_f.c = false;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b0110_0010);
    assert!(c.registers.reg_f.c);
}

#[test]
fn sla_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x26);
    c.bus.write_mem(0x1002, 0b1011_0001);
    c.registers.reg_f.c = false;
    c.registers.set_iy(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b0110_0010);
    assert!(c.registers.reg_f.c);
}

#[test]
fn sra_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x02);
    c.bus.write_mem(0x0003, 0x2E);
    c.bus.write_mem(0x1002, 0b1011_1000);
    c.registers.reg_f.c = false;
    c.registers.set_ix(0x1000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x1002), 0b1101_1100);
    assert!(!(c.registers.reg_f.c));
}

#[test]
fn srl_b() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0x38);
    c.registers.reg_b = 0b1000_1111;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_b, 0b0100_0111);
    assert!(c.registers.reg_f.c);
}

#[test]
fn rld() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x6F);
    c.bus.write_mem(0x5000, 0b0011_0001);
    c.registers.set_hl(0x5000);
    c.registers.reg_a = 0b0111_1010;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_a, 0b0111_0011);
    assert_eq!(c.bus.read_mem(0x5000), 0b0001_1010);
}

#[test]
fn rrd() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xED);
    c.bus.write_mem(0x0001, 0x67);
    c.bus.write_mem(0x5000, 0b0010_0000);
    c.registers.set_hl(0x5000);
    c.registers.reg_a = 0b1000_0100;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_a, 0b1000_0000);
    assert_eq!(c.bus.read_mem(0x5000), 0b0100_0010);
}

#[test]
fn bit_4_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0x66);
    c.bus.write_mem(0x4444, 0x10);
    c.registers.set_hl(0x4444);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert!(!(c.registers.reg_f.z));
    assert_eq!(c.bus.read_mem(0x4444), 0x10);
}

#[test]
fn bit_6_ix_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x04);
    c.bus.write_mem(0x0003, 0x76);
    c.bus.write_mem(0x2004, 0x40);
    c.registers.set_ix(0x2000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x2004), 0x40);
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn bit_6_iy_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x04);
    c.bus.write_mem(0x0003, 0x76);
    c.bus.write_mem(0x2004, 0x40);
    c.registers.set_iy(0x2000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x2004), 0x40);
    assert!(!(c.registers.reg_f.z));
}

#[test]
fn set_4_a() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0xE7);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_a, 0x10);
}

#[test]
fn set_4_hl() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0xE6);
    c.registers.set_hl(0x4444);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.bus.read_mem(0x4444), 0x10);
}

#[test]
fn set_0_ix() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x03);
    c.bus.write_mem(0x0003, 0xC6);
    c.registers.set_ix(0x2000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x2003), 0x01);
}

#[test]
fn set_0_iy() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x03);
    c.bus.write_mem(0x0003, 0xC6);
    c.registers.set_iy(0x2000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x2003), 0x01);
}

#[test]
fn res_6_d() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xCB);
    c.bus.write_mem(0x0001, 0xB2);
    c.registers.reg_d = 0xFF;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 2);
    assert_eq!(c.registers.reg_d, 0xBF);
}

#[test]
fn reset_0_ix() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xDD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x03);
    c.bus.write_mem(0x0003, 0xB6);
    c.bus.write_mem(0x2003, 0xFF);
    c.registers.set_ix(0x2000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x2003), 0xBF);
}

#[test]
fn reset_0_iy() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xFD);
    c.bus.write_mem(0x0001, 0xCB);
    c.bus.write_mem(0x0002, 0x03);
    c.bus.write_mem(0x0003, 0xB6);
    c.bus.write_mem(0x2003, 0xFF);
    c.registers.set_iy(0x2000);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 4);
    assert_eq!(c.bus.read_mem(0x2003), 0xBF);
}

#[test]
fn jp() {
    let mut c = Cpu::new(None);
    c.bus.write_mem(0x0000, 0xC3);
    c.bus.write_mem(0x0001, 0x00);
    c.bus.write_mem(0x0002, 0x3E);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x3e00);
}

#[test]
fn jr() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x0480;
    c.bus.write_mem(0x0480, 0x18);
    c.bus.write_mem(0x0481, 0x03);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0485);
}

#[test]
fn jr_neg() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x0480;
    c.bus.write_mem(0x0480, 0x18);
    c.bus.write_mem(0x0481, 0xFA);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x047C);
}

#[test]
fn jr_c_e() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x0480;
    c.bus.write_mem(0x0480, 0x38);
    c.bus.write_mem(0x0481, 0xFA);
    c.registers.reg_f.c = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x047C);
}

#[test]
fn jr_nc_e() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x0480;
    c.bus.write_mem(0x0480, 0x30);
    c.bus.write_mem(0x0481, 0xFA);
    c.registers.reg_f.c = false;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x047C);
}

#[test]
fn jr_z_e() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x0300;
    c.bus.write_mem(0x0300, 0x28);
    c.bus.write_mem(0x0301, 0x03);
    c.registers.reg_f.z = true;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0305);
}

#[test]
fn jr_nz_e() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x0480;
    c.bus.write_mem(0x0480, 0x20);
    c.bus.write_mem(0x0481, 0xFA);
    c.registers.reg_f.z = false;
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x047C);
}

#[test]
fn jp_hl() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x1000;
    c.bus.write_mem(0x1000, 0xE9);
    c.registers.set_hl(0x4800);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x4800);
}

#[test]
fn jp_ix() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x1000;
    c.bus.write_mem(0x1000, 0xDD);
    c.bus.write_mem(0x1001, 0xE9);
    c.registers.set_ix(0x4800);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x4800);
}

#[test]
fn jp_iy() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x1000;
    c.bus.write_mem(0x1000, 0xFD);
    c.bus.write_mem(0x1001, 0xE9);
    c.registers.set_iy(0x4800);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x4800);
}

#[test]
fn call_nn() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x1A47;
    c.registers.reg_sp = 0x3002;
    c.bus.write_mem(0x1A47, 0xCD);
    c.bus.write_mem(0x1A48, 0x35);
    c.bus.write_mem(0x1A49, 0x21);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x3001), 0x1A);
    assert_eq!(c.bus.read_mem(0x3000), 0x4A);
    assert_eq!(c.registers.reg_sp, 0x3000);
    assert_eq!(c.registers.reg_pc, 0x2135);
}

#[test]
fn call_cc_nn() {
    let mut c = Cpu::new(None);
    c.registers.reg_f.c = false;
    c.registers.reg_pc = 0x1A47;
    c.registers.reg_sp = 0x3002;
    c.bus.write_mem(0x1A47, 0xD4);
    c.bus.write_mem(0x1A48, 0x35);
    c.bus.write_mem(0x1A49, 0x21);
    c.exec_opcode();
    assert_eq!(c.bus.read_mem(0x3001), 0x1A);
    assert_eq!(c.bus.read_mem(0x3000), 0x4A);
    assert_eq!(c.registers.reg_sp, 0x3000);
    assert_eq!(c.registers.reg_pc, 0x2135);
}

#[test]
fn ret() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x3535;
    c.registers.reg_sp = 0x2000;
    c.bus.write_mem(0x3535, 0xC9);
    c.bus.write_mem(0x2000, 0xB5);
    c.bus.write_mem(0x2001, 0x18);
    c.exec_opcode();
    assert_eq!(c.registers.reg_sp, 0x2002);
    assert_eq!(c.registers.reg_pc, 0x18B5);
}

#[test]
fn ret_cc() {
    let mut c = Cpu::new(None);
    c.registers.reg_f.s = true;
    c.registers.reg_pc = 0x3535;
    c.registers.reg_sp = 0x2000;
    c.bus.write_mem(0x3535, 0xF8);
    c.bus.write_mem(0x2000, 0xB5);
    c.bus.write_mem(0x2001, 0x18);
    c.exec_opcode();
    assert_eq!(c.registers.reg_sp, 0x2002);
    assert_eq!(c.registers.reg_pc, 0x18B5);
}

#[test]
fn rst() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x15B3;
    c.bus.write_mem(0x15B3, 0xDF);
    c.exec_opcode();
    assert_eq!(c.registers.reg_pc, 0x0018);
}

#[test]
fn jr_nz_neg() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x0274;
    c.bus.write_mem(0x0274, 0x0E); // LD C,$08
    c.bus.write_mem(0x0275, 0x08);
    c.bus.write_mem(0x0276, 0x0D); // DEC C
    c.bus.write_mem(0x0277, 0x20); // JR NZ,$F2
    c.bus.write_mem(0x0278, 0xF2);
    for _ in 0..3 {
        c.exec_opcode();
    }
    assert_eq!(c.registers.reg_pc, 0x026B);
}

#[test]
fn jr_nz_neg_false() {
    let mut c = Cpu::new(None);
    c.registers.reg_pc = 0x0274;
    c.bus.write_mem(0x0274, 0x0E); // LD C,$08
    c.bus.write_mem(0x0275, 0x01);
    c.bus.write_mem(0x0276, 0x0D); // DEC C
    c.bus.write_mem(0x0277, 0x20); // JR NZ,$F2
    c.bus.write_mem(0x0278, 0xF2);
    for _ in 0..3 {
        c.exec_opcode();
    }
    assert_eq!(c.registers.reg_pc, 0x0279);
}

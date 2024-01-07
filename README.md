# JPEG_Encoder
Simple implementation of a JPEG Encoder in RISC-V Assembly

## Problems:
According to [riscv-asm-manual](https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md), the assembly has the following problem:

The following code in `main_fp_sample.asm` has problem:
```asm
# macro to terminate the simualtion
.macro exit ()
.text
li a7,10
ecall
.end_macro
```

There's no `end_macro` in according to manual, thus we need to need to modify these non-compliant expressions.


## To object file
Since the assmebly writes with mul instruction, using the `M` extension is necessary while generating object file.
Note that we're using `riscv-none-elf-as` for assembler
```bash
$ riscv-none-elf-as -march=rv32i -mabi=ilp32 dct_r.asm -o dct_r.o                                                                                            
dct_r.asm: Assembler messages:
dct_r.asm:59: Error: unrecognized opcode `mul s0,s11,s4', extension `m' or `zmmul' required
dct_r.asm:61: Error: unrecognized opcode `mul s1,s1,s5', extension `m' or `zmmul' required
dct_r.asm:62: Error: unrecognized opcode `mul s2,t5,s6', extension `m' or `zmmul' required
dct_r.asm:64: Error: unrecognized opcode `mul s3,t6,s4', extension `m' or `zmmul' required
dct_r.asm:65: Error: unrecognized opcode `mul s4,s10,s8', extension `m' or `zmmul' required

$ riscv-none-elf-as -march=rv32i -mabi=ilp32 dct_r.asm -o dct_r.o
```

After generating object file, we can use instruction provided by `GNU toolchain` to observer our disassembly object file.

```bash
$ riscv-none-elf-objdump -d dct_r.o
dct_r.o:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <dct_r>:
   0:   ffc10113                add     sp,sp,-4
   4:   00112023                sw      ra,0(sp)
   8:   00800293                li      t0,8
   c:   00050c93                mv      s9,a0
  10:   00058893                mv      a7,a1

00000014 <loop>:
  14:   14028663                beqz    t0,160 <return>
  18:   000ca303                lw      t1,0(s9)
  1c:   004ca383                lw      t2,4(s9)
  20:   008cae03                lw      t3,8(s9)
  24:   00ccae83                lw      t4,12(s9)
  28:   010caf03                lw      t5,16(s9)
  2c:   014caf83                lw      t6,20(s9)
  30:   018cad03                lw      s10,24(s9)
  34:   01ccad83                lw      s11,28(s9)
  38:   01b30433                add     s0,t1,s11
  3c:   01a384b3                add     s1,t2,s10
  40:   01fe0933                add     s2,t3,t6
  44:   01ee89b3                add     s3,t4,t5
  48:   41ee8a33                sub     s4,t4,t5
  4c:   41fe0ab3                sub     s5,t3,t6
  50:   41a38b33                sub     s6,t2,s10
  54:   41b30bb3                sub     s7,t1,s11
  58:   01340333                add     t1,s0,s3
  5c:   012483b3                add     t2,s1,s2
  60:   41248e33                sub     t3,s1,s2
  64:   41340eb3                sub     t4,s0,s3
  68:   015a0f33                add     t5,s4,s5
  6c:   016a8fb3                add     t6,s5,s6
  70:   017b0d33                add     s10,s6,s7
  74:   01de0db3                add     s11,t3,t4
  78:   02d00a13                li      s4,45
  7c:   008a1a13                sll     s4,s4,0x8
  80:   041a0a13                add     s4,s4,65
  84:   01800a93                li      s5,24
  88:   008a9a93                sll     s5,s5,0x8
  8c:   07ea8a93                add     s5,s5,126
  90:   02200b13                li      s6,34
  94:   008b1b13                sll     s6,s6,0x8
  98:   0a3b0b13                add     s6,s6,163
  9c:   05300c13                li      s8,83
  a0:   008c1c13                sll     s8,s8,0x8
  a4:   09fc0c13                add     s8,s8,159
  a8:   034d8433                mul     s0,s11,s4
  ac:   41ed04b3                sub     s1,s10,t5
  b0:   035484b3                mul     s1,s1,s5
  b4:   036f0933                mul     s2,t5,s6
  b8:   40990933                sub     s2,s2,s1
  bc:   034f89b3                mul     s3,t6,s4
  c0:   038d0a33                mul     s4,s10,s8
  c4:   409a0a33                sub     s4,s4,s1
  c8:   00eb9b93                sll     s7,s7,0xe
  cc:   013b8e33                add     t3,s7,s3
  d0:   413b8f33                sub     t5,s7,s3
  d4:   00730fb3                add     t6,t1,t2
  d8:   01f8a023                sw      t6,0(a7)
  dc:   40730fb3                sub     t6,t1,t2
  e0:   01f8a823                sw      t6,16(a7)
  e4:   02000d13                li      s10,32
  e8:   008d1d13                sll     s10,s10,0x8
  ec:   00ee9313                sll     t1,t4,0xe
  f0:   008303b3                add     t2,t1,s0
  f4:   01a383b3                add     t2,t2,s10
  f8:   40e3d393                sra     t2,t2,0xe
  fc:   0078a423                sw      t2,8(a7)
 100:   408303b3                sub     t2,t1,s0
 104:   01a383b3                add     t2,t2,s10
 108:   40e3d393                sra     t2,t2,0xe
 10c:   0078ac23                sw      t2,24(a7)
 110:   012f03b3                add     t2,t5,s2
 114:   01a383b3                add     t2,t2,s10
 118:   40e3d393                sra     t2,t2,0xe
 11c:   0078aa23                sw      t2,20(a7)
 120:   014e03b3                add     t2,t3,s4
 124:   01a383b3                add     t2,t2,s10
 128:   40e3d393                sra     t2,t2,0xe
 12c:   0078a223                sw      t2,4(a7)
 130:   414e03b3                sub     t2,t3,s4
 134:   01a383b3                add     t2,t2,s10
 138:   40e3d393                sra     t2,t2,0xe
 13c:   0078ae23                sw      t2,28(a7)
 140:   412f03b3                sub     t2,t5,s2
 144:   01a383b3                add     t2,t2,s10
 148:   40e3d393                sra     t2,t2,0xe
 14c:   0078a623                sw      t2,12(a7)
 150:   020c8c93                add     s9,s9,32
 154:   02088893                add     a7,a7,32
 158:   fff28293                add     t0,t0,-1
 15c:   eb9ff06f                j       14 <loop>

00000160 <return>:
 160:   00012083                lw      ra,0(sp)
 164:   00410113                add     sp,sp,4
 168:   00008067                ret

```



## Makefile
In order to compile this program efficiently, a Makefile is needed (TODO)
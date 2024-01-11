    .equ STDOUT, 1
    .equ WRITE, 64
    .equ EXIT, 93

    .section .rodata
    .align 2
msg:
    .ascii "RISC-V\n"

    .section .text
    .align 2

    .globl  _start
pussy:
    .ascii "Pussy\n"
    .section .text
    .align 2
    .globl _start

.macro custom_write_string fd, str, length
    li a0, \fd
    la a1, \str
    li a2, \length
    li a7, WRITE
    ecall
.endm

_start:
    li a0, STDOUT  # file descriptor
    la a1, pussy     # address of string
    li a2, 7       # length of string
    li a7, WRITE   # syscall number for write
    ecall
    custom_write_string STDOUT, pussy, 6

    # MISSING: Check for error condition
    li a0, 0       # 0 signals success
    li a7, EXIT
    ecall
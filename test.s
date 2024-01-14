	.file	"test.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_a2p1_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"current tick: %ld"
	.text
	.align	1
	.globl	gettime
	.type	gettime, @function
gettime:
	addi	sp,sp,-32
	mv	a1,sp
	li	a0,0
	sw	ra,28(sp)
	call	clock_gettime
	lw	a1,8(sp)
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	printf
	lw	ra,28(sp)
	lw	a0,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	gettime, .-gettime
	.section	.rodata.str1.4
	.align	2
.LC1:
	.string	"%d"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	s1,4(sp)
	li	s1,4096
	sw	s0,8(sp)
	sw	s2,0(sp)
	sw	ra,12(sp)
	li	s0,0
	lui	s2,%hi(.LC1)
	addi	s1,s1,-296
.L5:
	mv	a1,s0
	addi	a0,s2,%lo(.LC1)
	addi	s0,s0,38
	call	printf
	bne	s0,s1,.L5
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	lw	s2,0(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 13.2.0"

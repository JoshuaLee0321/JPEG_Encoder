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
	sw	ra,28(sp)
	mv	a1,sp
	li	a0,0
	call	clock_gettime
	lw	a1,8(sp)
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	printf
	lw	a0,8(sp)
	lw	ra,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	gettime, .-gettime
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	call	gettime
	li	a0,0
	lw	ra,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 13.2.0"

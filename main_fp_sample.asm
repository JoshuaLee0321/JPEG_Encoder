    .equ STDOUT, 1
    .equ WRITE, 64
    .equ EXIT, 93
	.equ CLKGET, 403
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_a2p1_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	2
.LC0:
	.string	"%d"
	.text
	.align	1
	.globl	main
	.type	main, @function
.LC1:
	.string	"current tick: %ld\n\n"
	.text
	.align	1
	.globl	gettime
	.type	gettime, @function
.data
space : .asciz " "
comma : .asciz ","
line_ascii:
	 .ascii "\n\n"
	 .align 2
comma_ascii:
	 .ascii ","
	 .align 2
# string section 
elapse_cycle_text:
	.ascii "\tcycle elapsed: "
	.align 2
rgb2y_text:
    .ascii "rgb2y:\n"
    .align 2
dct_c_text:
	.ascii "dct_c:\n"
	.align 2
dct_r_text:
	.ascii "dct_r:\n"
	.align 2
nq_y_text:
	.ascii "nq_y:\n"
	.align 2
nzigzag_text:
	.ascii "nzigzag:\n"
	.align 2
nrlecodes_text:
	.ascii "nrle codes: \n"
	.align 2
nrlevals_text:
	.ascii "nrle vals:\n"
	.align 2
nhuffman_y_vals_text:
	.ascii "nhuffman_y vals:\n"
	.align 2
nhuffman_y_size_text:
	.ascii "nhuffman_y size:\n"
	.align 2
norganize_text:
	.ascii "norganize:\n"
	.align 2

# end of string section
arr_R: .word 0,0,0,0,0,0,0,0,0,0,255,255,0,0,0,255,0,0,0,255,255,255,255,255,255,255,0,255,0,255,255,0,255,255,0,237,255,255,255,255,34,255,34,255,255,255,255,34,34,255,255,255,255,255,255,34,34,34,255,255,255,255,255,34

arr_G: .word 183,0,0,183,183,183,183,0,183,183,242,194,183,183,183,194,183,183,183,242,242,242,242,194,194,194,183,242,0,242,242,0,194,194,183,28,242,242,242,194,177,194,177,242,194,194,194,177,177,194,242,194,242,194,242,177,177,177,242,194,194,194,194,177

arr_B: .word 239,0,0,239,239,239,239,0,239,239,0,14,239,239,239,14,239,239,239,0,0,0,0,14,14,14,239,0,0,0,0,0,14,14,239,36,0,0,0,14,76,14,76,0,14,14,14,76,76,14,0,14,0,14,0,76,76,76,0,14,14,14,14,76

arr_Y: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_sample_Y: .word 7,-128,-128,7,7,7,7,-128,7,7,90,63,7,7,7,63,7,7,7,90,90,90,90,63,63,63,7,90,-128,90,90,-128,63,63,7,-37,90,90,90,63,-5,63,-5,90,63,63,63,-5,-5,63,90,63,90,63,90,-5,-5,-5,90,63,63,63,63,-5
	
arr_dct_c: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_sample_dct_c: .word 528,532,632,1716,1128,1892,2000,-328,223,-1556,-1625,-237,-1188,-679,-855,-499,-847,-1769,148,-37,579,-986,-910,-464,-27,-242,-1284,-779,427,-413,-378,-506,496,-588,-824,-732,-872,108,0,-1256,-12,-108,-528,331,-559,129,247,-1247,-145,-303,-564,173,285,106,30,-80,9,-62,-51,-211,424,67,90,284

arr_dct_r: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_sample_dct_r: .word 8100,-1896,-4508,3172,-2012,2398,-780,-250,-6416,-421,1886,1890,3014,1883,412,-464,-4286,-1138,-4465,-1531,2748,376,759,761,-3202,-267,453,3153,1432,-1156,-815,186,-3668,1450,1531,4004,-1060,1650,157,-95,-1747,1422,-1380,2072,-1227,1829,-682,-383,-498,-1441,-1035,1214,964,74,-331,-107,550,-1149,145,448,462,-616,15,217

arr_quantization_table: .word 1024,1477,1567,871,1024,652,757,1237,1477,1065,1130,628,492,313,455,892,1567,1130,600,667,392,333,414,947,1742,628,667,494,348,246,402,1052,1024,739,392,290,293,237,378,928,1304,470,333,370,326,332,438,1050,757,455,362,358,378,401,583,1372,1060,595,568,631,675,945,1372,2691

arr_quant: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_sample_quant: .word 127,-43,-108,42,-31,24,-9,-5,-145,-7,33,18,23,9,3,-6,-102,-20,-41,-16,16,2,5,11,-85,-3,5,24,8,-4,-5,3,-57,16,9,18,-5,6,1,-1,-35,10,-7,12,-6,9,-5,-6,-6,-10,-6,7,6,0,-3,-2,9,-10,1,4,5,-9,0,9

arr_zigzag: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_sample_zigzag: .word 127,-43,-145,-102,-7,-108,42,33,-20,-85,-57,-3,-41,18,-31,24,23,-16,5,16,-35,-6,10,9,24,16,9,-9,-5,3,2,8,18,-7,-10,9,-10,-6,12,-5,-4,5,-6,11,-5,6,-6,7,1,4,6,9,1,3,-1,-5,0,5,-9,-3,-6,-2,0,9

arr_rle_codes: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_rle_vals: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_sample_rle_vals: .word 127,-43,-145,-102,-7,-108,42,33,-20,-85,-57,-3,-41,18,-31,24,23,-16,5,16,-35,-6,10,9,24,16,9,-9,-5,3,2,8,18,-7,-10,9,-10,-6,12,-5,-4,5,-6,11,-5,6,-6,7,1,4,6,9,1,3,-1,-5,5,-9,-3,-6,-2,9,1,0

arr_sample_rle_codes: .word 0,6,8,7,3,7,6,6,5,7,6,2,6,5,5,5,5,5,3,5,6,3,4,4,5,5,4,4,3,2,2,4,5,3,4,4,4,3,4,3,3,3,3,4,3,3,3,3,1,3,3,4,1,2,1,3,19,4,2,3,2,20,0,0

arr_DC_huffman_table: .word 0,2,3,4,5,6,14,30,62,126,254,510

arr_DC_huffman_sizes: .word 2,3,3,3,3,3,4,5,6,7,8,9

arr_AC_huffman_table: .word 10,0,1,4,11,26,120,248,1014,65410,65411,0,0,0,0,0,0,12,27,121,502,2038,65412,65413,65414,65415,65416,0,0,0,0,0,0,28,249,1015,4084,65417,65418,65419,65420,65421,65422,0,0,0,0,0,0,58,503,4085,65423,65424,65425,65426,65427,65428,65429,0,0,0,0,0,0,59,1016,65430,65431,65432,65433,65434,65435,65436,65437,0,0,0,0,0,0,122,2039,65438,65439,65440,65441,65442,65443,65444,65445,0,0,0,0,0,0,123,4086,65446,65447,65448,65449,65450,65451,65452,65453,0,0,0,0,0,0,250,4087,65454,65455,65456,65457,65458,65459,65460,65461,0,0,0,0,0,0,504,32704,65462,65463,65464,65465,65466,65467,65468,65469,0,0,0,0,0,0,505,65470,65471,65472,65473,65474,65475,65476,65477,65478,0,0,0,0,0,0,506,65479,65480,65481,65482,65483,65484,65485,65486,65487,0,0,0,0,0,0,1017,65488,65489,65490,65491,65492,65493,65494,65495,65496,0,0,0,0,0,0,1018,65497,65498,65499,65500,65501,65502,65503,65504,65505,0,0,0,0,0,0,2040,65506,65507,65508,65509,65510,65511,65512,65513,65514,0,0,0,0,0,0,65515,65516,65517,65518,65519,65520,65521,65522,65523,65524,0,0,0,0,0,2041,65525,65526,65527,65528,65529,65530,65531,65532,65533,65534,0,0,0,0,0

arr_huffman_vals: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_huffman_size: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_sample_huffman_vals: .word 30,127,120,-43,1014,-145,248,-102,4,-7,248,-108,120,42,120,33,26,-20,248,-85,120,-57,1,-3,120,-41,26,18,26,-31,26,24,26,23,26,-16,4,5,26,16,120,-35,4,-6,11,10,11,9,26,24,26,16,11,9,11,-9,4,-5,1,3,1,2,11,8,26,18,4,-7,11,-10,11,9,11,-10,4,-6,11,12,4,-5,4,-4,4,5,4,-6,11,11,4,-5,4,6,4,-6,4,7,0,1,4,4,4,6,11,9,0,1,1,3,0,-1,4,-5,121,5,11,-9,1,-3,4,-6,1,-2,502,9,0,0,0,0

arr_sample_huffman_size: .word 5,7,7,6,10,8,8,7,3,3,8,7,7,6,7,6,5,5,8,7,7,6,2,2,7,6,5,5,5,5,5,5,5,5,5,5,3,3,5,5,7,6,3,3,4,4,4,4,5,5,5,5,4,4,4,4,3,3,2,2,2,2,4,4,5,5,3,3,4,4,4,4,4,4,3,3,4,4,3,3,3,3,3,3,3,3,4,4,3,3,3,3,3,3,3,3,2,1,3,3,3,3,4,4,2,1,2,2,2,1,3,3,7,3,4,4,2,2,3,3,2,2,9,4,0,0,0,0

arr_out: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

arr_sample_out: .word 247,255,0,10,126,205,223,6,96,248,39,226,175,16,233,127,10,188,12,158,22,212,180,13,99,87,211,229,212,60,57,13,213,206,177,168,92,219,68,237,113,169,65,107,115,107,13,228,81,203,13,220,83,67,57,146,107,146,226,47,54,217,33,95,180,255,0

.text

# macro to terminate the simualtion
/*

.macro exit
	.text
		li a7,10
		ecall
.endm

# macro to print a integer value
.macro print_int reg
	.text
		li a7,1
		add x10, \reg, x0 
		ecall
.endm

# marco to print a hexadecimal value
.macro print_hex reg
	.text
		li a7,34
		add x10, \reg, x0 
		ecall
.endm

# macro to print a string
.macro # print_str str
	.data
		str_label: .string "str"
	.text
		li a7, 4
		la x10, str_label
		ecall
.endm

.macro # print_array arr, size

	addi t1,zero,0
	li t5,4
	mul t5,t5,\size
	
	while: 
		lw t4, 0(\arr)

		addi \arr,\arr,4
		
		addi t1,t1,4
		
		li a7,1
		add x10, t4, x0 
		ecall
			
		bge t1, t5, skip_comma

		li a7, 4
		la x10, comma
		ecall

		j while
skip_comma:

.endm
*/

.macro  print_array arr, size, whilename, endname

	addi s1,zero,0
	li s0,4
	mul s0,s0,\size
	
	\whilename: 
		lw t4, 0(\arr)

		addi \arr,\arr,4
		
		addi s1,s1,4

		mv	a0, t4
		call	printFunct
	
		bge s1, s0, \endname

		print_text comma_ascii 1

		j \whilename
\endname:
	print_text line_ascii 2
.endm

.macro print_text str, length
	li a0, STDOUT
	la a1, \str
	li a2, \length
	li a7, WRITE
	ecall
.endm

# ---- text section ---- #

.globl main
main: 
# Use the following labels for functions
	#to test rgb2y function
	la x10,arr_R
	la x11,arr_G
	la x12,arr_B
	la x13,arr_Y
	rdcycle s0
	call rgb2y
	rdcycle s1
	# --- print rgb2y status
	print_text rgb2y_text 7
	print_text elapse_cycle_text 16
	sub a0, s1, s0
	call printFunct
	print_text line_ascii 1
	# --- 
	
	la t2, arr_Y
    li x11, 64
	# print_array t2,x11, while1, end1
	
    # to test dct_c function
	la x10,arr_Y
	# la x10,arr_sample_Y
	la x11,arr_dct_c
	rdcycle s0
	call dct_c
	rdcycle s1
	# --- print_str "\n\ndct_c: "
	print_text dct_c_text 7
	print_text elapse_cycle_text 16
	sub a0, s1, s0
	call printFunct
	print_text line_ascii 1
	# --- 

	la t2, arr_dct_c
    li x11, 64
	# print_array t2,x11, whil2, end2

    #to test dct_r function
	la x10,arr_dct_c
	# la x10,arr_sample_dct_c
	la x11,arr_dct_r
	rdcycle s0
	call dct_r
	rdcycle s1
	# --- print_str "\n\ndct_r: "
	print_text dct_r_text 7
	print_text elapse_cycle_text 16
	sub a0, s1, s0
	call printFunct
	print_text line_ascii 1
	# ----


	la t2, arr_dct_r
    li x11, 64
	# print_array t2,x11, whil3, end3

    #to test q_y function
	la x10,arr_dct_r
	# la x10,arr_sample_dct_r
	la x11,arr_quantization_table
	la x12,arr_quant
	rdcycle s0
	call q_y
	rdcycle s1
	# print_str "\n\nq_y: "
	print_text nq_y_text 6
	print_text elapse_cycle_text 16
	sub a0, s1, s0
	call printFunct
	print_text line_ascii 1

	la t2, arr_quant
    li x11, 64
	# print_array t2,x11, whil4, end4

    #to test zigzag function
	la x10,arr_quant
	# la x10,arr_sample_quant
	la x11,arr_zigzag
	rdcycle s0
	call zigzag
	rdcycle s1
	# print_str "\n\nzigzag: "
	print_text nzigzag_text 9
	print_text elapse_cycle_text 16
	sub a0, s1, s0
	call printFunct
	print_text line_ascii 1

	la t2, arr_zigzag
    li x11, 64
	# print_array t2,x11, whil5, end5

    #to test rle function
	la x10,arr_zigzag
	# la x10,arr_sample_zigzag
	la x11,arr_rle_codes
	la x12,arr_rle_vals
	rdcycle s0	
	call rle
	rdcycle s1
	# print_str "\n\nrle codes: "
	print_text nrlecodes_text 13
	print_text elapse_cycle_text 16
	sub a0, s1, s0
	call printFunct
	print_text line_ascii 1

	la t2, arr_rle_codes
    	li x11, 64
	print_array t2,x11, whil6, end6
	# print_str "\n\nrle vals: "
	print_text nrlevals_text 11

	la t2, arr_rle_vals
    	li x11, 64
	# print_array t2,x11, whil7, end7

    #to test huffman_y function
	la x10,arr_rle_vals
	# la x10,arr_sample_rle_vals
	la x11,arr_rle_codes
	# la x11,arr_sample_rle_codes
	la x12,arr_DC_huffman_table
	la x13,arr_DC_huffman_sizes
	la x14,arr_AC_huffman_table
	la x15,arr_huffman_vals
	la x16,arr_huffman_size
	rdcycle s0
	call huffman_y
	rdcycle s1
	# print_str "\n\nhuffman_y vals: "
	print_text nhuffman_y_vals_text 17
	print_text elapse_cycle_text 16
	sub a0, s1, s0
	call printFunct
	print_text line_ascii 1

	la t2, arr_huffman_vals
    li x11, 128
	# print_array t2,x11, whil8, end8
	# print_str "\n\nhuffman_y sizes: "
	print_text nhuffman_y_size_text 17

	la t2, arr_huffman_size
    li x11, 128
	# print_array t2,x11, whil9, end9

    #to test organize function
	la x10,arr_huffman_vals
	# la x10,arr_sample_huffman_vals
	la x11,arr_huffman_size
	# la x11,arr_sample_huffman_size
	la x12,arr_out
	rdcycle s0
	call organize
	rdcycle s1
	# print_str "\n\norganize:"
	print_text norganize_text 11
	print_text elapse_cycle_text 16
	sub a0, s1, s0
	call printFunct
	print_text line_ascii 1

	la t2, arr_out
    	li x11, 67
	# print_array t2,x11, whil10, end10
		
	# exit 
	addi sp, sp, 4
	addi a7, zero, 93 # syscall 93 is exit
	addi a0, x0, 0
	ecall

printFunct:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	sw  s1,52(sp)
	addi	s0,sp,64
	sw	a0,-52(s0)
	addi	a4,s0,-40
	lw	a2,-52(s0)
	lui	a5,%hi(.LC0)
	addi	a1,a5,%lo(.LC0)
	mv	a0,a4
	call	sprintf
	sw	a0,-20(s0)
	lw	a4,-20(s0)
	addi	a5,s0,-40
	mv	a2,a4
	mv	a1,a5
	li	a0,1
	call	write
	nop
	lw	ra,60(sp)
	lw	s0,56(sp)
	lw  s1,52(sp)
	addi	sp,sp,64
	jr	ra
	.size	printFunct, .-printFunct
	.align	1
	.globl	main
	.type	main, @function

gettime:
	addi	sp,sp,-32
	sw	ra,28(sp)
	mv	a1,sp
	li	a0,0
	li	a7, CLKGET
	
	call printFunct
	lw	a1,8(sp)
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	lw	a0,8(sp)
	lw	ra,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	gettime, .-gettime
	.align	1
	.globl	main
	.type	main, @function

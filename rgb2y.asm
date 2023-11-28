# to do: determine number and addresses of temporary registers
# subtract 16320 a.k.a. 1100000001000000 idea: li, sl, add 1, sl

.globl rgb2y

rgb2y:

    addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
    # save other registers to stack if needed

    li t0, 64 # intialize counter to 64 (8x8 pixels)
    li t1, 0 # initialize offset to 0
    li t6, 255
    slli t6, t6, 6 # t6 = 255 * 32 = 16320

    loop:
        beqz t0, return # if counter is 0, return

        add t2, x10, t1 # compute address of red value
        add t3, x11, t1 # compute address of green value
        add t4, x12, t1 # compute address of blue value
        

        lb t2, 0(t2) # load red value
        lb t3, 0(t3) # load green value
        lb t4, 0(t4) # load blue value

        li t5, 38 # initialize red multiplier to 38
        mul t2, t2, t5 # multiply red by 38

        li t5, 75 # initialize green multiplier to 75
        mul t3, t3, t5 # multiply green by 75

        li t5, 15 # initialize blue multiplier to 15
        mul t4, t4, t5 # multiply blue by 15

        add t2, t2, t3 # add red and green
        add t2, t2, t4 # add blue
        
        sub t2, t2, t6 # subtract 16320
        srai t2, t2, 7 # divide by 128
        add t5, x13, t1 # compute address of result
        sb t2, 0(t5) # store result

        addi t0, t0, -1 # decrement counter
        addi t1, t1, 4 # increment offset
        j loop # jump to loop

	return:
		# return X13
		# restore registers from stack if needed
		lw ra, 0(sp) # Restore return address register
		addi sp, sp, 4 # deallocate space for stack frame
		ret # return to calling point

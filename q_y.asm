.globl q_y

q_y:
    addi sp, sp , -8 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
    sw s0, 4(sp)
    # save other registers to stack if needed
    
    li s3, 64 # for(uint8_t i = 64; i > 0; i--){
    mv s0, x10 # address of an 8x8 input block
    mv s1, x11 # address of an 8x8 quantization table
    mv s2, x12 # address of the resulting 8x8 quantized block

    loop:
        beqz s3, return # if(i == 64) return;

        lw t0, 0(s0) # x[i];
        lw t1, 0(s1) # Q_Y[i];
        addi t3, x0, 0x80
        slli t3, t3, 8 # 0x8000

        mul t2, t0, t1 # temp2 = x[i] * Q_Y[i];
        add t2, t2, t3 # (temp2 + 0x8000)
        srai t2, t2, 16 # (temp2 + 0x8000) >> 16;

        sw t2, 0(s2) # y[i] = (temp2 + 0x8000) >> 16;

        addi s0, s0, 4 # x += 4;
        addi s1, s1, 4 # q_y += 4;
        addi s2, s2, 4 # y += 4;
        addi s3, s3, -1 # i++
        j loop # } // end for loop

    return:
        # restore registers from stack if needed
        lw ra, 0(sp) # Restore return address register
        lw s0, 4(sp)
        addi sp, sp, 8 # deallocate space for stack frame
        ret # return to calling point

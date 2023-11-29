.globl dct_c

dct_c:
    addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
    # save other registers to stack if needed
    
    li t0, 8 # for(uint8_t i = 0; i < 8; i++){ // for each column
    mv s9, x10 # s9 = x
    mv a7, x11

    loop:
        beqz t0, return # if(i == 8) return;
        # Compute intermediate values
        lw t1, 0(s9)  # Load x[i + 0]
        lw t2, 32(s9) # Load x[i + 8]
        lw t3, 64(s9) # Load x[i + 16]
        lw t4, 96(s9) # Load x[i + 24]
        lw t5, 128(s9) # Load x[i + 32]
        lw t6, 160(s9) # Load x[i + 40]
        lw s10, 192(s9) # Load x[i + 48]
        lw s11, 224(s9) # Load x[i + 56]

        add s0, t1, s11   # a00 = x[i+ 0] + x[i+56];
        add s1, t2, s10   # a10 = x[i+ 8] + x[i+48];
        add s2, t3, t6   #  a20 = x[i+16] + x[i+40];
        add s3, t4, t5   #  a30 = x[i+24] + x[i+32];
        sub s4, t4, t5   #  a40 = x[i+24] - x[i+32];
        sub s5, t3, t6   #  a50 = x[i+16] - x[i+40];
        sub s6, t2, s10   # a60 = x[i+ 8] - x[i+48];
        sub s7, t1, s11   # a70 = x[i+ 0] - x[i+56];

        add t1, s0, s3   #  a01 = a00 + a30;
        add t2, s1, s2   #  a11 = a10 + a20;
        sub t3, s1, s2   #  a21 = a10 - a20;
        sub t4, s0, s3   #  a31 = a00 - a30;
        add t5, s4, s5   #  neg_a41 = a40 + a50;
        add t6, s5, s6   #  a51 = a50 + a60;
        add s10, s6, s7   # a61 = a60 - a70;

        add s11, t3, t4    #   a22 = a21 + a31;

        li s4, 0x2D
        slli s4, s4, 8
        addi s4, s4, 0x41 # s4 = 11585

        li s5, 0x18
        slli s5, s5, 8
        addi s5, s5, 0x7E # s5 = 6270

        li s6, 0x22
        slli s6, s6, 8
        addi s6, s6, 0xA3 # s6 = 8867

        li s8, 0x53
        slli s8, s8, 8
        addi s8, s8, 0x9F # s7 = 21407

        mul s0, s11, s4 # a23 = a22 * 11585;
        sub s1, s10, t5 # mul5 = (a61 - neg_a41) * 6270;
        mul s1, s1, s5 # mul5 = (a61 - neg_a41) * 6270;
        mul s2, t5, s6 # a43 = (neg_a41 * 8867) - mul5;
        sub s2, s2, s1 # a43 = (neg_a41 * 8867) - mul5;
        mul s3, t6, s4 # a53 = a51 * 11585;
        mul s4, s10, s8 # a63 = (a61 * 21407) - mul5;
        sub s4, s4, s1 # a63 = (a61 * 21407) - mul5;

        slli s7, s7, 14 # temp1 = a70 << 14;
        add t3, s7, s3 # a54 = temp1 + a53;
        sub t5, s7, s3 # a74 = temp1 - a53;

        # // Keeping everything homogenous
        add t6, t1, t2  # y[i+0] = a01 + a11 << 2;
        slli t6, t6, 2  # y[i+0] = a01 + a11 << 2;
        sw t6, 0(a7)   # y[i+0] = a01 + a11 << 2;
        sub t6, t1, t2  # y[i+32] = a01 - a11 << 2;
        slli t6, t6, 2  # y[i+32] = a01 - a11 << 2;
        sw t6, 128(a7)   # y[i+32] = a01 - a11 << 2;

        # // Only 10 bits are required before the decimal
        li s10, 0x400
        slli s10, s10, 1 # s10 = 0x800
        slli t1, t4, 14 # temp1 = a31 << 14;
        add t2, t1, s0  # temp = temp1 + a23;
        add t2, t2, s10 
        srli t2, t2, 12 
        sw t2, 64(a7) # y[i+16] = (temp + 0x800) >> 12; // Lazy Rounding
        sub t2, t1, s0  # temp = temp1 - a23;
        add t2, t2, s10 
        srli t2, t2, 12 
        sw t2, 192(a7) # y[i+48] = (temp + 0x800) >> 12; // Lazy Rounding
        add t2, t5, s2 # temp = a74 + a43;
        add t2, t2, s10 
        srli t2, t2, 12 
        sw t2, 160(a7)  # y[i+40] = (temp + 0x800) >> 12; // Lazy Rounding
        add t2, t3, s4  # temp = a54 + a63;
        add t2, t2, s10 
        srli t2, t2, 12 
        sw t2, 32(a7)  # y[i+8] = (temp + 0x800) >> 12; // Lazy Rounding
        sub t2, t3, s4 # temp = a54 - a63;
        add t2, t2, s10 
        srli t2, t2, 12 
        sw t2, 224(a7) # y[i+56] = (temp + 0x800) >> 12; // Lazy Rounding
        sub t2, t5, s2 # temp = a74 - a43;
        add t2, t2, s10 
        srli t2, t2, 12 
        sw t2, 96(a7)  # y[i+24] = (temp + 0x800) >> 12; // Lazy Rounding

        addi s9, s9, 4 # x += 4;
        addi a7, a7, 4 # y += 4;
        addi t0, t0, -1 # i++
        j loop # } // end for loop


    return:
        # restore registers from stack if needed
        lw ra, 0(sp) # Restore return address register
        addi sp, sp, 4 # deallocate space for stack frame
        ret # return to calling point

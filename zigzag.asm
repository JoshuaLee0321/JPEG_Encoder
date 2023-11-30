.globl zigzag

zigzag:
    addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
    # save other registers to stack if needed

    # function body
    lw t0, 0(x10)
    sw t0, 0(x11)

    lw t0, 4(x10)
    sw t0, 4(x11)

    lw t0, 8(x10)
    sw t0, 20(x11)

    lw t0, 12(x10)
    sw t0, 24(x11)

    lw t0, 16(x10)
    sw t0, 56(x11)

    lw t0, 20(x10)
    sw t0, 60(x11)

    lw t0, 24(x10)
    sw t0, 108(x11)

    lw t0, 28(x10)
    sw t0, 112(x11)

    lw t0, 32(x10)
    sw t0, 8(x11)

    lw t0, 36(x10)
    sw t0, 16(x11)

    lw t0, 40(x10)
    sw t0, 28(x11)

    lw t0, 44(x10)
    sw t0, 52(x11)

    lw t0, 48(x10)
    sw t0, 64(x11)

    lw t0, 52(x10)
    sw t0, 104(x11)

    lw t0, 56(x10)
    sw t0, 116(x11)

    lw t0, 60(x10)
    sw t0, 168(x11)

    lw t0, 64(x10)
    sw t0, 12(x11)

    lw t0, 68(x10)
    sw t0, 32(x11)

    lw t0, 72(x10)
    sw t0, 48(x11)

    lw t0, 76(x10)
    sw t0, 68(x11)

    lw t0, 80(x10)
    sw t0, 100(x11)

    lw t0, 84(x10)
    sw t0, 120(x11)

    lw t0, 88(x10)
    sw t0, 164(x11)

    lw t0, 92(x10)
    sw t0, 172(x11)

    lw t0, 96(x10)
    sw t0, 36(x11)

    lw t0, 100(x10)
    sw t0, 44(x11)

    lw t0, 104(x10)
    sw t0, 72(x11)

    lw t0, 108(x10)
    sw t0, 96(x11)

    lw t0, 112(x10)
    sw t0, 124(x11)

    lw t0, 116(x10)
    sw t0, 160(x11)

    lw t0, 120(x10)
    sw t0, 176(x11)

    lw t0, 124(x10)
    sw t0, 212(x11)

    lw t0, 128(x10)
    sw t0, 40(x11)

    lw t0, 132(x10)
    sw t0, 76(x11)

    lw t0, 136(x10)
    sw t0, 92(x11)

    lw t0, 140(x10)
    sw t0, 128(x11)

    lw t0, 144(x10)
    sw t0, 156(x11)

    lw t0, 148(x10)
    sw t0, 180(x11)

    lw t0, 152(x10)
    sw t0, 208(x11)

    lw t0, 156(x10)
    sw t0, 216(x11)

    lw t0, 160(x10)
    sw t0, 80(x11)

    lw t0, 164(x10)
    sw t0, 88(x11)

    lw t0, 168(x10)
    sw t0, 132(x11)

    lw t0, 172(x10)
    sw t0, 152(x11)

    lw t0, 176(x10)
    sw t0, 184(x11)

    lw t0, 180(x10)
    sw t0, 204(x11)

    lw t0, 184(x10)
    sw t0, 220(x11)

    lw t0, 188(x10)
    sw t0, 240(x11)

    lw t0, 192(x10)
    sw t0, 84(x11)

    lw t0, 196(x10)
    sw t0, 136(x11)

    lw t0, 200(x10)
    sw t0, 148(x11)

    lw t0, 204(x10)
    sw t0, 188(x11)

    lw t0, 208(x10)
    sw t0, 200(x11)

    lw t0, 212(x10)
    sw t0, 224(x11)

    lw t0, 216(x10)
    sw t0, 236(x11)

    lw t0, 220(x10)
    sw t0, 244(x11)

    lw t0, 224(x10)
    sw t0, 140(x11)

    lw t0, 228(x10)
    sw t0, 144(x11)

    lw t0, 232(x10)
    sw t0, 192(x11)

    lw t0, 236(x10)
    sw t0, 196(x11)

    lw t0, 240(x10)
    sw t0, 228(x11)

    lw t0, 244(x10)
    sw t0, 232(x11)

    lw t0, 248(x10)
    sw t0, 248(x11)

    lw t0, 252(x10)
    sw t0, 252(x11)

    # restore registers from stack if needed
    lw ra, 0(sp) # Restore return address register
    addi sp, sp, 4 # deallocate space for stack frame
    ret # return to calling point

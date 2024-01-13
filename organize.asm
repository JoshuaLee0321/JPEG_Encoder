.globl organize

organize:
    addi sp, sp , -8 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
    sw s0, 4(sp)
    # save other registers to stack if needed

    # function body void organize(){
    li t0, 0    # short val;
    li t1, 1    # uint8_t x_size = 1;
    li t2, 0    # out_index = 0;
    li t3, 0    # in_index = 0;
    li t4, 0    # output_buffer = 0;
    li t5, 0    # output_size = 0;
    li s0, 0xff
    li s1, 8
    while:              # while(1) {
        add t6, x10, t3 
        lw t0, 0(t6)                # val = x_val[in_index];
        add t6, x11, t3 
        lw t1, 0(t6)                # x_size = x_size[in_index];
        addi t3, t3, 4              # in_index++;
        beqz t1, end                # if (x_size == 0) {break;}
        li t6, -1
        bgt t0, t6, positive_x       # if (val < 0) {
            addi t0, t0, -1             # val -= 1;
            sub t6, s1, t1              # t6 = 8 - x_size
            srl t6, s0, t6
            and t0, t0, t6              # val |= 0xFF >> (8 - x_size);}
        positive_x:
            sll t4, t4, t1         # output_buffer <<= x_size;
            or t4, t4, t0           # output_buffer |= val; =+?
            add t5, t5, t1          # output_size += x_size;
            blt t5, s1, while       # if (output_size < 8) {continue;}
            sub s2, t5, s1          # s2/offset = output_size - 8
            addi t5, t5, -8         # output_size -= 8;
            mv s3, t4               # s3/temp = output_buffer
            srl t4, t4, s2          # output_buffer >>= offset;
            add t6, x12, t2         # t6 = output + out_index
            sw t4, 0(t6)            # output[out_index] = output_buffer;
            addi t2, t2, 4          # out_index++;
            bne t4, s0, else       # if output_buffer == 0xff {
            add t6, x12, t2            
            sw x0, 0(t6)                # output[out_index] = 0x00;
            addi t2, t2, 4              # out_index++;
            else:                   # else {
                mv t5, s2               # output_size = offset;
                sub s2, s1, s2
                srl s2, s0, s2         # 0xFF >> (8 - offset);
                and t4, s3, s2          # output_buffer = temp & (0xFF >> (8 - offset));
                j while             # }
    end:                    
        beqz t5, return    # if (output_size != 0) {
        sub t6, s1, t5          # t6 = 8 - output_size
        sll t4, t4, t6              # output_buffer <<= (8 - output_size);
        srl t6, s0, t5         # 0xFF >> output_size;
        or t4, t4, t6           # output_buffer |= (0xFF >> (8 - output_size));
        add t6, x12, t2        # t6 = output + out_index
        sw t4, 0(t6)            # output[out_index] = output_buffer;
        addi t2, t2, 4          # out_index++; }
    # }

    return:
        # restore registers from stack if needed
        lw ra, 0(sp) # Restore return address register
        lw s0, 4(sp)
        addi sp, sp, 8 # deallocate space for stack frame
        ret # return to calling point
    

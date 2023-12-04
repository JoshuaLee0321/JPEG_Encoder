.globl organize

organize:
    addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
    # save other registers to stack if needed

    # function body void organize(){
    li t0, 0    # short val;
    li s0, 0    # short val_inter;
    li t1, 1    # uint8_t in_size = 1;
    li t2, 0    # out_index = 0;
    li t3, 0    # in_index = 0;
    li t4, 0    # output_buffer = 0;
    li t5, 0    # output_size = 0;
    while(1) {
        val = x_val[in_index];
        size = x_size[in_index];
        in_index++;
        if (size == 0) {break;}
        if (val < 0) {
            val -= 1;
        }
        output_buffer << size;
        output_buffer += val;
        output_size += size;
        if (output_size >= 8) {
            output_size -= 8;
            offset = output_size - 8;
            temp = output_buffer;
            output_buffer >>= offset;
            output[out_index] = output_buffer;
            out_index++;
            if output_buffer == 0xff {
                output[out_index] = 0x00;
                out_index++;
                output_buffer = 0;
                output_size = 0;
            }
            else {
                output_buffer = temp & (0xFF >> (8 - offset));
                output_size = offset;
            }
        }
    }
    if (output_size != 0) {
        output_buffer <<= (8 - output_size);
        output_buffer |= (0xFF >> (8 - output_size));
        output[out_index] = output_buffer;
        out_index++;
    }

    # }
   

    return:
        # restore registers from stack if needed
        lw ra, 0(sp) # Restore return address register
        addi sp, sp, 4 # deallocate space for stack frame
        ret # return to calling point

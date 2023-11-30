.globl rle

rle:
    addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
    # save other registers to stack if needed

    sw x0, 0(x11)   # y_code[0] = 0x0000; // not used, but put here for easier coding on later steps
    lw t0, 0(x10)    
    sw t0, 0(x12)   # y_val[0] = x[0]; // EOI/DC Pass along
    li s0, 0        # zero_count = 0;

    mv s1, x10      # x_ptr = x;  // pointer to input array
    mv s2, x11      # y_code_ptr = y_code; // pointer to output code array
    mv s3, x12      # y_val_ptr = y_val; // pointer to output value array
    li s5, 63       # loop_count = 63; // loop counter

    addi s2, s2, 4  # out_index++; // skip first index
    addi s3, s3, 4  # out_index++; // skip first index

    loop:           # for (i = 1; i < 64; i++){
        beqz s5, end_loop
        addi s1, s1, 4  # x_ptr++;
        lw t0, 0(s1)    # val = x[i];
        bne t0, x0, else    # if (val == 0) {zero_count++;}
        addi s0, s0, 1
        addi s5,s5, -1
        j loop
        else:          # else {
            li t1, 15
            while:
                ble s0, t1, not_while   # while (zero_count > 15)
                li t1, 0xf0
                sw t1, 0(s2)        # y_code[out_index] = 0x00f0;
                sw x0, 0(s3)        # y_val[out_index] = 0x0000; // not used, but put here for easier coding on later steps
                addi s0, s0, -16    # zero_count -= 16;
                addi s2, s2, 4      # out_index++;
                addi s3, s3, 4      # out_index++;
                j while
            not_while:
                slli t1, s0, 4
                j get_size_val
                returned_size: 
                    or t1, t1, t2 
                    sw t1, 0(s2)    # y_code[out_index] = zero_count << 4 | get_size(val);
                    sw t0, 0(s3)    # y_val[out_index] = val;
                    li s0, 0        # zero_count = 0;
                    addi s2, s2, 4  # out_index++;                   
                    addi s3, s3, 4  # out_index++: } // end else
        addi s5, s5, -1     # loop_count--;
        j loop # } // end for loop
        end_loop:
            lw t1, 0(s1)
            beq t1, x0, return  # if x[63] != 0 {
            sw x0, 0(s2)        # y_code[out_index] = 0x0000;
            addi t1, x0, 1
            sw t1, 0(s3)        # y_val[out_index] = 0x0001; // EOB}
            j return
                  

    get_size_val: # 	uint16_t get_size(short val){
        mv t3, t0 
        bne t3, x0, neg_2s_comp # 	if (val == 0) {return 0;}
        li t2, 0
        j returned_size
        neg_2s_comp:
            bge t3, x0, lookup # 	if (val < 0) {val = ~val + 1;} // use 2's comp to find size
            not t3, t3
            addi t3, t3, 1
        #     // algo: http://graphics.stanford.edu/~seander/bithacks.html#IntegerLogObvious
        lookup:
            li t2, 0        # uint16_t size = 0;

            size_8:
                li t5, 0xff 
                slli t5, t5, 8
                and t5, t3, t5
                beqz t5, size_4  # if (val & 0xff00) {
                srli t3, t3, 8    # val = val >> 8; // UNSIGNED >>
                li t6, 8
                or t2, t2, t6     # size |= 8; }

            size_4:
                li t5, 0xf0
                and t5, t3, t5
                beqz t5, size_2  # if (val & 0xf0) {
                srli t3, t3, 4      # val = val >> 4; // UNSIGNED >>
                li t6, 4
                or t2, t2, t6       # size |= 4;}

            size_2:
                li t5, 0xc
                and t5, t3, t5
                beqz t5, size_1  # if (val & 0xc) {
                srli t3, t3, 2      # val = val >> 2; // UNSIGNED >>
                li t6, 2
                or t2, t2, t6       # size |= 2; }

            size_1:
                li t5, 0x2
                and t5, t3, t5
                beqz t5, return_size  # if (val & 0x2) {
                li t6, 1
                or t2, t2, t6       # size |= 1; }
            
        return_size:
            addi t2, t2, 1   # return (size+1);
            j returned_size


    return:
        # restore registers from stack if needed
        lw ra, 0(sp) # Restore return address register
        addi sp, sp, 4 # deallocate space for stack frame
        ret # return to calling point

.globl huffman_y

huffman_y:
    addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
    # save other registers to stack if needed

    # function body void huffman_Y(){

    li t0, 0    # int16_t prev_DC_Y = 0;
    li t1, 0    # short val;
    li s0, 0    # short val_inter;
    li t2, 1    # uint8_t code = 1;
    li t3, 0    # uint8_t size_of_bits = 0;
            
    outer_while:      # while (1) {
        lw t1, 0(x10)    # val = x_val[0];
        mv s0, t1        # val_inter = val;
        jal s11, get_size   # val_inter = get_size(x_val[0]);
        mv t3, s0       # size_of_bits = get_size(x_val[0]);
        li t4, 0        # out_index = 0
        slli t3, t3, 2    
        add t5, x12, t3
        lw t5, 0(t5)
        sw t5, 0(x15)   # y_val[out_index] = huffman_table_DC_Y[size_of_bits];
        add t5, x13, t3
        lw t5, 0(t5)
        sw t5, 0(x16)   # y_size[out_index] = huffman_table_DC_Y_sizes[size_of_bits];
        srli t3, t3, 2
        addi t4, t4, 4  # out_index++;
        lw t5, 0(x10)
        add t6, x15, t4
        sw t5, 0(t6)    # y_val[out_index] = x_val[0];
        add t5, x16, t4
        sw t3, 0(t5)    # y_size[out_index] = size_of_bits;
        addi t4, t4, 4  # out_index++;
        li t5, 4        # in_index = 1;
        li t2, 1        # code = 1; // to start loop

        inner_while:    # while (code > 0) {
            add t6, x11, t5
            lw t2, 0(t6)    # code = x_code[in_index];
            ble t2, x0, return
            add t6, x10, t5
            lw t1, 0(t6)    # val = x_val[in_index];
            addi t5, t5, 4  # in_index++;

            while_zrl:      # while (code == 0xf0) {
                li t6, 0xf0
                bne t2, t6, while_zrl_end   # if (code != 0xf0) break;
                mv s0, t2                   # val_inter = code;
                jal s11, get_AC_Y_val              # val_inter = get_AC_Y_val(code);
                add t6, x15, t4             
                sw s0, 0(t6)                   # y_val[out_index] = get_AC_Y_val(code);
                mv s0, s0                   # val_inter = get_AC_Y_val(code);
                jal s11, get_size_AC               # val_inter = get_size_AC(get_AC_Y_val(code));
                add t6, x16, t4
                sw s0, 0(t6)                   # y_size[out_index] = get_size_AC(get_AC_Y_val(code));
                addi t4, t4, 4              # out_index++;
                add t6, x11, t5
                lw t2, 0(t6)                # code = x_code[in_index];
                add t6, x10, t5
                lw t1, 0(t6)                # val = x_val[in_index];
                addi t5, t5, 4              # in_index++;
                j while_zrl # } // end of while (code == 0xf0)

            while_zrl_end:
                li t6, 1
                bne t1, t6, no_EOB    # if ((val == 1) && (code == 0) {break;}
                beqz t2, return # if (code == 0) {return;} // on EOB you don't write back val
                no_EOB:
                    mv s0, t2 # val_inter = code;
                    jal s11, get_AC_Y_val # val_inter = get_AC_Y_val(code);
                    add t6, x15, t4
                    sw s0, 0(t6) # y_val[out_index] = get_AC_Y_val(code);
                    mv s0, s0 # val_inter = get_AC_Y_val(code);
                    jal s11, get_size_AC # val_inter = get_size_AC(get_AC_Y_val(code));
                    add t6, x16, t4
                    sw s0, 0(t6) # y_size[out_index] = get_size_AC(get_AC_Y_val(code));
                    addi t4, t4, 4 # out_index++;

                    beqz t2, return # if (code == 0) {return;} // on EOB you don't write back val   
                    add t6, x15, t4
                    sw t1, 0(t6) # y_val[out_index] = val;
                    mv s0, t1 # val_inter = val;
                    jal s11, get_size # val_inter = get_size(val);
                    add t6, x16, t4
                    sw s0, 0(t6) # y_size[out_index] = get_size(val);
                    addi t4, t4, 4 # out_index++;

            j inner_while # } // end of while (code > 0)
        j outer_while # } // end of while (1)

    get_size: # uint8_t get_size(int16_t val){
        mv s1, s0               # int16_t val = t1;
        li s0, 0                # uint8_t size = 0;
        beqz s1, return_size    # if (val == 0) return 0;   
        bgez s1, size_while     # if (val > 0) 
        not s1, s1
        addi s1, s1, 1          # {val = ~val + 1;}
        size_while:             # while (val != 0) {
            beqz s1, return_size
            addi s0, s0, 1          # size++;
            srli s1, s1, 1          # val = val >> 1;
            j size_while # } // end of while (val != 0)  
        return_size:
            jalr x0, 0(s11)  # return size; }
    
     get_size_AC: # 	uint16_t get_size(short val){
        mv s1, s0 
        neg_2s_comp:
            bge s1, x0, lookup # 	if (val < 0) {val = ~val + 1;} // use 2's comp to find size
            not s1, s1
            addi s1, s1, 1
        #     // algo: http://graphics.stanford.edu/~seander/bithacks.html#IntegerLogObvious
        lookup:
            li s0, 0        # uint16_t size = 0;

            size_8:
                li s2, 0xff 
                slli s2, s2, 8
                and s2, s1, s2
                beqz s2, size_4  # if (val & 0xff00) {
                srli s1, s1, 8    # val = val >> 8; // UNSIGNED >>
                ori s0, s0, 8     # size |= 8; }

            size_4:
                li s2, 0xf0
                and s2, s1, s2
                beqz s2, size_2  # if (val & 0xf0) {
                srli s1, s1, 4      # val = val >> 4; // UNSIGNED >>
                ori s0, s0, 4       # size |= 4;}

            size_2:
                li s2, 0xc
                and s2, s1, s2
                beqz s2, size_1  # if (val & 0xc) {
                srli s1, s1, 2      # val = val >> 2; // UNSIGNED >>
                ori s0, s0, 2      # size |= 2; }

            size_1:
                li s2, 0x2
                and s2, s1, s2
                beqz s2, size_0  # if (val & 0x2) {
                ori s0, s0, 1       # size |= 1; }

            size_0:
                li s2, 2
                bge s0, s2, return_size_AC # if (size < 2) {return 2;}
                li s0, 2
                jalr x0, 0(s11)

            
        return_size_AC:
            addi s0, s0, 1   # return (size+1);
            jalr x0, 0(s11)# }

    get_AC_Y_val: # uint16_t get_AC_Y_val(uint8_t code){
        mv s0, s0
        mv s2, x14
        b_0x10:
            li s1, 0x10       
            bge  s0, s1, b_0x20 # if (code < 0x10) {
            andi s3, s0, 0xf
            slli s3, s3, 2
            add s2, s2, s3
            lw s0, 0(s2)
            jalr x0, 0(s11)               # return huffman_table_AC_Y0[code & 0xf];
        b_0x20: 
            li s1, 0x20
            bge  s0, s1, b_0x30 # } else if (code < 0x20){
            li s3, 1
            j return_AC_Y_val   # return huffman_table_AC_Y1[(code & 0xf) - 1];
        b_0x30:
            li s1, 0x30
            bge  s0, s1, b_0x40 # } else if (code < 0x30){
            li s3, 2
            j return_AC_Y_val   # return huffman_table_AC_Y2[(code & 0xf) - 1];
        b_0x40:
            li s1, 0x40
            bge  s0, s1, b_0x50 # } else if (code < 0x40){
            li s3, 3
            j return_AC_Y_val   # return huffman_table_AC_Y3[(code & 0xf) - 1];
        b_0x50:
            li s1, 0x50
            bge  s0, s1, b_0x60 # } else if (code < 0x50){
            li s3, 4
            j return_AC_Y_val   # return huffman_table_AC_Y4[(code & 0xf) - 1];
        b_0x60:
            li s1, 0x60
            bge  s0, s1, b_0x70 # } else if (code < 0x60){
            li s3, 5
            j return_AC_Y_val   # return huffman_table_AC_Y5[(code & 0xf) - 1];
        b_0x70:
            li s1, 0x70
            bge  s0, s1, b_0x80 # } else if (code < 0x70){
            li s3, 6
            j return_AC_Y_val   # return huffman_table_AC_Y6[(code & 0xf) - 1];
        b_0x80:
            li s1, 0x80
            bge  s0, s1, b_0x90 # } else if (code < 0x80){
            li s3, 7
            j return_AC_Y_val   # return huffman_table_AC_Y7[(code & 0xf) - 1];
        b_0x90:
            li s1, 0x90
            bge  s0, s1, b_xa0 # } else if (code < 0x90){
            li s3, 8
            j return_AC_Y_val   # return huffman_table_AC_Y8[(code & 0xf) - 1];
        b_xa0:
            li s1, 0xa0
            bge  s0, s1, b_xb0 # } else if (code < 0xa0){
            li s3, 9
            j return_AC_Y_val   # return huffman_table_AC_Y9[(code & 0xf) - 1];
        b_xb0:
            li s1, 0xb0
            bge  s0, s1, b_0xc0 # } else if (code < 0xb0){
            li s3, 10
            j return_AC_Y_val   # return huffman_table_AC_Ya[(code & 0xf) - 1];
        b_0xc0:
            li s1, 0xc0
            bge  s0, s1, b_0xd0 # } else if (code < 0xc0){
            li s3, 11
            j return_AC_Y_val   # return huffman_table_AC_Yb[(code & 0xf) - 1];
        b_0xd0:
            li s1, 0xd0
            bge  s0, s1, b_0xe0 # } else if (code < 0xd0){
            li s3, 12
            j return_AC_Y_val   # return huffman_table_AC_Yc[(code & 0xf) - 1];
        b_0xe0:
            li s1, 0xe0
            bge  s0, s1, b_0xf0 # } else if (code < 0xe0){
            li s3, 13
            j return_AC_Y_val   # return huffman_table_AC_Yd[(code & 0xf) - 1];
        b_0xf0:
            li s1, 0xf0
            bge  s0, s1, else # } else if (code < 0xf0){
            li s3, 14
            j return_AC_Y_val   # return huffman_table_AC_Ye[(code & 0xf) - 1];
        else:
            li s3, 15
            slli s3, s3, 4
            andi s1, s0, 0xf
            add s3, s3, s1
            slli s3, s3, 2
            add s2, s2, s3
            lw s0, 0(s2)
            jalr x0, 0(s11)               # return huffman_table_AC_Yf[code & 0xf];
        return_AC_Y_val:
            slli s3, s3, 4
            addi s3, s3, 1 # Magic number: 1 because of the way the huffman tables are stored (first list has 17 entries)
            andi s1, s0, 0xf
            addi s1, s1, -1
            add s3, s3, s1
            slli s3, s3, 2
            add s2, s2, s3
            lw s0, 0(s2)
            jalr x0, 0(s11)# }  

    return:
        # restore registers from stack if needed
        lw ra, 0(sp) # Restore return address register
        addi sp, sp, 4 # deallocate space for stack frame
        ret # return to calling point

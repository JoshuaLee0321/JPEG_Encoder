# Created by Paintakotako on 2024/1/7.

# AS: assembler, convert assembly code to object file.
AS = riscv-none-elf-as

# CC: compiler, convert C code to object file.
CC = riscv-none-elf-gcc

# march: machine architecture, using rv32im, because mul and div are needed.
CFLAGS = -march=rv32im -mabi=ilp32 

# wildcard: find all files with specific suffix, *.s means all files with suffix .s
ASSEMBLY_FILES = $(wildcard *.asm)
OBJECT_FILES = $(ASSEMBLY_FILES:.asm=.o)

all: main.elf

# Rule to generate .o file from .s file
%.o: %.asm
	@$(AS) $(CFLAGS) -o $@ $<

main.elf: $(OBJECT_FILES)
	@$(CC) -o $@ $^
	@echo "Generate main.elf successfully!"
	@rm -f *.o
.PHONY: all clean
clean:
	@rm -f *.o *.elf *.bin *.hex
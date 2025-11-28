# Arrays example 
# 

# Compiler:
CC=gcc

# Compiler and linker flags:
# #################################
# -no-pie               Don’t produce a dynamically linked position independent 
#                       executable.
# -fno-pic              Don't generate position-independent code (PIC)
# -fno-stack-protector  Disable stack protection
# -fomit-frame-pointer  Don't keep the frame pointer in a register for functions 
#  		        that don't need one. This avoids the instructions to save,
#  		        set up and restore frame pointers
# -static		Link the C standard library statically
# -static-libgcc

CFLAGS=-Wall -O0 -no-pie -fno-pic -fno-stack-protector -fomit-frame-pointer -mcpu=cortex-a53+nosimd
LDFLAGS=-no-pie -static -static-libgcc



# Default target
all: clean arrays_v1 arrays_v2


%.o: %.s
	#
	######## Assemble ########
	#
	as -g $< -o $@
	######## Dump object file's content ########
	objdump -d -s $@ > $@.assembled.dump
	readelf -a $@ > $@.assembled.readelf.dump


arrays_v1: arrays_v1.o
	ld -m aarch64elf -nostdlib $< -o $@

arrays_v2: arrays_v2.o
	ld -m aarch64elf -nostdlib $< -o $@

# Clean target
#
.PHONY: clean
clean:
	rm arrays_v1 arrays_v2 *.o *.dump  >/dev/null 2>/dev/null || true



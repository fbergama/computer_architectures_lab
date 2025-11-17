# variables / variables_c
#
# Simple programs demonstrating how (global) 
# variables work in C and assembly
#
# variables: assembly version
# variables_c: C version
#
# -----------------------------------------------
# Computer Architectures - Laboratory
# Prof. Filippo Bergamasco
# Ca'Foscari University of Venice
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
all: clean variables variables_c


# C program "variables_c"

variables_c: variables.c
	#
	######## Compile ########
	#
	$(CC) $(CFLAGS) -g -c variables.c -o variables_c.o
	#
	######## Dump object file's content ########
	#
	objdump -d -j .data -j .text variables_c.o > variables_c.assembled.dump
	readelf -a variables_c.o > variables_c.assembled.readelf.dump
	#
	######## Link ########
	#
	$(CC) $(LDFLAGS) variables_c.o -o variables_c  
	#
	######## Dump linked executable's content using both readelf and objdump ########
	#
	readelf -a variables_c > variables_c.linked.readelf.dump
	objdump -d -h -s variables_c > variables_c.linked.dump
	#
	######## Export the symbol table ########
	#
	nm -n variables_c > variables_c.linked.symbols.dump


# Assembly program "variables"

variables.o: variables.s
	#
	######## Assemble ########
	#
	as variables.s -o variables.o
	#
	######## Dump object file's content ########
	#
	objdump -d -s variables.o > variables.assembled.dump
	readelf -a variables.o > variables.assembled.readelf.dump


variables: variables.o
	#
	######## Link ########
	#
	ld -m aarch64elf -nostdlib variables.o -o variables
	#
	######## Dump linked executable's content using both readelf and objdump ########
	#
	objdump -d -s  variables > variables.linked.dump
	readelf -a variables > variables.linked.readelf.dump
	#
	######## Export the symbol table ########
	#
	nm -n variables > variables_c.linked.symbols.dump


# Clean target
#
.PHONY: clean
clean:
	rm variables variables_c variables_c.s *.o *.dump  >/dev/null 2>/dev/null || true



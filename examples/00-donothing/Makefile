# donothing / donothing_c
#
# A simple program that exits with return code 3
#
# donothing: assembly version
# donothing_c: C version
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
all: clean donothing donothing_c


# C program "donothing_c"

donothing_c: donothing.c
	#
	######## Compile ########
	#
	$(CC) $(CFLAGS) -g -c donothing.c -o donothing_c.o
	#
	######## Dump object file's content ########
	#
	objdump -d donothing_c.o > donothing_c.assembled.dump
	#
	######## Link ########
	#
	$(CC) $(LDFLAGS) donothing_c.o -o donothing_c  
	#
	######## Dump linked executable's content using both readelf and objdump ########
	#
	readelf -a donothing_c > donothing_c.linked.readelf.dump
	objdump -d donothing_c > donothing_c.linked.dump
	#
	######## Export the symbol table ########
	#
	nm -n donothing_c > donothing_c.linked.symbols.dump


# Assembly program "donothing"

donothing.o: donothing.s
	#
	######## Assemble ########
	#
	as donothing.s -o donothing.o
	#
	######## Dump object file's content ########
	#
	objdump -d -s donothing.o > donothing.assembled.dump
	readelf -a donothing.o > donothing.assembled.readelf.dump


donothing: donothing.o
	#
	######## Link ########
	#
	ld -m aarch64elf -nostdlib donothing.o -o donothing
	#
	######## Dump linked executable's content using both readelf and objdump ########
	#
	objdump -d -s  donothing > donothing.linked.dump
	readelf -a donothing > donothing.linked.readelf.dump
	#
	######## Export the symbol table ########
	#
	nm -n donothing > donothing_c.linked.symbols.dump


# Clean target
#
.PHONY: clean
clean:
	rm donothing donothing_c donothing_c.s *.o *.dump  >/dev/null 2>/dev/null || true



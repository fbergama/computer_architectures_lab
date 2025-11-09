# donothing / donothing_c
#
# A simple program showing how the linker
# combines multiple object files
#
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
all: clean multisource


# Assembly program "multisource"
%.o: %.s
	#
	######## Assemble ########
	#
	as $< -o $@
	#
	######## Dump object file's content ########
	#
	objdump -d -s $@ > $@.assembled.dump
	readelf -a $@ > $@.assembled.readelf.dump


multisource: exit.o main.o
	#
	######## Link ########
	#
	ld -m aarch64elf -nostdlib exit.o main.o -o multisource
	#
	######## Dump linked executable's content using both readelf and objdump ########
	#
	objdump -d -s  multisource > multisource.linked.dump
	readelf -a multisource > multisource.linked.readelf.dump
	#
	######## Export the symbol table ########
	#
	nm -n multisource > multisource.linked.symbols.dump


# Clean target
#
.PHONY: clean
clean:
	rm multisource  *.o *.dump  >/dev/null 2>/dev/null || true



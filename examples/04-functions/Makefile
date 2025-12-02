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
all: clean functioncall


# C files

%.o: %.c
	#
	######## C-file Compile ########
	#
	$(CC) $(CFLAGS) -g -c $< -o $@
	#
	######## Dump object file's content ########
	#
	objdump -d $@ > $@.assembled.dump


# Assembly program "functioncall"

functioncall.o: functioncall.s
	#
	######## Assemble ########
	#
	as functioncall.s -o functioncall.o
	#
	######## Dump object file's content ########
	#
	objdump -d -s functioncall.o > functioncall.assembled.dump
	readelf -a functioncall.o > functioncall.assembled.readelf.dump


functioncall: functioncall.o strlen.o
	#
	######## Link ########
	#
	ld -m aarch64elf -nostdlib functioncall.o strlen.o -o functioncall
	#
	######## Dump linked executable's content using both readelf and objdump ########
	#
	objdump -d -s  functioncall > functioncall.linked.dump
	readelf -a functioncall > functioncall.linked.readelf.dump
	#
	######## Export the symbol table ########
	#
	nm -n functioncall > functioncall.linked.symbols.dump


# Clean target
#
.PHONY: clean
clean:
	rm functioncall *.o *.dump  >/dev/null 2>/dev/null || true


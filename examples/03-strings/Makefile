# strings
#
# Converts an UTF8 string to uppercase
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
all: clean strings



# Assembly program "strings"

strings.o: strings.s
	#
	######## Assemble ########
	#
	as -g strings.s -o strings.o
	#
	######## Dump object file's content ########
	#
	objdump -d -s strings.o > strings.assembled.dump
	readelf -a strings.o > strings.assembled.readelf.dump


strings: strings.o
	#
	######## Link ########
	#
	ld -m aarch64elf -nostdlib strings.o -o strings
	#
	######## Dump linked executable's content using both readelf and objdump ########
	#
	objdump -d -s  strings > strings.linked.dump
	readelf -a strings > strings.linked.readelf.dump
	#
	######## Export the symbol table ########
	#
	nm -n strings > strings.linked.symbols.dump


# Clean target
#
.PHONY: clean
clean:
	rm strings ifthen_c.s *.o *.dump  >/dev/null 2>/dev/null || true



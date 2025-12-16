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

CFLAGS=-Wall -O0 -no-pie -fno-pic -fno-stack-protector -fomit-frame-pointer -mcpu=cortex-a53+nosimd -fcf-protection=none 
LDFLAGS=-no-pie -static -static-libgcc



# Default target
all: clean password


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

password: password.o
	#
	######## Link ########
	#
	$(CC) $(LDFLAGS) $< -o $@
	#
	######## Dump object file's content ########
	#
	objdump -j .text -d -j .data -s -j .rodata $@ > $@.linked.dump
	readelf -a $@ > $@.linked.readelf.dump

# Clean target
#
.PHONY: clean
clean:
	rm password *.o *.dump  >/dev/null 2>/dev/null || true


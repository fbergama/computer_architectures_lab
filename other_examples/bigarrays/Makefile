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
all: clean bigarrays 



bigarrays: bigarrays.c
	#
	######## Compile ########
	#
	$(CC) $(CFLAGS) -g -c $< -o $@.o
	#
	######## Dump object file's content ########
	#
	objdump -d -S -s $@.o > $@.assembled.dump
	#
	######## Link ########
	#
	$(CC) $(LDFLAGS) $@.o -o $@ 
	#
	######## Dump linked executable's content using both readelf and objdump ########
	#
	objdump -d -h -s $@ > $@.linked.dump
	#

.PHONY: run
run:
	valgrind --tool=cachegrind --cachegrind-out-file=cachegrind.out --cache-sim=yes ./bigarrays 0
	valgrind --tool=cachegrind --cachegrind-out-file=cachegrind.out --cache-sim=yes ./bigarrays 1
	valgrind --tool=cachegrind --cachegrind-out-file=cachegrind.out --cache-sim=yes ./bigarrays 2
	#cg_annotate --show=D1mr,D1mw,DLmr,DLmw cachegrind.out > cachegrind.annotated.txt

# Clean target
#
.PHONY: clean
clean:
	rm bigarrays *.o *.dump cachegrind.*  >/dev/null 2>/dev/null || true



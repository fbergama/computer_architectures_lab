CFLAGS=-Wall -O0 -no-pie -fno-pic -fno-stack-protector -fomit-frame-pointer -mcpu=cortex-a53+nosimd

LDFLAGS=-no-pie -static -static-libgcc


program: program.o fun.o
	$(CC) $(LDFLAGS) fun.o program.o -o program

program.o: program.c
	$(CC) $(CFLAGS) -c -g -o program.o program.c

fun.o:	fun.s
	as fun.s -o fun.o



.PHONY: clean
clean:
	rm program *.o  >/dev/null 2>/dev/null || true

# Function call example

This program demostrates how to invoke a function according to the
ARM Procedure Call Standard (PCS).

Four variants of the string length function are given:

1. `strlen_c` iterative C version (see `strlen.c`)
2. `strlen_c_rec` recursive C version (see `strlen.c`)
3. `strlen` iterative assembly version (see `functioncall.s`)
4. `strlen_rec` recursive assembly version (see `functioncall.s`)

To test one of those, uncomment lines 99-102 in `functioncall.s`.

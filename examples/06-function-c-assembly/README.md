# Invoking an assembly function from C

This program demostrates how the ARM Procedure Call Standard (PCS) allows the
invocation an assembly function from a C program.

The function `int f(int, int)` is defined in `fun.s`. C code is in `program.c`.
In the example, `f` returns the sum of the two input parameters.



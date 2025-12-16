# ARM64 Examples

This directory contains a collection of simple assembly programs discussed
during the course.

Run `make` inside each example's directory to compile.

To execute a program with the debugger, read the [gdb cheatsheet](../materials/gdb_cheatsheet.md).

## donothing

A simple program that exits with return code 3

## multisource

Shows how the linker combines multiple object files

## variables

An example to understand how global and stack variables are
managed by the compiler/linker.

## arrays

Shows how to iterate over an array of integers using indices
or pointer arithmetics

## strings

Lowercase to uppercase conversion example. It demonstrates how to iterate over
a string.

## functions

Shows how to invoke a function according to the ARM Procedure Call Standard

## password

Shows how variables allocated in the stack can be exploited
for malicious purpuses (i.e. stack overflow). See the attached
README file.


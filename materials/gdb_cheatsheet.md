 gdb cheatsheet                                                    
=================================================================================
 rev.24112025
 
 Computer Architectures - Laboratory
 
 Prof. Filippo Bergamasco, 
 Ca'Foscari University of Venice



# Debugging an assembly program

## 1) start gdb:

```gdb <executable file>```

## 2) configure the layout

At the gdb prompt `(gdb)`, give the following commands:

```
(gdb) layout asm
(gdb) layout reg
(gdb) focus cmd
```

The terminal window is divided in 3 parts. At the top you have the CPU
registers, at the center the program disassebly and at the bottom the gdb
console.
To use c-x o (Ctrl+x o) to cycle focus between each window.


Note: in some examples, an init script is provided. In this case, launch
gdb with:

```
gdb --command=<init_file> <executable_file>
```

follow the `README.md` in each example directory for more info.


## 3) Run the program and stop at the first instruction (_start entrypoint)

```
(gdb) starti
```

## 4) debug the program.

List of useful commands:

### List all symbols
```
(gdb) info variables
```

### Execute single machine code instruction
```
(gdb) si 
```

### Print register content with a specified format:
```
(gdb) p/<fmt> $<reg>
```
where `<fmt>` can be:
`x`  for hex,
`u`  for unsigned int,
`d`  for signed int,
`c`  for char,
`s`  for string,
`t`  for binary,

and `<reg>` can be any register: `x0`...`x30`, `w0`...`w30`, or `pc`, `sp`, etc.

#### Examples:

Print the program counter in hex:

`p/x $pc`

Print the register w3 as binary number:

`p/t $w3`


### Dump memory content
```
(gdb) x/<n>xb <addr>
```
where `<n>` is the number of bytes
`<addr>` can be a memory address, the address of a variable `&<var>`, or an address contained in a register `$reg`.

For example, to dump 16 bytes from the SP:

`x/16xb $sp`

If you want to interpret a memory address in a different format, substitute `xb` with one of the following:

- `w` or `uw` for 4-bytes signed or unsigned word (int)
- `g` or `ug` for 8-bytes signed or unsigned dword (long int)

For example, to read the memory location pointed by the symbol `a` as a 32bit unsigned int:

```
x/uw &a
```


## 5) quit the debugger
```
(gdb) quit
```


# Debugging a C program

## 1) start gdb:
```
gdb <executable file>
```

## 2) configure the layout
At the gdb prompt (gdb), give the following command:
```
(gdb) layout split
```

## 3) add a breakpoint to the main() function

```
(gdb) b main
```
## 4) run the program
```
(gdb) run
```



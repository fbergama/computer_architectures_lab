# donothing / donothing_c

A simple program that exits with return code 3

- donothing: assembly version
- donothing_c: C version


run ```make``` to compile everything.

## Things to notice

In ```donothing.assembled.dump```

- there is only the ```.text``` segment;
- 3 instructions, 12 total bytes.


In ```donothing.assembled.readelf.dump```

- Type: ```REL (Relocatable file)```;
- there are no relocation information (in this example we don't have instructions
involving absolute memory addresses);
- entry point is at address ```0x00```;
- symbol tabe ```.symtab``` contains the ```_start``` symbol.

In ```donothing.linked.readelf.dump```

- Type: ```EXEC (Executable file)```;
- entry point is at address ```0x400000```


## Differences between ```donothing.s``` and ```donothing.c```

Code produced by the compiler (see ```donothing_c.assembled.dump```) just puts the
return value (3) in ```w0``` and executes the instruction RET. That's because ```main()```
is a function and ```w0``` is the register on which the return value is passed.

Auxiliary functions (part of the C standard library) are added by the linker
(see ```donothing_c.linked.dump```). We have the same ```_start``` entrypoint, but
a lot of "housekeeping" is performed before finally invoking ```main()```.

The ```Exit``` syscall is invoked in the ```_Exit()``` function.


# variables / variables_c

Simple programs demonstrating how (global) 
variables work in C and assembly

run ```make``` to compile everything.

## Things to notice

In ```variables.assembled.dump```

- Lables have been removed from ```ADR``` instructons;
- ```.data``` segment contains 3 (little-endian) integers.

In ```variables.assembled.readelf.dump```

- Relocation information are stored in the ```.rela.text``` section. ```Offset``` indicate
the address of instructions that needs to be updated when linking;
- symbol table ```.symtab``` contains the 3 global variables ```a```,```b```, and ```c```.


In ```variables.linked.dump```

- The ```ADR``` instructions now refer to the correct (absolute) addresses of global variables.


In ```variables.linked.readelf.dump```

- ```.rela.text``` is now empty because, after linking, all the addresses are known;
- symbol table contain references of the global symbols;
- ELF type is now "executable file".


In ```variables_c.assembled.dump```

- the compiler loads and store global variables with a combination of ```ADRP``` and 
```ADD x0,x0,#0``` instructions;
- accessing the variable ```d``` involve loading and storing from the stack pointer ```SP```.

In ```variables_c.linked.readelf.dump```

- the symbol table ```.symtab``` contains global symbols ```a```, ```b```, ```c```, but not ```d```;
- there are no relocation information as well.


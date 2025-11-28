# Arrays example

Simple program counting the number of zeros in an array.

The data section contains:

1. `A`: an array of integers (4 bytes) `A`
2. `n` (dword): the number of elements in A  
3. `r` (dword): variable used to store the result

```
.data
A:  .word 0,2,3,0,0,6,7,0,9,10,0,0,0
n:  .dword 13
r:  .dword 0
```

## Version 1 - array access using indices

`arrays_v1.s` shows how to access array elements using
indices.

Equivalent C code:

```
x0 = (&A[0])
x1 = n
x2 = current index
x3 = result


x3=0;
for (x2=0; x2<x1 ; ++x2 )
{
    if( A[x2] == 0 )
        x3+=1;
} 
```

## Version 2 - array access using indices

`arrays_v2.s` shows how to access array elements using
pointer arithmetics.

Equivalent C code:

```
x0 = (&A[0])
x1 = n
x2 = x0 + n*sizeof(int)  // pointer to the end of array
x3 = result

for( x3=0; x0<x2; x0+=sizeof(int) )
{
    if( mem[x0] == 0 )
        x3+=1;
} 
```


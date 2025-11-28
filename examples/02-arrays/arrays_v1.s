.global _start  // define a global symbol _start
_start:         // program entry point


    // Computes the number of zeros in the array A and stores
    // the result in variable r.
    // Variable n contains the number of elements in A.

    // Version 1: array access with indices
    // Equivalent C code:
    // 
    //        x0 = (&A[0])
    //        x1 = n
    //        x2 = current index
    //        x3 = result
    //        
    //
    //        x3=0;
    //        for (x2=0; x2<x1 ; ++x2 )
    //        {
    //            if( A[x2] == 0 )
    //                x3+=1;
    //        } 

    adr x0, A
    adr x1, n
    ldr x1, [x1]

    mov x3, #0

    mov x2, #0              // for loop initialization
    cmp x2,x1
    b.ge exitfor

initfor:    
    add x4, x0, x2, LSL #2  //x4 = &(A[x2])
    ldr w5, [x4]            //w5 = A[x2]
    cmp w5, #0
    b.ne forinc             // if(w5 != 0) goto for-inc
    add x3,x3,#1            // x3=x3+1
forinc:
    add x2,x2,#1            // x2=x2+1
    cmp x2,x1           
    b.lt initfor            // if( x2<x1 ) goto init-for
exitfor:
    adr x4, r               // x4 = &r
    str x3, [x4]            // r = x3

    /**/

    // for loop, array operations using pointers
    // Equivalent C code:
    // 
    //        x0 = (&A[0])
    //        x1 = n
    //        x2 = x0 + n*sizeof(int)  // pointer to the end of array
    //        x3 = result
    //        
    //        for( x3=0; x0<x2; x0+=sizeof(int) )
    //        {
    //            if( mem[x0] == 0 )
    //                x3+=1;
    //        } 
    // 
    //  In this version it is not necessary to 
    //  compute the address of ith element with
    //  the instruction
    //  add x4, x0, x2, LSL #2  //x4 = $(A[x2])
    //  So, it requres less clock cycles
    //
    /*
    adr x0, A               // Pointer to the first element of A
    adr x1, n
    ldr x1, [x1]

    add x2, x0, x1, LSL #2  // Pointer to the end of A

    mov x3, #0              // for initialization
    cmp x0,x2
    b.ge exitfor

initfor:    
    ldr w5, [x0]            //w5 = A[x0]
    cmp w5, #0
    b.ne forinc             // if(w5 != 0) goto for-inc
    add x3,x3,#1            // x3=x3+1
forinc:
    add x0,x0,#4            // x0=x0+sizeof(int)
    cmp x0,x2           
    b.lt initfor            // if( x0<x2 ) goto init-for
exitfor:
    adr x4, r               // x4 = &r
    str x3, [x4]            // r = x3
    /**/



exit:
    // Exit with return code 0
    mov x0, #0
    mov x8, #93
    svc #0


.data
// Begin of data section
A:  .word 0,2,3,0,0,6,7,0,9,10,0,0,0     // int A[13]
n:  .dword 13                            // len(A)
r:  .dword 0                             // variable used to store the result 
                             


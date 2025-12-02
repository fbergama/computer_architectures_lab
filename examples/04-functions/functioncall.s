    // The following functions are defined elsewhere. The linker will
    // compute the correct address once the executable is created
    .global strlen_c    // external strlen function (C implementation)
    .global strlen_c_rec // external strlen function (recursive C implementation)



    // Functions definition
    // -----------------------------------------------------------


    // Strlen function (iterative version)
    // 
    // Equivalent C code:
    //
    //            long strlen_c( unsigned char* s )
    //            {
    //                long i;
    //                for( i=0; *s!=0; ++i )
    //                    s++;
    //
    //                return i;
    //            }
    .global strlen
strlen:
    // x0: string address
    // x1: i
    mov x1, #0
    ldrb w2, [x0]   // w2 = (unsigned char)[x0]
    cmp w2, #0
    b.eq endfor
initfor:
    add x0, x0, #1  // for body (s++)
    add x1, x1, #1  // counter increment ++i
    ldrb w2, [x0]   // w2 = (unsigned char)[x0]
    cmp w2,#0
    b.ne initfor
endfor:
    // return value in x0
    mov x0, x1
    ret



    // Strlen function (recursive version)
    // 
    // Equivalent C code:
    //
    //            long strlen_c_rec( unsigned char* s )
    //            {
    //                if( *s == 0 )
    //                    return 0;
    //
    //                return 1+strlen_c_rec( s+1 );
    //            }
    .global strlen_rec
strlen_rec:
    ldrb w2, [x0]       // w2 = (unsigned char)[x0]
    cmp w2, #0
    b.eq returnzero

    // Here is the recursive function call. We are invoking
    // an external function, so we must preserve the value
    // of LR (X30) because it will be overwritten by the 
    // bl instruction. If we don't do that, the subsequent ret 
    // instruction will likely fail.
    //
    str x30, [sp, #-16]!  // push x30 (lr)
    add x0, x0, #1
    bl  strlen_rec

    // now x0 contains the return value of the recursive call
    // we just need to add 1
    add x0, x0, #1

    // before returning we must load the correct value
    // of LR from the stack (the one we had before the function call)
    ldr x30, [sp], #16   // pop x30 (lr)
    ret

returnzero:
    mov x0, #0
    ret

    


    // Program entry point
    // -----------------------------------------------------------

.global _start
_start:          
                

    adr x0, hellostr

    // Choose the version to test:

    //bl  strlen_c
    //bl  strlen_c_rec
    //bl  strlen
    bl  strlen_rec


    // Write syscall:
    // x0: file handle (1=standard output)
    // x1: string pointer
    // x2: string length
    // x8: 64 (write syscall number)

    // now x0 contains the string length. We copy it in
    // x2 as requested by the write syscall
    mov x2, x0         


    // write syscall invocation
    mov x0, #1          // 1 = standard output
    adr x1, hellostr    // x1 <- string pointer
    mov x8, #64         // x8 <- syscall number (64=write)
    svc #0              

    // exit syscall invocation
    mov x0, #3
    mov x8, #93
    svc #0


.data
    // program data
.global hellostr
hellostr: .asciz "hello\n"   // .asciiz inserts a null-terminated string
                             


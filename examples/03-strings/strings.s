.global _start
_start:         // program entry point


    // Print string
    // -----------------------------------------------------------
    mov x0, #1          // Load the standard output file descriptor (1) in x0
    adr x1, str         // Load the string address in x1 
    mov x2, #29         // Number of bytes to write in x2
    mov x8, #64         // Syscall number in x8
    svc #0              // Invoke the syscall



    // Conversion of an UTF8 string in uppercase
    // -----------------------------------------------------------
    //
    // Equivalent C code:
    //
    // while( *x0 != 0 ) 
    // {
    //      int w1 = *x0; 
    //      if ( w1>=97 && w1<123 )
    //      {
    //          *x0 -= 32;
    //      }
    //      x0 += 1;
    // }

touppercase:

    adr x0, str         // Load the string address
    ldrb w1, [x0]       // w1 = *x0
    cmp w1, #0
    b.eq endwhile       // empty string, skip the while loop

initwhile:
    // while body
    cmp w1, #97         
    b.lo skip
    cmp w1, #123
    b.hs skip

    sub w1, w1, #32
    strb w1, [x0]

skip:
    add x0, x0, #1      // x0 += 1
    ldrb w1, [x0]       // w1 = *x0
    cmp w1, #0          
    b.ne initwhile      // loop if the last byte read is not 0

endwhile:
    
    // Print string
    // -----------------------------------------------------------
    mov x0, #1          // Load the standard output file descriptor (1) in x0
    adr x1, str         // Load the string address in x1 
    mov x2, #29         // Number of bytes to write in x2
    mov x8, #64         // Syscall number in x8
    svc #0              // Invoke the syscall
    

exit:
    // Exit with return code 0 
    mov x0, #3
    mov x8, #93
    svc #0


.data
// Begin of data section

str:    .byte  0xf0,0x9f,0x99,0x82 // first smiley face in UTF8
        .byte  0xf0,0x9f,0x99,0x82 // second smiley face in UTF8
        .byte  0xf0,0x9f,0x99,0x82 // third smiley face in UTF8
        .ascii " Ciao cIao pRova\n"
        .byte 0 // end of string (NULL)

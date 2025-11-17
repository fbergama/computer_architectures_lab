.global _start  // define a global symbol _start
_start:         // program entry point

    // This program sums variables a and b and puts
    // the result in c

    adr x0, a
    ldr w1, [x0]
    
    adr x0, b
    ldr w2, [x0]

    add w3, w1, w2

    adr x0, c
    str w3, [x0]



    // Exit with return code 0
    mov x0, #0
    mov x8, #93
    svc #0
         

.data
// Begin of data section
.global a
a: .word 10
.global b
b: .word -1
.global c
c: .word 0


// The following assembly function
// will be invoked from the C program

.global f   // let f be visible outside this file
f:
    add w0, w0, w1
    ret


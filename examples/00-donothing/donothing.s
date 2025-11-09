.global _start  // define a global symbol _start
_start:         // program entry point

    // This simple program just invokes the __NR_EXIT syscall
    // (number 93) to inform the OS that it should be terminated

    mov x0, #3      // load the return code in x0
    mov x8, #93     // load the syscall number in x8
    svc #0          // Invoke the OS. The operand #0 is necessary for svc
                    // but meaningless in this case.


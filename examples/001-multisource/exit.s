    .cpu cortex-a53

    .text
    .p2align 2

    .global exit
exit:
    mov x0, #3      // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93     // Specifichiamo il numero della syscall in x8
    svc #0          // Invochiamo il sistema operativo. Il valore 0 e'
                    // necessario per l'istruzione svc ma non utilizzato
                    // in questo caso.

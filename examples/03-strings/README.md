# Strings example

Converts a (UTF8) string to uppercase. The string is
stored in `.data` section as follows:

```
str:    .byte  0xf0,0x9f,0x99,0x82 // first smiley face in UTF8
        .byte  0xf0,0x9f,0x99,0x82 // second smiley face in UTF8
        .byte  0xf0,0x9f,0x99,0x82 // third smiley face in UTF8
        .ascii " Ciao cIao pRova\n"
        .byte 0 // end of string (NULL)
```

notice the final byte `0x00` marking the end of `str`.

An equivalent C code (assuming that `x0` is a pointer to the string) is:

```
while( *x0 != 0 ) 
{
     int w1 = *x0; 
     if ( w1>=97 && w1<123 )
     {
         *x0 -= 32;
     }
     x0 += 1;
}
```


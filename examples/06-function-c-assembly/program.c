#include <stdio.h>

extern int f( int, int );

int main()
{
    int a=-3;
    int b=5;
    printf("f(%d,%d)=%d\n", a, b, f(a,b) );

    return 0;
}

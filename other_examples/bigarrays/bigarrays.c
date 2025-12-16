#include <stdlib.h>
#include <stdio.h>

#define A_SIZE 4096*1000*100

int main(int argc, char* argv[] )
{
    unsigned char* A = (unsigned char*)malloc( A_SIZE );
    size_t naccess,nrounds,idx;

    if( argc==1 )
    {
        printf("Usage: %s [0,1,2]\n", argv[0]);
        printf("0: sequential (forward) access test\n");
        printf("1: sequential (backward) access test\n");
        printf("2: sparse access test\n");
    }

    if( argc>1 && *argv[1]=='0' )
    {
        printf("sequential (forward) access\n");
        for( nrounds=0; nrounds<1000; ++nrounds )
        {
            idx=0;
            for( naccess=0; naccess<100000; ++naccess )
                A[ idx++ ] = 0;
        }
    }

    if( argc>1 && *argv[1]=='1' )
    {
        printf("sequential (backward) access\n");
        for( nrounds=0; nrounds<1000; ++nrounds )
        {
            idx=100000;
            for( naccess=0; naccess<100000; ++naccess )
                A[ --idx ] = 0;
        }
    }

    if( argc>1 && *argv[1]=='2' )
    {
        printf("sparse access\n");
        for( nrounds=0; nrounds<1000; ++nrounds )
        {
            idx=0;
            for( naccess=0; naccess<100000; ++naccess )
                A[ idx+=4000 ] = 0;
        }
    }

    return 0;
}

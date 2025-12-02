

long strlen_c( unsigned char* s )
{
    long i;
    for( i=0; *s!=0; ++i )
        s++;

    return i;
}


long strlen_c_rec( unsigned char* s )
{
    if( *s == 0 )
        return 0;

    return 1+strlen_c_rec( s+1 );
}

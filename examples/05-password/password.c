#include <stdlib.h>
/* Simple buffer overflow exploit demo
 * See the attached README.md
 * =================================
 *
 */

#include <stdio.h>
#include <string.h>

const char* correct_password = "pippo";


void login_valid()
{
    printf("Login granted!\n Here are some top secret personal info:\n");
    printf(".....\n");
    exit(0);
}


int checkpassword()
{
    unsigned int valid=0;
    char user_password[12];

    printf("Enter password: \n");
    scanf("%s", user_password );

    if( strcmp( user_password, correct_password) == 0 )
        valid = 1;

    return valid;
}


int main()
{
    if( checkpassword() )
    {
        login_valid();
        return 0;
    }

    printf("Wrong password!\n");
    return 3;
}   

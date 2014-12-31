#include <stdio.h>

int result=0;
void removeNumber(const char* str);

int main( int argc, const char* argv[] )
{
    printf( "\nHello World\n\n" );
    char str[100];

    printf("Enter string: ");
    gets(str);
    
    removeNumber(str);
    printf("inver string: %s\n",str);

    return 0;
}

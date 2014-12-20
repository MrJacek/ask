#include <stdio.h>

int result=0;
unsigned mystrlen(const char* str);
void invertstr(const char* str);

int main( int argc, const char* argv[] )
{
    printf( "\nHello World\n\n" );
    char str[100];

    printf("Enter string: ");
    gets(str);
    
    result=mystrlen(str);
    printf("str len: %d\n",result);
    
    
    invertstr(str);
    printf("inver string: %s\n",str);

    return 0;
}

#include <stdio.h>

int result=0;
void removeNumber(const char* str);

int main( int argc, const char* argv[] )
{
    char str[100];
/**    str[4]='a';
    str[5]='1';
    str[6]='a';
    str[7]='a';
    str[8]='a';
    str[9]='a';
    str[10]=0;
**/
    scanf("%s",str);
    removeNumber(str);
    printf("%s <=== result\n",str);

    return 0;
}

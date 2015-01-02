#include <stdio.h>

int result=0;
void removeNumber(const char* str);

int main( int argc, const char* argv[] )
{
    char str[100];
    scanf("%s",str);
    removeNumber(str);
    printf("%s <=== result\n",str);

    return 0;
}

#include <stdio.h>
// for nounrolling comment out the line below
// #pragma nounroll
int main()
{
    int x = 0;
    for (int i = 0; i < 10; i++)
    {
        x++;
        printf("x = %d\n", x);
    }
    return 0;
}

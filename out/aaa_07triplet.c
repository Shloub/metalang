#include <stdio.h>
#include <stdlib.h>


int main(void) {
    int j, d, i, c, b, a;
    for (i = 1; i < 4; i++)
    {
        scanf("%d %d %d ", &a, &b, &c);
        printf("a = %d b = %dc =%d\n", a, b, c);
    }
    int *l = calloc(10, sizeof(int));
    for (d = 0; d < 10; d++)
        scanf("%d ", &l[d]);
    for (j = 0; j < 10; j++)
        printf("%d\n", l[j]);
    return 0;
}



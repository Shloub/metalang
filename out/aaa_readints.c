#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int j, b, d, i, a, len;
    scanf("%d ", &len);
    printf("%d=len\n", len);
    int *tab1 = calloc( len , sizeof(int));
    for (a = 0; a < len; a++)
    {
        scanf("%d ", &tab1[a]);
    }
    for (i = 0; i < len; i++)
      printf("%d=>%d\n", i, tab1[i]);
    scanf("%d ", &len);
    int* *tab2 = calloc( len - 1 , sizeof(int*));
    for (b = 0; b < len - 1; b++)
    {
        int *c = calloc( len , sizeof(int));
        for (d = 0; d < len; d++)
        {
            scanf("%d ", &c[d]);
        }
        tab2[b] = c;
    }
    for (i = 0; i <= len - 2; i++)
    {
        for (j = 0; j < len; j++)
          printf("%d ", tab2[i][j]);
        printf("\n");
    }
    return 0;
}



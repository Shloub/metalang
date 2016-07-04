#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int m, k, o, p, l, i, j;
    int n = 10;
    /* normalement on doit mettre 20 mais là on se tape un overflow */
    n++;
    int* *tab = calloc(n, sizeof(int*));
    for (i = 0; i < n; i++)
    {
        int *tab2 = calloc(n, sizeof(int));
        for (j = 0; j < n; j++)
            tab2[j] = 0;
        tab[i] = tab2;
    }
    for (l = 0; l < n; l++)
    {
        tab[n - 1][l] = 1;
        tab[l][n - 1] = 1;
    }
    for (o = 2; o <= n; o++)
    {
        int r = n - o;
        for (p = 2; p <= n; p++)
        {
            int q = n - p;
            tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
        }
    }
    for (m = 0; m < n; m++)
    {
        for (k = 0; k < n; k++)
            printf("%d ", tab[m][k]);
        printf("\n");
    }
    printf("%d\n", tab[0][0]);
    return 0;
}



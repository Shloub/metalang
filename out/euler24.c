#include <stdio.h>
#include <stdlib.h>


int fact(int n) {
    int i;
    int prod = 1;
    for (i = 2; i <= n; i++)
        prod *= i;
    return prod;
}

void show(int lim, int nth) {
    int m, k, l, j, i;
    int *t = calloc(lim, sizeof(int));
    for (i = 0; i < lim; i++)
        t[i] = i;
    int *pris = calloc(lim, sizeof(int));
    for (j = 0; j < lim; j++)
        pris[j] = 0;
    for (k = 1; k < lim; k++)
    {
        int n = fact(lim - k);
        int nchiffre = nth / n;
        nth = nth % n;
        for (l = 0; l < lim; l++)
            if (!pris[l])
            {
                if (nchiffre == 0)
                {
                    printf("%d", l);
                    pris[l] = 1;
                }
                nchiffre--;
            }
    }
    for (m = 0; m < lim; m++)
        if (!pris[m])
            printf("%d", m);
    printf("\n");
}
int main(void) {
    show(10, 999999);
    return 0;
}



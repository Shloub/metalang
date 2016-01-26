#include <stdio.h>
#include <stdlib.h>


int max2_(int a, int b) {
    if (a > b)
      return a;
    else
      return b;
}


int* primesfactors(int n) {
    int i;
    int *tab = calloc( n + 1 , sizeof(int));
    for (i = 0; i < n + 1; i++)
      tab[i] = 0;
    int d = 2;
    while (n != 1 && d * d <= n)
      if (n % d == 0)
    {
        tab[d] = tab[d] + 1;
        n /= d;
    }
    else
      d++;
    tab[n] = tab[n] + 1;
    return tab;
}

int main(void) {
    int k, l, i, j, m;
    int lim = 20;
    int *o = calloc( lim + 1 , sizeof(int));
    for (m = 0; m < lim + 1; m++)
      o[m] = 0;
    for (i = 1; i <= lim; i++)
    {
        int* t = primesfactors(i);
        for (j = 1; j <= i; j++)
          o[j] = max2_(o[j], t[j]);
    }
    int product = 1;
    for (k = 1; k <= lim; k++)
      for (l = 1; l <= o[k]; l++)
        product *= k;
    printf("%d\n", product);
    return 0;
}



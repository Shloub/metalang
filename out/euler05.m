#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int* primesfactors(int n){
  int *tab = malloc( (n + 1) * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n + 1; i++)
      tab[i] = 0;
  }
  int d = 2;
  while (n != 1 && d * d <= n)
    if ((n % d) == 0)
  {
    tab[d] = tab[d] + 1;
    n /= d;
  }
  else
    d ++;
  tab[n] = tab[n] + 1;
  return tab;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int lim = 20;
  int *o = malloc( (lim + 1) * sizeof(int));
  {
    int m;
    for (m = 0 ; m < lim + 1; m++)
      o[m] = 0;
  }
  {
    int i;
    for (i = 1 ; i <= lim; i++)
    {
      int* t = primesfactors(i);
      {
        int j;
        for (j = 1 ; j <= i; j++)
          o[j] = max2(o[j], t[j]);
      }
    }
  }
  int product = 1;
  {
    int k;
    for (k = 1 ; k <= lim; k++)
      {
      int l;
      for (l = 1 ; l <= o[k]; l++)
        product *= k;
    }
  }
  printf("%d\n", product);
  [pool drain];
  return 0;
}



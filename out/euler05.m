#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

int* primesfactors(int n){
  int c = n + 1;
  int *tab = malloc( c * sizeof(int));
  {
    int i;
    for (i = 0 ; i < c; i++)
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
  int e = lim + 1;
  int *o = malloc( e * sizeof(int));
  {
    int m;
    for (m = 0 ; m < e; m++)
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



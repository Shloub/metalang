#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int n = 10;
  /* normalement on doit mettre 20 mais là on se tape un overflow */
  n ++;
  int* *tab = malloc( n * sizeof(int*));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int *tab2 = malloc( n * sizeof(int));
      {
        int j;
        for (j = 0 ; j < n; j++)
          tab2[j] = 0;
      }
      tab[i] = tab2;
    }
  }
  {
    int l;
    for (l = 0 ; l < n; l++)
    {
      tab[n - 1][l] = 1;
      tab[l][n - 1] = 1;
    }
  }
  {
    int o;
    for (o = 2 ; o <= n; o++)
    {
      int r = n - o;
      {
        int p;
        for (p = 2 ; p <= n; p++)
        {
          int q = n - p;
          tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
        }
      }
    }
  }
  {
    int m;
    for (m = 0 ; m < n; m++)
    {
      {
        int k;
        for (k = 0 ; k < n; k++)
        {
          printf("%d ", tab[m][k]);
        }
      }
      printf("\n");
    }
  }
  printf("%d\n", tab[0][0]);
  [pool drain];
  return 0;
}



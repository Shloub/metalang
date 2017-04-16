#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int dichofind(int len, int* tab, int tofind, int a, int b) {
    if (a >= b - 1)
        return a;
    else
    {
        int c = (a + b) / 2;
        if (tab[c] < tofind)
            return dichofind(len, tab, tofind, c, b);
        else
            return dichofind(len, tab, tofind, a, c);
    }
}


int process(int len, int* tab) {
    int m, l, i, j;
    int *size = calloc(len, sizeof(int));
    for (j = 0; j < len; j++)
        if (j == 0)
            size[j] = 0;
        else
            size[j] = len * 2;
    for (i = 0; i < len; i++)
    {
        int k = dichofind(len, size, tab[i], 0, len - 1);
        if (size[k + 1] > tab[i])
            size[k + 1] = tab[i];
    }
    for (l = 0; l < len; l++)
        printf("%d ", size[l]);
    for (m = 0; m < len; m++)
    {
        int k = len - 1 - m;
        if (size[k] != len * 2)
            return k;
    }
    return 0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i, e, len, n;
  scanf("%d ", &n);
  for (i = 1; i <= n; i++)
  {
      scanf("%d ", &len);
      int *d = calloc(len, sizeof(int));
      for (e = 0; e < len; e++)
          scanf("%d ", &d[e]);
      printf("%d\n", process(len, d));
  }
  [pool drain];
  return 0;
}



#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int read_int(){
  int out_ = 0;
  scanf("%d ", &out_);
  return out_;
}

int* read_int_line(int n){
  int *tab = malloc( n * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int t = 0;
      scanf("%d ", &t);
      tab[i] = t;
    }
  }
  return tab;
}

int** read_int_matrix(int x, int y){
  int* *tab = malloc( y * sizeof(int*));
  {
    int z;
    for (z = 0 ; z < y; z++)
    {
      int b = x;
      int *c = malloc( b * sizeof(int));
      {
        int d;
        for (d = 0 ; d < b; d++)
        {
          int e = 0;
          scanf("%d ", &e);
          c[d] = e;
        }
      }
      int* a = c;
      tab[z] = a;
    }
  }
  return tab;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int g = 0;
  scanf("%d ", &g);
  int f = g;
  int len = f;
  printf("%d=len\n", len);
  int k = len;
  int *l = malloc( k * sizeof(int));
  {
    int m;
    for (m = 0 ; m < k; m++)
    {
      int o = 0;
      scanf("%d ", &o);
      l[m] = o;
    }
  }
  int* h = l;
  int* tab1 = h;
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      printf("%d=>%d\n", i, tab1[i]);
    }
  }
  int q = 0;
  scanf("%d ", &q);
  int p = q;
  len = p;
  int** tab2 = read_int_matrix(len, len - 1);
  {
    int i;
    for (i = 0 ; i <= len - 2; i++)
    {
      {
        int j;
        for (j = 0 ; j < len; j++)
        {
          printf("%d ", tab2[i][j]);
        }
      }
      printf("\n");
    }
  }
  [pool drain];
  return 0;
}



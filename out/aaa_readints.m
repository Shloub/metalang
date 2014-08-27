#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int** read_int_matrix(int x, int y){
  int z, c, d;
  int* *tab = malloc( y * sizeof(int*));
  for (z = 0 ; z < y; z++)
  {
    int *b = malloc( x * sizeof(int));
    for (c = 0 ; c < x; c++)
    {
      scanf("%d ", &d);
      b[c] = d;
    }
    tab[z] = b;
  }
  return tab;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int j, i, k, f;
  scanf("%d ", &f);
  int len = f;
  printf("%d=len\n", len);
  int *h = malloc( len * sizeof(int));
  for (k = 0 ; k < len; k++)
  {
    scanf("%d ", &h[k]);
  }
  int* tab1 = h;
  for (i = 0 ; i < len; i++)
  {
    printf("%d=>%d\n", i, tab1[i]);
  }
  scanf("%d ", &len);
  int** tab2 = read_int_matrix(len, len - 1);
  for (i = 0 ; i <= len - 2; i++)
  {
    for (j = 0 ; j < len; j++)
    {
      printf("%d ", tab2[i][j]);
    }
    printf("\n");
  }
  [pool drain];
  return 0;
}



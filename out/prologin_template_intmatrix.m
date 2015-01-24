#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int programme_candidat(int** tableau, int x, int y){
  int i, j;
  int out0 = 0;
  for (i = 0 ; i < y; i++)
    for (j = 0 ; j < x; j++)
      out0 += tableau[i][j] * (i * 2 + j);
  return out0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int m, p, q, h, f;
  scanf("%d ", &f);
  int taille_x = f;
  scanf("%d ", &h);
  int taille_y = h;
  int* *tableau = malloc( taille_y * sizeof(int*));
  for (m = 0 ; m < taille_y; m++)
  {
    int *r = malloc( taille_x * sizeof(int));
    for (p = 0 ; p < taille_x; p++)
    {
      scanf("%d ", &q);
      r[p] = q;
    }
    tableau[m] = r;
  }
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  [pool drain];
  return 0;
}



#include <stdio.h>
#include <stdlib.h>

int min2_(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int main(void){
  int jy, jx, ix, iy, d, f, y, x;
  scanf("%d %d ", &x, &y);
  int* *tab = calloc( y , sizeof(int*));
  for (d = 0 ; d < y; d++)
  {
    int *e = calloc( x , sizeof(int));
    for (f = 0 ; f < x; f++)
    {
      scanf("%d ", &e[f]);
    }
    tab[d] = e;
  }
  for (ix = 1 ; ix < x; ix++)
    for (iy = 1 ; iy < y; iy++)
      if (tab[iy][ix] == 1)
    tab[iy][ix] =
    min2_(min2_(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) + 1;
  for (jy = 0 ; jy < y; jy++)
  {
    for (jx = 0 ; jx < x; jx++)
    {
      printf("%d ", tab[jy][jx]);
    }
    printf("\n");
  }
  return 0;
}



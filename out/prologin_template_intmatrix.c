#include <stdio.h>
#include <stdlib.h>

int programme_candidat(int** tableau, int x, int y){
  int i, j;
  int out0 = 0;
  for (i = 0 ; i < y; i++)
    for (j = 0 ; j < x; j++)
      out0 += tableau[i][j] * (i * 2 + j);
  return out0;
}

int main(void){
  int m, p, taille_y, taille_x;
  scanf("%d %d ", &taille_x, &taille_y);
  int* *tableau = malloc( taille_y * sizeof(int*));
  for (m = 0 ; m < taille_y; m++)
  {
    int *r = malloc( taille_x * sizeof(int));
    for (p = 0 ; p < taille_x; p++)
    {
      scanf("%d ", &r[p]);
    }
    tableau[m] = r;
  }
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  return 0;
}



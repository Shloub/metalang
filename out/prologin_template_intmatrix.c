#include <stdio.h>
#include <stdlib.h>


int programme_candidat(int** tableau, int x, int y) {
  int i, j;
  int out0 = 0;
  for (i = 0; i < y; i++)
    for (j = 0; j < x; j++)
      out0 += tableau[i][j] * (i * 2 + j);
  return out0;
}

int main(void) {
  int a, c, taille_y, taille_x;
  scanf("%d %d ", &taille_x, &taille_y);
  int* *tableau = calloc( taille_y , sizeof(int*));
  for (a = 0; a < taille_y; a++)
  {
    int *b = calloc( taille_x , sizeof(int));
    for (c = 0; c < taille_x; c++)
    {
      scanf("%d ", &b[c]);
    }
    tableau[a] = b;
  }
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  return 0;
}



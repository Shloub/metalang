#include <stdio.h>
#include <stdlib.h>


int programme_candidat(int* tableau, int taille) {
  int i;
  int out0 = 0;
  for (i = 0; i < taille; i++)
    out0 += tableau[i];
  return out0;
}

int main(void) {
  int a, taille;
  scanf("%d ", &taille);
  int *tableau = calloc( taille , sizeof(int));
  for (a = 0; a < taille; a++)
  {
    scanf("%d ", &tableau[a]);
  }
  printf("%d\n", programme_candidat(tableau, taille));
  return 0;
}



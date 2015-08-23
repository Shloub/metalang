#include <stdio.h>
#include <stdlib.h>

int programme_candidat(char* tableau, int taille){
  int i;
  int out0 = 0;
  for (i = 0 ; i < taille; i++)
  {
    out0 += (int)(tableau[i]) * i;
    printf("%c", tableau[i]);
  }
  printf("--\n");
  return out0;
}

int main(void){
  int a, taille;
  scanf("%d ", &taille);
  char *tableau = calloc( taille , sizeof(char));
  for (a = 0 ; a < taille; a++)
  {
    scanf("%c", &tableau[a]);
  }
  scanf(" ");
  printf("%d\n", programme_candidat(tableau, taille));
  return 0;
}



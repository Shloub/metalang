#include<stdio.h>
#include<stdlib.h>

int programme_candidat(char** tableau, int taille_x, int taille_y){
  int i, j;
  int out0 = 0;
  for (i = 0 ; i < taille_y; i++)
  {
    for (j = 0 ; j < taille_x; j++)
    {
      out0 += (int)(tableau[i][j]) * (i + j * 2);
      printf("%c", tableau[i][j]);
    }
    printf("--\n");
  }
  return out0;
}

int main(void){
  int m, p, taille_y, taille_x;
  scanf("%d %d ", &taille_x, &taille_y);
  char* *l = malloc( taille_y * sizeof(char*));
  for (m = 0 ; m < taille_y; m++)
  {
    char *r = malloc( taille_x * sizeof(char));
    for (p = 0 ; p < taille_x; p++)
      scanf("%c", &r[p]);
    scanf(" ");
    l[m] = r;
  }
  char** tableau = l;
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  return 0;
}



#include<stdio.h>
#include<stdlib.h>

char** read_char_matrix(int x, int y){
  int z, c;
  char d;
  char* *tab = malloc( y * sizeof(char*));
  for (z = 0 ; z < y; z++)
  {
    char *b = malloc( x * sizeof(char));
    for (c = 0 ; c < x; c++)
    {
      scanf("%c", &d);
      b[c] = d;
    }
    scanf(" ");
    tab[z] = b;
  }
  return tab;
}

int programme_candidat(char** tableau, int taille_x, int taille_y){
  int i, j;
  int out_ = 0;
  for (i = 0 ; i < taille_y; i++)
  {
    for (j = 0 ; j < taille_x; j++)
    {
      out_ += (int)(tableau[i][j]) * (i + j * 2);
      printf("%c", tableau[i][j]);
    }
    printf("--\n");
  }
  return out_;
}

int main(void){
  int h, f;
  scanf("%d ", &f);
  int taille_x = f;
  scanf("%d ", &h);
  int taille_y = h;
  char** tableau = read_char_matrix(taille_x, taille_y);
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  return 0;
}



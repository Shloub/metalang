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
    int* a = b;
    tab[z] = a;
  }
  return tab;
}

int programme_candidat(int** tableau, int x, int y){
  int i, j;
  int out_ = 0;
  for (i = 0 ; i < y; i++)
    for (j = 0 ; j < x; j++)
      out_ += tableau[i][j] * (i * 2 + j);
  return out_;
}

int main(void){
  int h, f;
  scanf("%d ", &f);
  int taille_x = f;
  scanf("%d ", &h);
  int taille_y = h;
  int** tableau = read_int_matrix(taille_x, taille_y);
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  return 0;
}



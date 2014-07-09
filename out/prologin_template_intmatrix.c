#include<stdio.h>
#include<stdlib.h>

int read_int(){
  int out_ = 0;
  scanf("%d ", &out_);
  return out_;
}

int* read_int_line(int n){
  int *tab = malloc( n * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int t = 0;
      scanf("%d ", &t);
      tab[i] = t;
    }
  }
  return tab;
}

int** read_int_matrix(int x, int y){
  int* *tab = malloc( y * sizeof(int*));
  {
    int z;
    for (z = 0 ; z < y; z++)
      tab[z] = read_int_line(x);
  }
  return tab;
}

int programme_candidat(int** tableau, int x, int y){
  int out_ = 0;
  {
    int i;
    for (i = 0 ; i < y; i++)
      {
      int j;
      for (j = 0 ; j < x; j++)
        out_ += tableau[i][j] * (i * 2 + j);
    }
  }
  return out_;
}

int main(void){
  int taille_x = read_int();
  int taille_y = read_int();
  int** tableau = read_int_matrix(taille_x, taille_y);
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  return 0;
}



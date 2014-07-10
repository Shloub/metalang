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
    {
      int b = x;
      int *c = malloc( b * sizeof(int));
      {
        int d;
        for (d = 0 ; d < b; d++)
        {
          int e = 0;
          scanf("%d ", &e);
          c[d] = e;
        }
      }
      int* a = c;
      tab[z] = a;
    }
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
  int g = 0;
  scanf("%d ", &g);
  int f = g;
  int taille_x = f;
  int k = 0;
  scanf("%d ", &k);
  int h = k;
  int taille_y = h;
  int** tableau = read_int_matrix(taille_x, taille_y);
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  return 0;
}



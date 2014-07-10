#include<stdio.h>
#include<stdlib.h>

int read_int(){
  int out_ = 0;
  scanf("%d ", &out_);
  return out_;
}

char* read_char_line(int n){
  char *tab = malloc( n * sizeof(char));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      char t = '_';
      scanf("%c", &t);
      tab[i] = t;
    }
  }
  scanf(" ");
  return tab;
}

char** read_char_matrix(int x, int y){
  char* *tab = malloc( y * sizeof(char*));
  {
    int z;
    for (z = 0 ; z < y; z++)
    {
      int b = x;
      char *c = malloc( b * sizeof(char));
      {
        int d;
        for (d = 0 ; d < b; d++)
        {
          char e = '_';
          scanf("%c", &e);
          c[d] = e;
        }
      }
      scanf(" ");
      char* a = c;
      tab[z] = a;
    }
  }
  return tab;
}

int programme_candidat(char** tableau, int taille_x, int taille_y){
  int out_ = 0;
  {
    int i;
    for (i = 0 ; i < taille_y; i++)
    {
      {
        int j;
        for (j = 0 ; j < taille_x; j++)
        {
          out_ += tableau[i][j] * (i + j * 2);
          printf("%c", tableau[i][j]);
        }
      }
      printf("--\n");
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
  char** tableau = read_char_matrix(taille_x, taille_y);
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  return 0;
}



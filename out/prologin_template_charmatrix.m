#import <Foundation/Foundation.h>
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
      char *b = malloc( x * sizeof(char));
      {
        int c;
        for (c = 0 ; c < x; c++)
        {
          char d = '_';
          scanf("%c", &d);
          b[c] = d;
        }
      }
      scanf(" ");
      char* a = b;
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
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int f = 0;
  scanf("%d ", &f);
  int e = f;
  int taille_x = e;
  int h = 0;
  scanf("%d ", &h);
  int g = h;
  int taille_y = g;
  char** tableau = read_char_matrix(taille_x, taille_y);
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  [pool drain];
  return 0;
}



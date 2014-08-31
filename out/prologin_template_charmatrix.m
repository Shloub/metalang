#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

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
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int m, p, h, f;
  char q;
  scanf("%d ", &f);
  int taille_x = f;
  scanf("%d ", &h);
  int taille_y = h;
  char* *l = malloc( taille_y * sizeof(char*));
  for (m = 0 ; m < taille_y; m++)
  {
    char *o = malloc( taille_x * sizeof(char));
    for (p = 0 ; p < taille_x; p++)
    {
      scanf("%c", &q);
      o[p] = q;
    }
    scanf(" ");
    l[m] = o;
  }
  char** tableau = l;
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  [pool drain];
  return 0;
}



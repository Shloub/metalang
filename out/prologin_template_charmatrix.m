#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int programme_candidat(char** tableau, int taille_x, int taille_y) {
    int i, j;
    int out0 = 0;
    for (i = 0; i < taille_y; i++)
    {
        for (j = 0; j < taille_x; j++)
        {
            out0 += (int)(tableau[i][j]) * (i + j * 2);
            printf("%c", tableau[i][j]);
        }
        printf("--\n");
    }
    return out0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int b, d, taille_y, taille_x;
  scanf("%d %d ", &taille_x, &taille_y);
  char* *a = calloc(taille_y, sizeof(char*));
  for (b = 0; b < taille_y; b++)
  {
      char *c = calloc(taille_x, sizeof(char));
      for (d = 0; d < taille_x; d++)
          scanf("%c", &c[d]);
      scanf(" ");
      a[b] = c;
  }
  char** tableau = a;
  printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  [pool drain];
  return 0;
}



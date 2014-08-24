#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int programme_candidat(char* tableau1, int taille1, char* tableau2, int taille2){
  int j, i;
  int out_ = 0;
  for (i = 0 ; i < taille1; i++)
  {
    out_ += (int)(tableau1[i]) * i;
    printf("%c", tableau1[i]);
  }
  printf("--\n");
  for (j = 0 ; j < taille2; j++)
  {
    out_ += (int)(tableau2[j]) * j * 100;
    printf("%c", tableau2[j]);
  }
  printf("--\n");
  return out_;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int m, e;
  int b = 0;
  scanf("%d ", &b);
  int taille1 = b;
  char *d = malloc( taille1 * sizeof(char));
  for (e = 0 ; e < taille1; e++)
  {
    char f = '_';
    scanf("%c", &f);
    d[e] = f;
  }
  scanf(" ");
  char* tableau1 = d;
  int h = 0;
  scanf("%d ", &h);
  int taille2 = h;
  char *l = malloc( taille2 * sizeof(char));
  for (m = 0 ; m < taille2; m++)
  {
    char o = '_';
    scanf("%c", &o);
    l[m] = o;
  }
  scanf(" ");
  char* tableau2 = l;
  printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  [pool drain];
  return 0;
}



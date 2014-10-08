#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int programme_candidat(char* tableau, int taille){
  int i;
  int out0 = 0;
  for (i = 0 ; i < taille; i++)
  {
    out0 += (int)(tableau[i]) * i;
    printf("%c", tableau[i]);
  }
  printf("--\n");
  return out0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int e, b;
  scanf("%d ", &b);
  int taille = b;
  char *d = malloc( taille * sizeof(char));
  for (e = 0 ; e < taille; e++)
    scanf("%c", &d[e]);
  scanf(" ");
  char* tableau = d;
  printf("%d\n", programme_candidat(tableau, taille));
  [pool drain];
  return 0;
}



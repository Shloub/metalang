#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int programme_candidat(int* tableau, int taille){
  int i;
  int out0 = 0;
  for (i = 0 ; i < taille; i++)
    out0 += tableau[i];
  return out0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int a, taille;
  scanf("%d ", &taille);
  int *tableau = malloc( taille * sizeof(int));
  for (a = 0 ; a < taille; a++)
  {
    scanf("%d ", &tableau[a]);
  }
  printf("%d\n", programme_candidat(tableau, taille));
  [pool drain];
  return 0;
}



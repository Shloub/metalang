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
  int e, b;
  scanf("%d ", &b);
  int taille = b;
  int *d = malloc( taille * sizeof(int));
  for (e = 0 ; e < taille; e++)
  {
    scanf("%d ", &d[e]);
  }
  int* tableau = d;
  printf("%d\n", programme_candidat(tableau, taille));
  [pool drain];
  return 0;
}



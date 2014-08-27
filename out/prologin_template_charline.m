#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int programme_candidat(char* tableau, int taille){
  int i;
  int out_ = 0;
  for (i = 0 ; i < taille; i++)
  {
    out_ += (int)(tableau[i]) * i;
    printf("%c", tableau[i]);
  }
  printf("--\n");
  return out_;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int e, b;
  char f;
  scanf("%d ", &b);
  int taille = b;
  char *d = malloc( taille * sizeof(char));
  for (e = 0 ; e < taille; e++)
  {
    scanf("%c", &f);
    d[e] = f;
  }
  scanf(" ");
  char* tableau = d;
  printf("%d\n", programme_candidat(tableau, taille));
  [pool drain];
  return 0;
}



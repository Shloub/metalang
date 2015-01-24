#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int programme_candidat(char* tableau1, int taille1, char* tableau2, int taille2){
  int j, i;
  int out0 = 0;
  for (i = 0 ; i < taille1; i++)
  {
    out0 += (int)(tableau1[i]) * i;
    printf("%c", tableau1[i]);
  }
  printf("--\n");
  for (j = 0 ; j < taille2; j++)
  {
    out0 += (int)(tableau2[j]) * j * 100;
    printf("%c", tableau2[j]);
  }
  printf("--\n");
  return out0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int m, g, d, b;
  scanf("%d ", &b);
  int taille1 = b;
  scanf("%d ", &d);
  int taille2 = d;
  char *tableau1 = malloc( taille1 * sizeof(char));
  for (g = 0 ; g < taille1; g++)
    scanf("%c", &tableau1[g]);
  scanf(" ");
  char *tableau2 = malloc( taille2 * sizeof(char));
  for (m = 0 ; m < taille2; m++)
    scanf("%c", &tableau2[m]);
  scanf(" ");
  printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  [pool drain];
  return 0;
}



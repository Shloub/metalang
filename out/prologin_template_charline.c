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
  int e, b;
  scanf("%d ", &b);
  int taille = b;
  char *tableau = malloc( taille * sizeof(char));
  for (e = 0 ; e < taille; e++)
    scanf("%c", &tableau[e]);
  scanf(" ");
  printf("%d\n", programme_candidat(tableau, taille));
  return 0;
}



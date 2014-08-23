#include<stdio.h>
#include<stdlib.h>

int programme_candidat(int* tableau, int taille){
  int out_ = 0;
  {
    int i;
    for (i = 0 ; i < taille; i++)
      out_ += tableau[i];
  }
  return out_;
}

int main(void){
  int b = 0;
  scanf("%d ", &b);
  int taille = b;
  int *d = malloc( taille * sizeof(int));
  {
    int e;
    for (e = 0 ; e < taille; e++)
    {
      int f = 0;
      scanf("%d ", &f);
      d[e] = f;
    }
  }
  int* tableau = d;
  printf("%d\n", programme_candidat(tableau, taille));
  return 0;
}



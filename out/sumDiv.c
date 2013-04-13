#include<stdio.h>
#include<stdlib.h>

int sumdiv(int n){
  /* On désire renvoyer la somme des diviseurs */
  int out_ = 0;
  /* On déclare un entier qui contiendra la somme */
  {
    int i;
    for (i = 1 ; i <= n; i++)
    {
      /* La boucle : i est le diviseur potentiel*/
      if ((n % i) == 0)
      {
        /* Si i divise */
        out_ = out_ + i;
        /* On incrémente */
      }
      else
      {
        /* nop */
      }
    }
  }
  return out_;
  /*On renvoie out*/
}

int main(void){
  /* Programme principal */
  int n = 0;
  scanf("%d", &n);
  /* Lecture de l'entier */
  int a = sumdiv(n);
  printf("%d", a);
  return 0;
}



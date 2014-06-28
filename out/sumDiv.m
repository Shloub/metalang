#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

void foo(){
  int a = 0;
  /* test */
  a ++;
  /* test 2 */
}

void foo2(){
  
}

void foo3(){
  if (1 == 1)
  {
    
  }
}

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
        out_ += i;
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
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  /* Programme principal */
  int n = 0;
  scanf("%d", &n);
  /* Lecture de l'entier */
  int b = sumdiv(n);
  printf("%d", b);
  [pool drain];
  return 0;
}



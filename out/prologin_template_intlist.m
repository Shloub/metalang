#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int read_int(){
  int out_ = 0;
  scanf("%d ", &out_);
  return out_;
}

int* read_int_line(int n){
  int *tab = malloc( n * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int t = 0;
      scanf("%d ", &t);
      tab[i] = t;
    }
  }
  return tab;
}

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
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int b = 0;
  scanf("%d ", &b);
  int a = b;
  int taille = a;
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
  int* c = d;
  int* tableau = c;
  printf("%d\n", programme_candidat(tableau, taille));
  [pool drain];
  return 0;
}



#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int b = 0;
  scanf("%d ", &b);
  int len = b;
  printf("%d=len\n", len);
  int *e = malloc( len * sizeof(int));
  {
    int f;
    for (f = 0 ; f < len; f++)
    {
      int g = 0;
      scanf("%d ", &g);
      e[f] = g;
    }
  }
  int* tab = e;
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      printf("%d=>%d ", i, tab[i]);
    }
  }
  printf("\n");
  int *k = malloc( len * sizeof(int));
  {
    int l;
    for (l = 0 ; l < len; l++)
    {
      int m = 0;
      scanf("%d ", &m);
      k[l] = m;
    }
  }
  int* tab2 = k;
  {
    int i_;
    for (i_ = 0 ; i_ < len; i_++)
    {
      printf("%d==>%d ", i_, tab2[i_]);
    }
  }
  int p = 0;
  scanf("%d ", &p);
  int strlen = p;
  printf("%d=strlen\n", strlen);
  char *r = malloc( strlen * sizeof(char));
  {
    int s;
    for (s = 0 ; s < strlen; s++)
    {
      char u = '_';
      scanf("%c", &u);
      r[s] = u;
    }
  }
  scanf(" ");
  char* tab4 = r;
  {
    int i3;
    for (i3 = 0 ; i3 < strlen; i3++)
    {
      char tmpc = tab4[i3];
      int c = (int)(tmpc);
      printf("%c:%d ", tmpc, c);
      if (tmpc != ' ')
        c = ((c - (int)('a')) + 13) % 26 + (int)('a');
      tab4[i3] = (char)(c);
    }
  }
  {
    int j;
    for (j = 0 ; j < strlen; j++)
      printf("%c", tab4[j]);
  }
  [pool drain];
  return 0;
}



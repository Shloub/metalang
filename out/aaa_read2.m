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

char* read_char_line(int n){
  char *tab = malloc( n * sizeof(char));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      char t = '_';
      scanf("%c", &t);
      tab[i] = t;
    }
  }
  scanf(" ");
  return tab;
}

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int b = 0;
  scanf("%d ", &b);
  int a = b;
  int len = a;
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
  int* d = e;
  int* tab = d;
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
  int* h = k;
  int* tab2 = h;
  {
    int i_;
    for (i_ = 0 ; i_ < len; i_++)
    {
      printf("%d==>%d ", i_, tab2[i_]);
    }
  }
  int p = 0;
  scanf("%d ", &p);
  int o = p;
  int strlen = o;
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
  char* q = r;
  char* tab4 = q;
  {
    int i3;
    for (i3 = 0 ; i3 < strlen; i3++)
    {
      char tmpc = tab4[i3];
      int c = tmpc;
      printf("%c:%d ", tmpc, c);
      if (tmpc != ' ')
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[i3] = c;
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



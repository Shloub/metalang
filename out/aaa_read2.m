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
  int e = len;
  int *f = malloc( e * sizeof(int));
  {
    int g;
    for (g = 0 ; g < e; g++)
    {
      int h = 0;
      scanf("%d ", &h);
      f[g] = h;
    }
  }
  int* d = f;
  int* tab = d;
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      printf("%d=>%d ", i, tab[i]);
    }
  }
  printf("\n");
  int l = len;
  int *m = malloc( l * sizeof(int));
  {
    int o;
    for (o = 0 ; o < l; o++)
    {
      int p = 0;
      scanf("%d ", &p);
      m[o] = p;
    }
  }
  int* k = m;
  int* tab2 = k;
  {
    int i_;
    for (i_ = 0 ; i_ < len; i_++)
    {
      printf("%d==>%d ", i_, tab2[i_]);
    }
  }
  int r = 0;
  scanf("%d ", &r);
  int q = r;
  int strlen = q;
  printf("%d=strlen\n", strlen);
  int u = strlen;
  char *v = malloc( u * sizeof(char));
  {
    int w;
    for (w = 0 ; w < u; w++)
    {
      char x = '_';
      scanf("%c", &x);
      v[w] = x;
    }
  }
  scanf(" ");
  char* s = v;
  char* tab4 = s;
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



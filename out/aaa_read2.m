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
  int len = read_int();
  printf("%d=len\n", len);
  int* tab = read_int_line(len);
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      printf("%d=>", i);
      int a = tab[i];
      printf("%d ", a);
    }
  }
  printf("\n");
  int* tab2 = read_int_line(len);
  {
    int i_;
    for (i_ = 0 ; i_ < len; i_++)
    {
      printf("%d==>", i_);
      int b = tab2[i_];
      printf("%d ", b);
    }
  }
  int strlen = read_int();
  printf("%d=strlen\n", strlen);
  char* tab4 = read_char_line(strlen);
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
    {
      char d = tab4[j];
      printf("%c", d);
    }
  }
  [pool drain];
  return 0;
}



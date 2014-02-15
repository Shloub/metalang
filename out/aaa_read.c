#include<stdio.h>
#include<stdlib.h>



/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  printf("%d=len\n", len);
  int *tab = malloc( len * sizeof(int));
  
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int tmpi1 = 0;
      scanf("%d", &tmpi1);
      scanf("%*[ \t\r\n]c", 0);
      printf("%d=>%d ", i, tmpi1);
      tab[i] = tmpi1;
    }
  }
  printf("\n");
  int *tab2 = malloc( len * sizeof(int));
  
  {
    int i_;
    for (i_ = 0 ; i_ < len; i_++)
    {
      int tmpi2 = 0;
      scanf("%d", &tmpi2);
      scanf("%*[ \t\r\n]c", 0);
      printf("%d==>%d ", i_, tmpi2);
      tab2[i_] = tmpi2;
    }
  }
  int strlen = 0;
  scanf("%d", &strlen);
  scanf("%*[ \t\r\n]c", 0);
  printf("%d=strlen\n", strlen);
  char *tab4 = malloc( strlen * sizeof(char));
  
  {
    int toto;
    for (toto = 0 ; toto < strlen; toto++)
    {
      char tmpc = '_';
      scanf("%c", &tmpc);
      int c = tmpc;
      printf("%c:%d ", tmpc, c);
      if (tmpc != ' ')
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[toto] = c;
    }
  }
  {
    int j;
    for (j = 0 ; j < strlen; j++)
    {
      char a = tab4[j];
      printf("%c", a);
    }
  }
  return 0;
}


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
  printf("%d", len);
  printf("=len\n");
  int *tab = malloc( len * sizeof(int));
  
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int tmpi1 = 0;
      scanf("%d", &tmpi1);
      scanf("%*[ \t\r\n]c", 0);
      printf("%d", i);
      printf("=>");
      printf("%d", tmpi1);
      printf(" ");
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
      printf("%d", i_);
      printf("==>");
      printf("%d", tmpi2);
      printf(" ");
      tab2[i_] = tmpi2;
    }
  }
  int strlen = 0;
  scanf("%d", &strlen);
  scanf("%*[ \t\r\n]c", 0);
  printf("%d", strlen);
  printf("=strlen\n");
  char *tab4 = malloc( strlen * sizeof(char));
  
  {
    int toto;
    for (toto = 0 ; toto < strlen; toto++)
    {
      char tmpc = '_';
      scanf("%c", &tmpc);
      int c = tmpc;
      printf("%c", tmpc);
      printf(":");
      printf("%d", c);
      printf(" ");
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



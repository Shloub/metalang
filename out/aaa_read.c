#include<stdio.h>
#include<stdlib.h>

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
int main(void){
  int j, toto, i_, i;
  int len = 0;
  scanf("%d ", &len);
  printf("%d=len\n", len);
  len *= 2;
  printf("len*2=%d\n", len);
  len /= 2;
  int *tab = malloc( len * sizeof(int));
  for (i = 0 ; i < len; i++)
  {
    int tmpi1 = 0;
    scanf("%d ", &tmpi1);
    printf("%d=>%d ", i, tmpi1);
    tab[i] = tmpi1;
  }
  printf("\n");
  int *tab2 = malloc( len * sizeof(int));
  for (i_ = 0 ; i_ < len; i_++)
  {
    int tmpi2 = 0;
    scanf("%d ", &tmpi2);
    printf("%d==>%d ", i_, tmpi2);
    tab2[i_] = tmpi2;
  }
  int strlen = 0;
  scanf("%d ", &strlen);
  printf("%d=strlen\n", strlen);
  char *tab4 = malloc( strlen * sizeof(char));
  for (toto = 0 ; toto < strlen; toto++)
  {
    char tmpc = '_';
    scanf("%c", &tmpc);
    int c = (int)(tmpc);
    printf("%c:%d ", tmpc, c);
    if (tmpc != ' ')
      c = ((c - (int)('a')) + 13) % 26 + (int)('a');
    tab4[toto] = (char)(c);
  }
  for (j = 0 ; j < strlen; j++)
    printf("%c", tab4[j]);
  return 0;
}



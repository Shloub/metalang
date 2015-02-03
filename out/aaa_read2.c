#include<stdio.h>
#include<stdlib.h>

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
int main(void){
  int j, i3, s, strlen, i_, l, i, f, len;
  scanf("%d ", &len);
  printf("%d=len\n", len);
  int *tab = malloc( len * sizeof(int));
  for (f = 0 ; f < len; f++)
  {
    scanf("%d ", &tab[f]);
  }
  for (i = 0 ; i < len; i++)
  {
    printf("%d=>%d ", i, tab[i]);
  }
  printf("\n");
  int *tab2 = malloc( len * sizeof(int));
  for (l = 0 ; l < len; l++)
  {
    scanf("%d ", &tab2[l]);
  }
  for (i_ = 0 ; i_ < len; i_++)
  {
    printf("%d==>%d ", i_, tab2[i_]);
  }
  scanf("%d ", &strlen);
  printf("%d=strlen\n", strlen);
  char *tab4 = malloc( strlen * sizeof(char));
  for (s = 0 ; s < strlen; s++)
    scanf("%c", &tab4[s]);
  scanf(" ");
  for (i3 = 0 ; i3 < strlen; i3++)
  {
    char tmpc = tab4[i3];
    int c = (int)(tmpc);
    printf("%c:%d ", tmpc, c);
    if (tmpc != ' ')
      c = ((c - (int)('a')) + 13) % 26 + (int)('a');
    tab4[i3] = (char)(c);
  }
  for (j = 0 ; j < strlen; j++)
    printf("%c", tab4[j]);
  return 0;
}



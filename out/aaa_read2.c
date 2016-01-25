#include <stdio.h>
#include <stdlib.h>

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
int main(void) {
  int j, i3, d, strlen, i_, b, i, a, len;
  scanf("%d ", &len);
  printf("%d=len\n", len);
  int *tab = calloc( len , sizeof(int));
  for (a = 0; a < len; a++)
  {
    scanf("%d ", &tab[a]);
  }
  for (i = 0; i < len; i++)
    printf("%d=>%d ", i, tab[i]);
  printf("\n");
  int *tab2 = calloc( len , sizeof(int));
  for (b = 0; b < len; b++)
  {
    scanf("%d ", &tab2[b]);
  }
  for (i_ = 0; i_ < len; i_++)
    printf("%d==>%d ", i_, tab2[i_]);
  scanf("%d ", &strlen);
  printf("%d=strlen\n", strlen);
  char *tab4 = calloc( strlen , sizeof(char));
  for (d = 0; d < strlen; d++)
  {
    scanf("%c", &tab4[d]);
  }
  scanf(" ");
  for (i3 = 0; i3 < strlen; i3++)
  {
    char tmpc = tab4[i3];
    int c = (int)(tmpc);
    printf("%c:%d ", tmpc, c);
    if (tmpc != ' ')
      c = (c - (int)('a') + 13) % 26 + (int)('a');
    tab4[i3] = (char)(c);
  }
  for (j = 0; j < strlen; j++)
    printf("%c", tab4[j]);
  return 0;
}



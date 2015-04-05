#include <stdio.h>
#include <stdlib.h>

/*
Ce test effectue un rot13 sur une chaine lue en entrée
*/
int main(void){
  int j, toto, strlen;
  char tmpc;
  scanf("%d ", &strlen);
  char *tab4 = calloc( strlen , sizeof(char));
  for (toto = 0 ; toto < strlen; toto++)
  {
    scanf("%c", &tmpc);
    int c = (int)(tmpc);
    if (tmpc != ' ')
      c = ((c - (int)('a')) + 13) % 26 + (int)('a');
    tab4[toto] = (char)(c);
  }
  for (j = 0 ; j < strlen; j++)
    printf("%c", tab4[j]);
  return 0;
}



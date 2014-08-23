#include<stdio.h>
#include<stdlib.h>

/*
Ce test effectue un rot13 sur une chaine lue en entrée
*/
int main(void){
  int strlen = 0;
  scanf("%d ", &strlen);
  char *tab4 = malloc( strlen * sizeof(char));
  {
    int toto;
    for (toto = 0 ; toto < strlen; toto++)
    {
      char tmpc = '_';
      scanf("%c", &tmpc);
      int c = (int)(tmpc);
      if (tmpc != ' ')
        c = ((c - (int)('a')) + 13) % 26 + (int)('a');
      tab4[toto] = (char)(c);
    }
  }
  {
    int j;
    for (j = 0 ; j < strlen; j++)
      printf("%c", tab4[j]);
  }
  return 0;
}



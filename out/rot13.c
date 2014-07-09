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
      int c = tmpc;
      if (tmpc != ' ')
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[toto] = c;
    }
  }
  {
    int j;
    for (j = 0 ; j < strlen; j++)
      printf("%c", tab4[j]);
  }
  return 0;
}



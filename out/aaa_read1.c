#include<stdio.h>
#include<stdlib.h>

int main(void){
  char *c = malloc( 12 * sizeof(char));
  {
    int d;
    for (d = 0 ; d < 12; d++)
    {
      char e = '_';
      scanf("%c", &e);
      c[d] = e;
    }
  }
  scanf(" ");
  char* str = c;
  {
    int i;
    for (i = 0 ; i <= 11; i++)
      printf("%c", str[i]);
  }
  return 0;
}



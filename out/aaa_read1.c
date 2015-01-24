#include<stdio.h>
#include<stdlib.h>

int main(void){
  int i, d;
  char *str = malloc( 12 * sizeof(char));
  for (d = 0 ; d < 12; d++)
    scanf("%c", &str[d]);
  scanf(" ");
  for (i = 0 ; i <= 11; i++)
    printf("%c", str[i]);
  return 0;
}



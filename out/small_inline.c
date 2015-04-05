#include <stdio.h>
#include <stdlib.h>

int main(void){
  int d;
  int *t = calloc( 2 , sizeof(int));
  for (d = 0 ; d < 2; d++)
  {
    scanf("%d ", &t[d]);
  }
  printf("%d - %d\n", t[0], t[1]);
  return 0;
}



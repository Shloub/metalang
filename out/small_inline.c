#include<stdio.h>
#include<stdlib.h>

int main(void){
  int d;
  int *c = malloc( 2 * sizeof(int));
  for (d = 0 ; d < 2; d++)
  {
    scanf("%d ", &c[d]);
  }
  printf("%d - %d\n", c[0], c[1]);
  return 0;
}



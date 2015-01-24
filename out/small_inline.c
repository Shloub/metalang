#include<stdio.h>
#include<stdlib.h>

int main(void){
  int d;
  int *c = malloc( 2 * sizeof(int));
  for (d = 0 ; d < 2; d++)
  {
    scanf("%d ", &c[d]);
  }
  int* t = c;
  printf("%d - %d\n", t[0], t[1]);
  return 0;
}



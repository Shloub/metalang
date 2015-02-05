#include <stdio.h>
#include <stdlib.h>

int main(void){
  int i, c, b, a;
  for (i = 1 ; i <= 3; i++)
  {
    scanf("%d %d %d ", &a, &b, &c);
    printf("a = %d b = %dc =%d\n", a, b, c);
  }
  return 0;
}



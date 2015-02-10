#include <stdio.h>
#include <stdlib.h>

int main(void){
  int j, o, i, c, b, a;
  for (i = 1 ; i <= 3; i++)
  {
    scanf("%d %d %d ", &a, &b, &c);
    printf("a = %d b = %dc =%d\n", a, b, c);
  }
  int *l = malloc( 10 * sizeof(int));
  for (o = 0 ; o < 10; o++)
  {
    scanf("%d ", &l[o]);
  }
  for (j = 0 ; j <= 9; j++)
  {
    printf("%d\n", l[j]);
  }
  return 0;
}



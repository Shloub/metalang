#include <stdio.h>
#include <stdlib.h>

int main(void){
  printf("Hello World");
  int a = 5;
  printf("%d \n%dfoo", (4 + 6) * 2, a);
  int b = 1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 == 12 && 1;
  if (b)
    printf("True");
  else
    printf("False");
  printf("\n");
  int c = (3 * (4 + 5 + 6) * 2 == 45) == 0;
  if (c)
    printf("True");
  else
    printf("False");
  printf(" ");
  int d = (2 == 1) == 0;
  if (d)
    printf("True");
  else
    printf("False");
  printf(" %d%d", (4 + 1) / 3 / (2 + 1), 4 * 1 / 3 / 2 * 1);
  int e = !(!(a == 0) && !(a == 4));
  if (e)
    printf("True");
  else
    printf("False");
  int f = 1 && !0 && !(1 && 0);
  if (f)
    printf("True");
  else
    printf("False");
  printf("\n");
  return 0;
}



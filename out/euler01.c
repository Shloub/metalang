#include <stdio.h>
#include <stdlib.h>

int main(void){
  int i;
  int sum = 0;
  for (i = 0 ; i <= 999; i++)
    if ((i % 3) == 0 || (i % 5) == 0)
    sum += i;
  printf("%d\n", sum);
  return 0;
}



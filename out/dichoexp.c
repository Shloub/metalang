#include <stdio.h>
#include <stdlib.h>


int exp0(int a, int b) {
  if (b == 0)
    return 1;
  if (b % 2 == 0)
  {
    int o = exp0(a, b / 2);
    return o * o;
  }
  else
    return a * exp0(a, b - 1);
}

int main(void) {
  int a = 0;
  int b = 0;
  scanf("%d %d", &a, &b);
  printf("%d", exp0(a, b));
  return 0;
}



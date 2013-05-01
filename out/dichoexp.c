#include<stdio.h>
#include<stdlib.h>

int exp_(int a, int b){
  if (b == 0)
    return 1;
  if ((b % 2) == 0)
  {
    int o = exp_(a, b / 2);
    return o * o;
  }
  else
    return a * exp_(a, b - 1);
}

int main(void){
  int a = 0;
  int b = 0;
  scanf("%d", &a);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &b);
  int c = exp_(a, b);
  printf("%d", c);
  return 0;
}



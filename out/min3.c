#include<stdio.h>
#include<stdlib.h>

int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int main(void){
  printf("%d %d %d %d %d %d\n", min2(min2(2, 3), 4), min2(min2(2, 4), 3), min2(min2(3, 2), 4), min2(min2(3, 4), 2), min2(min2(4, 2), 3), min2(min2(4, 3), 2));
  return 0;
}



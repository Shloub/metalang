#include<stdio.h>
#include<stdlib.h>
#include<math.h>

int isqrt(int c){
  return sqrt(c);
}

int main(void){
  printf("%d %d %d %d %d %d ", isqrt(4), isqrt(16), isqrt(20), isqrt(1000), isqrt(500), isqrt(10));
  return 0;
}



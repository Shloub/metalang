#include<stdio.h>
#include<stdlib.h>

int main(void){
  int lim = 100;
  int sum = (lim * (lim + 1)) / 2;
  int carressum = sum * sum;
  int sumcarres = (lim * (lim + 1) * (2 * lim + 1)) / 6;
  int a = carressum - sumcarres;
  printf("%d", a);
  return 0;
}



#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/*
La suite de fibonaci
*/
int fibo0(int a, int b, int i){
  int j;
  int out0 = 0;
  int a2 = a;
  int b2 = b;
  for (j = 0 ; j <= i + 1; j++)
  {
    out0 += a2;
    int tmp = b2;
    b2 += a2;
    a2 = tmp;
  }
  return out0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int a = 0;
  int b = 0;
  int i = 0;
  scanf("%d %d %d", &a, &b, &i);
  printf("%d", fibo0(a, b, i));
  [pool drain];
  return 0;
}



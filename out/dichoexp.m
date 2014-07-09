#import <Foundation/Foundation.h>
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
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int a = 0;
  int b = 0;
  scanf("%d %d", &a, &b);
  printf("%d", exp_(a, b));
  [pool drain];
  return 0;
}



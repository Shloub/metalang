#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>
#include<math.h>

int isqrt(int c){
  return sqrt(c);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int a = isqrt(4);
  printf("%d ", a);
  int b = isqrt(16);
  printf("%d ", b);
  int d = isqrt(20);
  printf("%d ", d);
  int e = isqrt(1000);
  printf("%d ", e);
  int f = isqrt(500);
  printf("%d ", f);
  int g = isqrt(10);
  printf("%d ", g);
  [pool drain];
  return 0;
}



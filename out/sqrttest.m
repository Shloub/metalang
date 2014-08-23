#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>
#include<math.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int b = 4;
  printf("%d ", (int)sqrt(b));
  int e = 16;
  printf("%d ", (int)sqrt(e));
  int g = 20;
  printf("%d ", (int)sqrt(g));
  int i = 1000;
  printf("%d ", (int)sqrt(i));
  int k = 500;
  printf("%d ", (int)sqrt(k));
  int m = 10;
  printf("%d ", (int)sqrt(m));
  [pool drain];
  return 0;
}



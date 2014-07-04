#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int a = 1;
  int b = 2;
  int sum = 0;
  while (a < 4000000)
  {
    if ((a % 2) == 0)
      sum += a;
    int c = a;
    a = b;
    b += c;
  }
  printf("%d\n", sum);
  [pool drain];
  return 0;
}



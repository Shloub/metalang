#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int foo(int a, int b){
  return a + b;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  printf("%d", 10);
  [pool drain];
  return 0;
}



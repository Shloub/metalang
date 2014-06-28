#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

void foo(int a){
  a = 4;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int a = 0;
  foo(a);
  printf("%d\n", a);
  [pool drain];
  return 0;
}



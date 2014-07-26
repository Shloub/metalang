#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

void foo(int i){
  printf("%d\n", i);
}

void foobar(int i){
  printf("%d\nfoobar", i);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int a = 0;
  printf("%d\n", a);
  int b = 12;
  printf("%d\nfoobar", b);
  int c = 1;
  printf("%d\n", c);
  [pool drain];
  return 0;
}



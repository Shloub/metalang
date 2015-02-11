#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  printf("Hello World");
  int a = 5;
  printf("%d \n%dfoo", (4 + 6) * 2, a);
  [pool drain];
  return 0;
}



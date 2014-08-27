#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int b;
  scanf("%d ", &b);
  int len = b;
  printf("%d\n", len);
  [pool drain];
  return 0;
}



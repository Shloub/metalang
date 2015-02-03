#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int len;
  scanf("%d ", &len);
  printf("%d\n", len);
  [pool drain];
  return 0;
}



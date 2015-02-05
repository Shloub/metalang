#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i, b, a;
  for (i = 1 ; i <= 3; i++)
  {
    scanf("%d %d ", &a, &b);
    printf("a = %d b = %d\n", a, b);
  }
  [pool drain];
  return 0;
}



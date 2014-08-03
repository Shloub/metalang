#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  if (1)
    printf("true <-\n ->\n");
  else
    printf("false <-\n ->\n");
  printf("small test end\n");
  [pool drain];
  return 0;
}



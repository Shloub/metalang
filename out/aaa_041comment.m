#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i = 4;
  /*while i < 10 do */
  printf("%d", i);
  i++;
  /*  end */
  printf("%d", i);
  [pool drain];
  return 0;
}



#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  printf("tada ' \" \n\r\t $ & todo\n\n{foo} \\${blah}\nblah\n");
  [pool drain];
  return 0;
}



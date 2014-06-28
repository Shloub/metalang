#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  printf("ma petite chaine en or");
  [pool drain];
  return 0;
}



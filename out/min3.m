#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int min2_(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  printf("%d %d %d %d %d %d\n", min2_(min2_(2, 3), 4), min2_(min2_(2, 4), 3), min2_(
                                                                              min2_(3, 2), 4), min2_(
                                                                                min2_(3, 4), 2), min2_(
                                                                                min2_(4, 2), 3), min2_(
                                                                                min2_(4, 3), 2));
  [pool drain];
  return 0;
}



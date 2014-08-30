#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  printf("%d %d %d %d %d %d\n%d %d %d %d %d %d\n%d %d %d %d %d %d\n%d %d %d %d %d %d\n", min2(min2(min2(1, 2), 3), 4), min2(min2(min2(1, 2), 4), 3), min2(min2(min2(1, 3), 2), 4), min2(min2(min2(1, 3), 4), 2), min2(min2(min2(1, 4), 2), 3), min2(min2(min2(1, 4), 3), 2), min2(min2(min2(2, 1), 3), 4), min2(min2(min2(2, 1), 4), 3), min2(min2(min2(2, 3), 1), 4), min2(min2(min2(2, 3), 4), 1), min2(min2(min2(2, 4), 1), 3), min2(min2(min2(2, 4), 3), 1), min2(min2(min2(3, 1), 2), 4), min2(min2(min2(3, 1), 4), 2), min2(min2(min2(3, 2), 1), 4), min2(min2(min2(3, 2), 4), 1), min2(min2(min2(3, 4), 1), 2), min2(min2(min2(3, 4), 2), 1), min2(min2(min2(4, 1), 2), 3), min2(min2(min2(4, 1), 3), 2), min2(min2(min2(4, 2), 1), 3), min2(min2(min2(4, 2), 3), 1), min2(min2(min2(4, 3), 1), 2), min2(min2(min2(4, 3), 2), 1));
  [pool drain];
  return 0;
}



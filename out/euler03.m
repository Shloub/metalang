#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int maximum = 1;
  int b0 = 2;
  int a = 408464633;
  while (a != 1)
  {
    int b = b0;
    int found = 0;
    while (b * b < a)
    {
      if ((a % b) == 0)
      {
        a /= b;
        b0 = b;
        b = a;
        found = 1;
      }
      b ++;
    }
    if (!found)
    {
      printf("%d\n", a);
      a = 1;
    }
  }
  [pool drain];
  return 0;
}



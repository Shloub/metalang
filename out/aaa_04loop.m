#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int j = 0;
  {
    int k;
    for (k = 0 ; k <= 10; k++)
    {
      j += k;
      printf("%d\n", j);
    }
  }
  int i = 4;
  while (i < 10)
  {
    printf("%d", i);
    i ++;
    j += i;
  }
  printf("%d%dFIN TEST\n", j, i);
  [pool drain];
  return 0;
}


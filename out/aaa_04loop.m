#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int h(int i){
  /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
  int j = i - 2;
  while (j <= i + 2)
  {
    if ((i % j) == 5)
      return 1;
    j ++;
  }
  return 0;
}

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



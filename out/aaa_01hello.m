#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  printf("Hello World");
  int a = 5;
  printf("%d \n%dfoo", (4 + 6) * 2, a);
  if (1 + 2 * 2 * (3 + 8) / 4 - 2 == 12 && 1)
      printf("True");
  else
      printf("False");
  printf("\n");
  if ((3 * (4 + 11) * 2 == 45) == 0)
      printf("True");
  else
      printf("False");
  printf(" ");
  if ((2 == 1) == 0)
      printf("True");
  else
      printf("False");
  printf(" %d%d", 5 / 3 / 3, 4 * 1 / 3 / 2 * 1);
  if (!(!(a == 0) && !(a == 4)))
      printf("True");
  else
      printf("False");
  if (1 && !0 && !(1 && 0))
      printf("True");
  else
      printf("False");
  printf("\n");
  [pool drain];
  return 0;
}



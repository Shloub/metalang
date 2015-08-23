#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int j, c, i, b, a;
  for (i = 1 ; i <= 3; i++)
  {
    scanf("%d %d ", &a, &b);
    printf("a = %d b = %d\n", a, b);
  }
  int *l = calloc( 10 , sizeof(int));
  for (c = 0 ; c < 10; c++)
  {
    scanf("%d ", &l[c]);
  }
  for (j = 0 ; j <= 9; j++)
    printf("%d\n", l[j]);
  [pool drain];
  return 0;
}



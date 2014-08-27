#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i, d;
  char *c = malloc( 12 * sizeof(char));
  for (d = 0 ; d < 12; d++)
    scanf("%c", &c[d]);
  scanf(" ");
  char* str = c;
  for (i = 0 ; i <= 11; i++)
    printf("%c", str[i]);
  [pool drain];
  return 0;
}



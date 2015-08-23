#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i, a;
  char *str = calloc( 12 , sizeof(char));
  for (a = 0 ; a < 12; a++)
  {
    scanf("%c", &str[a]);
  }
  scanf(" ");
  for (i = 0 ; i <= 11; i++)
    printf("%c", str[i]);
  [pool drain];
  return 0;
}



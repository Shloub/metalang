#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int g(int i) {
    int j = i * 4;
    if (j % 2 == 1)
        return 0;
    return j;
}


void h(int i) {
    printf("%d\n", i);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  h(14);
  int a = 4;
  int b = 5;
  printf("%d", a + b);
  /* main */
  h(15);
  a = 2;
  b = 1;
  printf("%d", a + b);
  [pool drain];
  return 0;
}



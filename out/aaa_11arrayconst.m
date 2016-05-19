#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


void test(int* tab, int len) {
    int i;
    for (i = 0; i < len; i++)
      printf("%d ", tab[i]);
    printf("\n");
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i;
  int *t = calloc( 5 , sizeof(int));
  for (i = 0; i < 5; i++)
    t[i] = 1;
  test(t, 5);
  [pool drain];
  return 0;
}



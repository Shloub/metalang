#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/*
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
*/
int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int j = 0;
  j = 0;
  printf("%d\n", j);
  j = 1;
  printf("%d\n", j);
  j = 2;
  printf("%d\n", j);
  j = 3;
  printf("%d\n", j);
  j = 4;
  printf("%d\n", j);
  [pool drain];
  return 0;
}



#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int* id_(int* b){
  return b;
}

void g(int* t, int index){
  t[index] = 0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i;
  int *a = malloc( 5 * sizeof(int));
  for (i = 0 ; i < 5; i++)
  {
    printf("%d", i);
    a[i] = (i % 2) == 0;
  }
  int c = a[0];
  if (c)
    printf("True");
  else
    printf("False");
  printf("\n");
  g(id_(a), 0);
  int d = a[0];
  if (d)
    printf("True");
  else
    printf("False");
  printf("\n");
  [pool drain];
  return 0;
}



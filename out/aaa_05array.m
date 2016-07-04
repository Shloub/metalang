#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int* id0(int* b) {
    return b;
}


void g(int* t, int index) {
    t[index] = 0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i;
  int j = 0;
  int *a = calloc(5, sizeof(int));
  for (i = 0; i < 5; i++)
  {
      printf("%d", i);
      j += i;
      a[i] = i % 2 == 0;
  }
  printf("%d ", j);
  if (a[0])
      printf("True");
  else
      printf("False");
  printf("\n");
  g(id0(a), 0);
  if (a[0])
      printf("True");
  else
      printf("False");
  printf("\n");
  [pool drain];
  return 0;
}



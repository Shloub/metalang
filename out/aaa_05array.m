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
  int c = 5;
  int *a = malloc( c * sizeof(int));
  {
    int i;
    for (i = 0 ; i < c; i++)
    {
      printf("%d", i);
      a[i] = (i % 2) == 0;
    }
  }
  int d = a[0];
  if (d)
    printf("True");
  else
    printf("False");
  printf("\n");
  g(id_(a), 0);
  int e = a[0];
  if (e)
    printf("True");
  else
    printf("False");
  printf("\n");
  [pool drain];
  return 0;
}



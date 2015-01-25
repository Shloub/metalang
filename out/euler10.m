#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int eratostene(int* t, int max0){
  int i;
  int sum = 0;
  for (i = 2 ; i < max0; i++)
    if (t[i] == i)
  {
    sum += i;
    if (max0 / i > i)
    {
      int j = i * i;
      while (j < max0 && j > 0)
      {
        t[j] = 0;
        j += i;
      }
    }
  }
  return sum;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i;
  int n = 100000;
  /* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
  int *t = malloc( n * sizeof(int));
  for (i = 0 ; i < n; i++)
    t[i] = i;
  t[1] = 0;
  printf("%d\n", eratostene(t, n));
  [pool drain];
  return 0;
}



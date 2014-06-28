#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int eratostene(int* t, int max_){
  int sum = 0;
  {
    int i;
    for (i = 2 ; i < max_; i++)
      if (t[i] == i)
    {
      sum += i;
      int j = i * i;
      /*
			detect overflow
			*/
      if (j / i == i)
        while (j < max_ && j > 0)
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
  int n = 100000;
  /* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
  int *t = malloc( n * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n; i++)
      t[i] = i;
  }
  t[1] = 0;
  int a = eratostene(t, n);
  printf("%d\n", a);
  [pool drain];
  return 0;
}



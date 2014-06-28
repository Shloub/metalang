#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/*
La suite de fibonaci
*/
int fibo(int a, int b, int i){
  int out_ = 0;
  int a2 = a;
  int b2 = b;
  {
    int j;
    for (j = 0 ; j <= i + 1; j++)
    {
      printf("%d", j);
      out_ += a2;
      int tmp = b2;
      b2 += a2;
      a2 = tmp;
    }
  }
  return out_;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int c = fibo(1, 2, 4);
  printf("%d", c);
  [pool drain];
  return 0;
}



#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int lim = 100;
  int sum = (lim * (lim + 1)) / 2;
  int carressum = sum * sum;
  int sumcarres = (lim * (lim + 1) * (2 * lim + 1)) / 6;
  int a = carressum - sumcarres;
  printf("%d", a);
  [pool drain];
  return 0;
}



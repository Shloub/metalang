#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int e = 2;
  int f = 3;
  int g = 4;
  printf("%d ", min2(min2(e, f), g));
  int i = 2;
  int j = 4;
  int k = 3;
  printf("%d ", min2(min2(i, j), k));
  int m = 3;
  int n = 2;
  int o = 4;
  printf("%d ", min2(min2(m, n), o));
  int q = 3;
  int r = 4;
  int s = 2;
  printf("%d ", min2(min2(q, r), s));
  int u = 4;
  int v = 2;
  int w = 3;
  printf("%d ", min2(min2(u, v), w));
  int y = 4;
  int z = 3;
  int ba = 2;
  printf("%d\n", min2(min2(y, z), ba));
  [pool drain];
  return 0;
}



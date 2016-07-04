#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int next0(int n) {
    if (n % 2 == 0)
        return n / 2;
    else
        return 3 * n + 1;
}


int find(int n, int* m) {
    if (n == 1)
        return 1;
    else if (n >= 1000000)
        return 1 + find(next0(n), m);
    else if (m[n] != 0)
        return m[n];
    else
    {
        m[n] = 1 + find(next0(n), m);
        return m[n];
    }
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i, j;
  int *m = calloc(1000000, sizeof(int));
  for (j = 0; j < 1000000; j++)
      m[j] = 0;
  int max0 = 0;
  int maxi = 0;
  for (i = 1; i < 1000; i++)
  {
      /* normalement on met 999999 mais ça dépasse les int32... */
      int n2 = find(i, m);
      if (n2 > max0)
      {
          max0 = n2;
          maxi = i;
      }
  }
  printf("%d\n%d\n", max0, maxi);
  [pool drain];
  return 0;
}



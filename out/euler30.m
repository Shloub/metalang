#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int a, b, c, d, e, f, i;
  /*
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
*/
  int *p = malloc( 10 * sizeof(int));
  for (i = 0 ; i < 10; i++)
    p[i] = i * i * i * i * i;
  int sum = 0;
  for (a = 0 ; a <= 9; a++)
    for (b = 0 ; b <= 9; b++)
      for (c = 0 ; c <= 9; c++)
        for (d = 0 ; d <= 9; d++)
          for (e = 0 ; e <= 9; e++)
            for (f = 0 ; f <= 9; f++)
            {
              int s = p[a] + p[b] + p[c] + p[d] + p[e] + p[f];
              int r = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000;
              if (s == r && r != 1)
              {
                printf("%d%d%d%d%d%d %d\n", f, e, d, c, b, a, r);
                sum += r;
              }
  }
  printf("%d", sum);
  [pool drain];
  return 0;
}



#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i6, d7, d8, d9, d10, d5, i4, d3, d2, d1, i;
  /*
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.

d4 % 2 == 0
(d3 + d4 + d5) % 3 == 0
d6 = 5 ou d6 = 0
(d5 * 100 + d6 * 10 + d7  ) % 7 == 0
(d6 * 100 + d7 * 10 + d8  ) % 11 == 0
(d7 * 100 + d8 * 10 + d9  ) % 13 == 0
(d8 * 100 + d9 * 10 + d10 ) % 17 == 0


d4 % 2 == 0
d6 = 5 ou d6 = 0

(d3 + d4 + d5) % 3 == 0
(d5 * 2 + d6 * 3 + d7) % 7 == 0
*/
  int *allowed = calloc( 10 , sizeof(int));
  for (i = 0 ; i < 10; i++)
    allowed[i] = 1;
  for (i6 = 0 ; i6 <= 1; i6++)
  {
    int d6 = i6 * 5;
    if (allowed[d6])
    {
      allowed[d6] = 0;
      for (d7 = 0 ; d7 <= 9; d7++)
        if (allowed[d7])
      {
        allowed[d7] = 0;
        for (d8 = 0 ; d8 <= 9; d8++)
          if (allowed[d8])
        {
          allowed[d8] = 0;
          for (d9 = 0 ; d9 <= 9; d9++)
            if (allowed[d9])
          {
            allowed[d9] = 0;
            for (d10 = 1 ; d10 <= 9; d10++)
              if (allowed[d10] && (d6 * 100 + d7 * 10 + d8) % 11 == 0 && (d7 * 100 + d8 * 10 + d9) % 13 == 0 && (d8 * 100 + d9 * 10 + d10) % 17 == 0)
            {
              allowed[d10] = 0;
              for (d5 = 0 ; d5 <= 9; d5++)
                if (allowed[d5])
              {
                allowed[d5] = 0;
                if ((d5 * 100 + d6 * 10 + d7) % 7 == 0)
                  for (i4 = 0 ; i4 <= 4; i4++)
                  {
                    int d4 = i4 * 2;
                    if (allowed[d4])
                    {
                      allowed[d4] = 0;
                      for (d3 = 0 ; d3 <= 9; d3++)
                        if (allowed[d3])
                      {
                        allowed[d3] = 0;
                        if ((d3 + d4 + d5) % 3 == 0)
                          for (d2 = 0 ; d2 <= 9; d2++)
                            if (allowed[d2])
                        {
                          allowed[d2] = 0;
                          for (d1 = 0 ; d1 <= 9; d1++)
                            if (allowed[d1])
                          {
                            allowed[d1] = 0;
                            printf("%d%d%d%d%d%d%d%d%d%d + ", d1, d2, d3, d4, d5, d6, d7, d8, d9, d10);
                            allowed[d1] = 1;
                          }
                          allowed[d2] = 1;
                        }
                        allowed[d3] = 1;
                      }
                      allowed[d4] = 1;
                    }
                }
                allowed[d5] = 1;
              }
              allowed[d10] = 1;
            }
            allowed[d9] = 1;
          }
          allowed[d8] = 1;
        }
        allowed[d7] = 1;
      }
      allowed[d6] = 1;
    }
  }
  printf("%d\n", 0);
  [pool drain];
  return 0;
}



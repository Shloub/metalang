#include <stdio.h>
#include <stdlib.h>

/*
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.


(a * 10 + b) ( c * 100 + d * 10 + e) =
  a * c * 1000 +
  a * d * 100 +
  a * e * 10 +
  b * c * 100 +
  b * d * 10 +
  b * e
  => b != e != b * e % 10 ET
  a != d != (b * e / 10 + b * d + a * e ) % 10
*/

int okdigits(int* ok, int n) {
    if (n == 0)
      return 1;
    else
    {
        int digit = n % 10;
        if (ok[digit])
        {
            ok[digit] = 0;
            int o = okdigits(ok, n / 10);
            ok[digit] = 1;
            return o;
        }
        else
          return 0;
    }
}

int main(void) {
    int e, b, a, c, d, j, i;
    int count = 0;
    int *allowed = calloc( 10 , sizeof(int));
    for (i = 0; i <= 9; i++)
      allowed[i] = i != 0;
    int *counted = calloc( 100000 , sizeof(int));
    for (j = 0; j <= 99999; j++)
      counted[j] = 0;
    for (e = 1; e <= 9; e++)
    {
        allowed[e] = 0;
        for (b = 1; b <= 9; b++)
          if (allowed[b])
        {
            allowed[b] = 0;
            int be = b * e % 10;
            if (allowed[be])
            {
                allowed[be] = 0;
                for (a = 1; a <= 9; a++)
                  if (allowed[a])
                {
                    allowed[a] = 0;
                    for (c = 1; c <= 9; c++)
                      if (allowed[c])
                    {
                        allowed[c] = 0;
                        for (d = 1; d <= 9; d++)
                          if (allowed[d])
                        {
                            allowed[d] = 0;
                            /* 2 * 3 digits */
                            int product = (a * 10 + b) * (c * 100 + d * 10 + e);
                            if (!counted[product] && okdigits(allowed, product / 10))
                            {
                                counted[product] = 1;
                                count += product;
                                printf("%d ", product);
                            }
                            /* 1  * 4 digits */
                            int product2 = b * (a * 1000 + c * 100 + d * 10 + e);
                            if (!counted[product2] && okdigits(allowed, product2 / 10))
                            {
                                counted[product2] = 1;
                                count += product2;
                                printf("%d ", product2);
                            }
                            allowed[d] = 1;
                        }
                        allowed[c] = 1;
                    }
                    allowed[a] = 1;
                }
                allowed[be] = 1;
            }
            allowed[b] = 1;
        }
        allowed[e] = 1;
    }
    printf("%d\n", count);
    return 0;
}



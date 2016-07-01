import java.util.*

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
boolean okdigits(boolean[] ok, int n)
{
  if (n == 0)
      return true
  else
  {
      int digit = n % 10
      if (ok[digit])
      {
          ok[digit] = false
          boolean o = okdigits(ok, n.intdiv(10))
          ok[digit] = true
          return o
      }
      else
          return false
  }
}



int count = 0
boolean[] allowed = new boolean[10]
for (int i = 0; i < 10; i += 1)
    allowed[i] = i != 0
boolean[] counted = new boolean[100000]
for (int j = 0; j < 100000; j += 1)
    counted[j] = false
for (int e = 1; e <= 9; e += 1)
{
    allowed[e] = false
    for (int b = 1; b <= 9; b += 1)
        if (allowed[b])
        {
            allowed[b] = false
            int be = b * e % 10
            if (allowed[be])
            {
                allowed[be] = false
                for (int a = 1; a <= 9; a += 1)
                    if (allowed[a])
                    {
                        allowed[a] = false
                        for (int c = 1; c <= 9; c += 1)
                            if (allowed[c])
                            {
                                allowed[c] = false
                                for (int d = 1; d <= 9; d += 1)
                                    if (allowed[d])
                                    {
                                        allowed[d] = false
                                        /* 2 * 3 digits */
                                        int product = (a * 10 + b) * (c * 100 + d * 10 + e)
                                        if (!counted[product] && okdigits(allowed, product.intdiv(10)))
                                        {
                                            counted[product] = true
                                            count += product
                                            System.out.printf("%d ", product)
                                        }
                                        /* 1  * 4 digits */
                                        int product2 = b * (a * 1000 + c * 100 + d * 10 + e)
                                        if (!counted[product2] && okdigits(allowed, product2.intdiv(10)))
                                        {
                                            counted[product2] = true
                                            count += product2
                                            System.out.printf("%d ", product2)
                                        }
                                        allowed[d] = true
                                    }
                                allowed[c] = true
                            }
                        allowed[a] = true
                    }
                allowed[be] = true
            }
            allowed[b] = true
        }
    allowed[e] = true
}
System.out.printf("%d\n", count)


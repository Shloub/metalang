#include <iostream>
#include <vector>
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
bool okdigits(std::vector<bool> * ok, int n) {
  if (n == 0)
    return true;
  else
  {
    int digit = n % 10;
    if (ok->at(digit))
    {
      ok->at(digit) = false;
      bool o = okdigits(ok, n / 10);
      ok->at(digit) = true;
      return o;
    }
    else
      return false;
  }
}


int main() {
  int count = 0;
  std::vector<bool> *allowed = new std::vector<bool>( 10 );
  for (int i = 0; i < 10; i++)
    allowed->at(i) = i != 0;
  std::vector<bool> *counted = new std::vector<bool>( 100000 );
  std::fill(counted->begin(), counted->end(), false);
  for (int e = 1; e <= 9; e ++)
  {
    allowed->at(e) = false;
    for (int b = 1; b <= 9; b ++)
      if (allowed->at(b))
    {
      allowed->at(b) = false;
      int be = b * e % 10;
      if (allowed->at(be))
      {
        allowed->at(be) = false;
        for (int a = 1; a <= 9; a ++)
          if (allowed->at(a))
        {
          allowed->at(a) = false;
          for (int c = 1; c <= 9; c ++)
            if (allowed->at(c))
          {
            allowed->at(c) = false;
            for (int d = 1; d <= 9; d ++)
              if (allowed->at(d))
            {
              allowed->at(d) = false;
              /* 2 * 3 digits */
              int product = (a * 10 + b) * (c * 100 + d * 10 + e);
              if (!counted->at(product) && okdigits(allowed, product / 10))
              {
                counted->at(product) = true;
                count += product;
                std::cout << product << " ";
              }
              /* 1  * 4 digits */
              int product2 = b * (a * 1000 + c * 100 + d * 10 + e);
              if (!counted->at(product2) && okdigits(allowed, product2 / 10))
              {
                counted->at(product2) = true;
                count += product2;
                std::cout << product2 << " ";
              }
              allowed->at(d) = true;
            }
            allowed->at(c) = true;
          }
          allowed->at(a) = true;
        }
        allowed->at(be) = true;
      }
      allowed->at(b) = true;
    }
    allowed->at(e) = true;
  }
  std::cout << count << "\n";
}


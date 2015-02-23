var util = require("util");
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
function okdigits(ok, n){
  if (n == 0)
    return 1;
  else
  {
    var digit = ~~(n % 10);
    if (ok[digit])
    {
      ok[digit] = 0;
      var o = okdigits(ok, ~~(n / 10));
      ok[digit] = 1;
      return o;
    }
    else
      return 0;
  }
}

var count = 0;
var allowed = new Array(10);
for (var i = 0 ; i <= 10 - 1; i++)
  allowed[i] = i != 0;
var counted = new Array(100000);
for (var j = 0 ; j <= 100000 - 1; j++)
  counted[j] = 0;
for (var e = 1 ; e <= 9; e++)
{
  allowed[e] = 0;
  for (var b = 1 ; b <= 9; b++)
    if (allowed[b])
  {
    allowed[b] = 0;
    var be = ~~((b * e) % 10);
    if (allowed[be])
    {
      allowed[be] = 0;
      for (var a = 1 ; a <= 9; a++)
        if (allowed[a])
      {
        allowed[a] = 0;
        for (var c = 1 ; c <= 9; c++)
          if (allowed[c])
        {
          allowed[c] = 0;
          for (var d = 1 ; d <= 9; d++)
            if (allowed[d])
          {
            allowed[d] = 0;
            /* 2 * 3 digits */
            var product = (a * 10 + b) * (c * 100 + d * 10 + e);
            if (!counted[product] && okdigits(allowed, ~~(product / 10)))
            {
              counted[product] = 1;
              count += product;
              util.print(product, " ");
            }
            /* 1  * 4 digits */
            var product2 = b * (a * 1000 + c * 100 + d * 10 + e);
            if (!counted[product2] && okdigits(allowed, ~~(product2 / 10)))
            {
              counted[product2] = 1;
              count += product2;
              util.print(product2, " ");
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
util.print(count, "\n");

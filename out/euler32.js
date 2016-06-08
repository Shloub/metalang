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

function okdigits(ok, n) {
    if (n == 0)
        return true;
    else
    {
        var digit = ~~(n % 10);
        if (ok[digit])
        {
            ok[digit] = false;
            var o = okdigits(ok, ~~(n / 10));
            ok[digit] = true;
            return o;
        }
        else
            return false;
    }
}

var count = 0;
var allowed = new Array(10);
for (var i = 0; i < 10; i += 1)
    allowed[i] = i != 0;
var counted = new Array(100000);
for (var j = 0; j < 100000; j += 1)
    counted[j] = false;
for (var e = 1; e <= 9; e += 1)
{
    allowed[e] = false;
    for (var b = 1; b <= 9; b += 1)
        if (allowed[b])
        {
            allowed[b] = false;
            var be = ~~(b * e % 10);
            if (allowed[be])
            {
                allowed[be] = false;
                for (var a = 1; a <= 9; a += 1)
                    if (allowed[a])
                    {
                        allowed[a] = false;
                        for (var c = 1; c <= 9; c += 1)
                            if (allowed[c])
                            {
                                allowed[c] = false;
                                for (var d = 1; d <= 9; d += 1)
                                    if (allowed[d])
                                    {
                                        allowed[d] = false;
                                        /* 2 * 3 digits */
                                        var product = (a * 10 + b) * (c * 100 + d * 10 + e);
                                        if (!counted[product] && okdigits(allowed, ~~(product / 10)))
                                        {
                                            counted[product] = true;
                                            count += product;
                                            util.print(product, " ");
                                        }
                                        /* 1  * 4 digits */
                                        var product2 = b * (a * 1000 + c * 100 + d * 10 + e);
                                        if (!counted[product2] && okdigits(allowed, ~~(product2 / 10)))
                                        {
                                            counted[product2] = true;
                                            count += product2;
                                            util.print(product2, " ");
                                        }
                                        allowed[d] = true;
                                    }
                                allowed[c] = true;
                            }
                        allowed[a] = true;
                    }
                allowed[be] = true;
            }
            allowed[b] = true;
        }
    allowed[e] = true;
}
util.print(count, "\n");


<?php
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
function okdigits(&$ok, $n) {
    if ($n == 0)
        return true;
    else
    {
        $digit = $n % 10;
        if ($ok[$digit])
        {
            $ok[$digit] = false;
            $o = okdigits($ok, intval($n / 10));
            $ok[$digit] = true;
            return $o;
        }
        else
            return false;
    }
}

$count = 0;
$allowed = array();
for ($i = 0; $i < 10; $i++)
    $allowed[$i] = $i != 0;
$counted = array_fill(0, 100000, false);
for ($e = 1; $e < 10; $e++)
{
    $allowed[$e] = false;
    for ($b = 1; $b < 10; $b++)
        if ($allowed[$b])
        {
            $allowed[$b] = false;
            $be = $b * $e % 10;
            if ($allowed[$be])
            {
                $allowed[$be] = false;
                for ($a = 1; $a < 10; $a++)
                    if ($allowed[$a])
                    {
                        $allowed[$a] = false;
                        for ($c = 1; $c < 10; $c++)
                            if ($allowed[$c])
                            {
                                $allowed[$c] = false;
                                for ($d = 1; $d < 10; $d++)
                                    if ($allowed[$d])
                                    {
                                        $allowed[$d] = false;
                                        /* 2 * 3 digits */
                                        $product = ($a * 10 + $b) * ($c * 100 + $d * 10 + $e);
                                        if (!$counted[$product] && okdigits($allowed, intval($product / 10)))
                                        {
                                            $counted[$product] = true;
                                            $count += $product;
                                            echo $product, " ";
                                        }
                                        /* 1  * 4 digits */
                                        $product2 = $b * ($a * 1000 + $c * 100 + $d * 10 + $e);
                                        if (!$counted[$product2] && okdigits($allowed, intval($product2 / 10)))
                                        {
                                            $counted[$product2] = true;
                                            $count += $product2;
                                            echo $product2, " ";
                                        }
                                        $allowed[$d] = true;
                                    }
                                $allowed[$c] = true;
                            }
                        $allowed[$a] = true;
                    }
                $allowed[$be] = true;
            }
            $allowed[$b] = true;
        }
    $allowed[$e] = true;
}
echo $count, "\n";


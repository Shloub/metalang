<?php

function &primesfactors($n) {
    $tab = array_fill(0, $n + 1, 0);
    $d = 2;
    while ($n != 1 && $d * $d <= $n)
        if ($n % $d == 0)
        {
            $tab[$d] += 1;
            $n = intval($n / $d);
        }
        else
            $d += 1;
    $tab[$n] += 1;
    return $tab;
}

$lim = 20;
$o = array_fill(0, $lim + 1, 0);
for ($i = 1; $i <= $lim; $i += 1)
{
    $t = primesfactors($i);
    for ($j = 1; $j <= $i; $j += 1)
        $o[$j] = max($o[$j], $t[$j]);
}
$product = 1;
for ($k = 1; $k <= $lim; $k += 1)
    for ($l = 1; $l <= $o[$k]; $l += 1)
        $product *= $k;
echo $product, "\n";


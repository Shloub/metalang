<?php
function &primesfactors($n) {
    $tab = array_fill(0, $n + 1, 0);
    $d = 2;
    while ($n != 1 && $d * $d <= $n)
        if ($n % $d == 0)
        {
            $tab[$d]++;
            $n = intval($n / $d);
        }
        else
            $d++;
    $tab[$n]++;
    return $tab;
}
$lim = 20;
$o = array_fill(0, $lim + 1, 0);
for ($i = 1; $i <= $lim; $i++)
{
    $t = primesfactors($i);
    for ($j = 1; $j <= $i; $j++)
        $o[$j] = max($o[$j], $t[$j]);
}
$product = 1;
for ($k = 1; $k <= $lim; $k++)
    for ($l = 1; $l <= $o[$k]; $l++)
        $product *= $k;
echo $product, "\n";


<?php
function next0($n) {
    if ($n % 2 == 0)
        return intval($n / 2);
    else
        return 3 * $n + 1;
}

function find($n, &$m) {
    if ($n == 1)
        return 1;
    else if ($n >= 1000000)
        return 1 + find(next0($n), $m);
    else if ($m[$n] != 0)
        return $m[$n];
    else
    {
        $m[$n] = 1 + find(next0($n), $m);
        return $m[$n];
    }
}

$m = array_fill(0, 1000000, 0);
$max0 = 0;
$maxi = 0;
for ($i = 1; $i <= 999; $i += 1)
{
    /* normalement on met 999999 mais ça dépasse les int32... */
    $n2 = find($i, $m);
    if ($n2 > $max0)
    {
        $max0 = $n2;
        $maxi = $i;
    }
}
echo $max0, "\n", $maxi, "\n";


<?php
$t = array_fill(0, 1001, 0);
for ($a = 1; $a < 1001; $a += 1)
    for ($b = 1; $b < 1001; $b += 1)
    {
        $c2 = $a * $a + $b * $b;
        $c = intval(sqrt($c2));
        if ($c * $c == $c2)
        {
            $p = $a + $b + $c;
            if ($p < 1001)
                $t[$p] += 1;
        }
    }
$j = 0;
for ($k = 1; $k < 1001; $k += 1)
    if ($t[$k] > $t[$j])
        $j = $k;
echo $j;


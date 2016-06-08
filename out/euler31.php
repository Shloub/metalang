<?php

function result($sum, &$t, $maxIndex, &$cache) {
    if ($cache[$sum][$maxIndex] != 0)
        return $cache[$sum][$maxIndex];
    else
        if ($sum == 0 || $maxIndex == 0)
            return 1;
        else
        {
            $out0 = 0;
            $div = intval($sum / $t[$maxIndex]);
            for ($i = 0; $i <= $div; $i += 1)
                $out0 += result($sum - $i * $t[$maxIndex], $t, $maxIndex - 1, $cache);
            $cache[$sum][$maxIndex] = $out0;
            return $out0;
        }
}

$t = array_fill(0, 8, 0);
$t[0] = 1;
$t[1] = 2;
$t[2] = 5;
$t[3] = 10;
$t[4] = 20;
$t[5] = 50;
$t[6] = 100;
$t[7] = 200;
$cache = array();
for ($j = 0; $j < 201; $j += 1)
{
    $o = array_fill(0, 8, 0);
    $cache[$j] = $o;
}
echo result(200, $t, 7, $cache);


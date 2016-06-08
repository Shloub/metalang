<?php

function divisible($n, &$t, $size) {
    for ($i = 0; $i < $size; $i += 1)
        if ($n % $t[$i] == 0)
            return true;
    return false;
}


function find($n, &$t, $used, $nth) {
    while ($used != $nth)
        if (divisible($n, $t, $used))
            $n += 1;
        else
        {
            $t[$used] = $n;
            $n += 1;
            $used += 1;
        }
    return $t[$used - 1];
}

$n = 10001;
$t = array_fill(0, $n, 2);
echo find(3, $t, 1, $n), "\n";


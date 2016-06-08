<?php

function fact($n) {
    $prod = 1;
    for ($i = 2; $i <= $n; $i += 1)
        $prod *= $i;
    return $prod;
}


function show($lim, $nth) {
    $t = array();
    for ($i = 0; $i < $lim; $i += 1)
        $t[$i] = $i;
    $pris = array_fill(0, $lim, false);
    for ($k = 1; $k < $lim; $k += 1)
    {
        $n = fact($lim - $k);
        $nchiffre = intval($nth / $n);
        $nth = $nth % $n;
        for ($l = 0; $l < $lim; $l += 1)
            if (!$pris[$l])
            {
                if ($nchiffre == 0)
                {
                    echo $l;
                    $pris[$l] = true;
                }
                $nchiffre -= 1;
            }
    }
    for ($m = 0; $m < $lim; $m += 1)
        if (!$pris[$m])
            echo $m;
    echo "\n";
}

show(10, 999999);


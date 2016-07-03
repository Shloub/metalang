<?php
function fact($n) {
    $prod = 1;
    for ($i = 2; $i <= $n; $i++)
        $prod *= $i;
    return $prod;
}

function show($lim, $nth) {
    $t = array();
    for ($i = 0; $i < $lim; $i++)
        $t[$i] = $i;
    $pris = array_fill(0, $lim, false);
    for ($k = 1; $k < $lim; $k++)
    {
        $n = fact($lim - $k);
        $nchiffre = intval($nth / $n);
        $nth = $nth % $n;
        for ($l = 0; $l < $lim; $l++)
            if (!$pris[$l])
            {
                if ($nchiffre == 0)
                {
                    echo $l;
                    $pris[$l] = true;
                }
                $nchiffre--;
            }
    }
    for ($m = 0; $m < $lim; $m++)
        if (!$pris[$m])
            echo $m;
    echo "\n";
}

show(10, 999999);


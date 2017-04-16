<?php
function dichofind($len, &$tab, $tofind, $a, $b) {
    if ($a >= $b - 1)
        return $a;
    else
    {
        $c = intval(($a + $b) / 2);
        if ($tab[$c] < $tofind)
            return dichofind($len, $tab, $tofind, $c, $b);
        else
            return dichofind($len, $tab, $tofind, $a, $c);
    }
}

function process($len, &$tab) {
    $size = array();
    for ($j = 0; $j < $len; $j++)
        if ($j == 0)
            $size[$j] = 0;
        else
            $size[$j] = $len * 2;
    for ($i = 0; $i < $len; $i++)
    {
        $k = dichofind($len, $size, $tab[$i], 0, $len - 1);
        if ($size[$k + 1] > $tab[$i])
            $size[$k + 1] = $tab[$i];
    }
    for ($l = 0; $l < $len; $l++)
        echo $size[$l], " ";
    for ($m = 0; $m < $len; $m++)
    {
        $k = $len - 1 - $m;
        if ($size[$k] != $len * 2)
            return $k;
    }
    return 0;
}
$n = intval(trim(fgets(STDIN)));
for ($i = 1; $i <= $n; $i++)
{
    $len = intval(trim(fgets(STDIN)));
    echo process($len, array_map("intval", explode(" ", fgets(STDIN)))), "\n";
}


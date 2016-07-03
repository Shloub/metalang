<?php
function find($n, &$m, $x, $y, $dx, $dy) {
    if ($x < 0 || $x == 20 || $y < 0 || $y == 20)
        return -1;
    else if ($n == 0)
        return 1;
    else
        return $m[$y][$x] * find($n - 1, $m, $x + $dx, $y + $dy, $dx, $dy);
}

$directions = array();
for ($i = 0; $i < 8; $i += 1)
    if ($i == 0)
        $directions[$i] = array(0, 1);
    else if ($i == 1)
        $directions[$i] = array(1, 0);
    else if ($i == 2)
        $directions[$i] = array(0, -1);
    else if ($i == 3)
        $directions[$i] = array(-1, 0);
    else if ($i == 4)
        $directions[$i] = array(1, 1);
    else if ($i == 5)
        $directions[$i] = array(1, -1);
    else if ($i == 6)
        $directions[$i] = array(-1, 1);
    else
        $directions[$i] = array(-1, -1);
$max0 = 0;
$m = array();
for ($c = 0; $c < 20; $c += 1)
    $m[$c] = array_map("intval", explode(" ", fgets(STDIN)));
for ($j = 0; $j < 8; $j += 1)
{
    list($dx, $dy) = $directions[$j];
    for ($x = 0; $x < 20; $x += 1)
        for ($y = 0; $y < 20; $y += 1)
            $max0 = max($max0, find(4, $m, $x, $y, $dx, $dy));
}
echo $max0, "\n";


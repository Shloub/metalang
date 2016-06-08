<?php
$x = intval(trim(fgets(STDIN)));
$y = intval(trim(fgets(STDIN)));
$tab = array();
for ($d = 0; $d < $y; $d += 1)
    $tab[$d] = array_map("intval", explode(" ", fgets(STDIN)));
for ($ix = 1; $ix < $x; $ix += 1)
    for ($iy = 1; $iy < $y; $iy += 1)
        if ($tab[$iy][$ix] == 1)
            $tab[$iy][$ix] = min($tab[$iy][$ix - 1], $tab[$iy - 1][$ix], $tab[$iy - 1][$ix - 1]) + 1;
for ($jy = 0; $jy < $y; $jy += 1)
{
    for ($jx = 0; $jx < $x; $jx += 1)
        echo $tab[$jy][$jx], " ";
    echo "\n";
}


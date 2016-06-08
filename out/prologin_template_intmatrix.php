<?php

function programme_candidat(&$tableau, $x, $y) {
    $out0 = 0;
    for ($i = 0; $i < $y; $i += 1)
        for ($j = 0; $j < $x; $j += 1)
            $out0 += $tableau[$i][$j] * ($i * 2 + $j);
    return $out0;
}

$taille_x = intval(trim(fgets(STDIN)));
$taille_y = intval(trim(fgets(STDIN)));
$tableau = array();
for ($a = 0; $a < $taille_y; $a += 1)
    $tableau[$a] = array_map("intval", explode(" ", fgets(STDIN)));
echo programme_candidat($tableau, $taille_x, $taille_y), "\n";


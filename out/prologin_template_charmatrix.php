<?php
function programme_candidat(&$tableau, $taille_x, $taille_y) {
    $out0 = 0;
    for ($i = 0; $i < $taille_y; $i += 1)
    {
        for ($j = 0; $j < $taille_x; $j += 1)
        {
            $out0 += ord($tableau[$i][$j]) * ($i + $j * 2);
            echo $tableau[$i][$j];
        }
        echo "--\n";
    }
    return $out0;
}

$taille_x = intval(trim(fgets(STDIN)));
$taille_y = intval(trim(fgets(STDIN)));
$a = array();
for ($b = 0; $b < $taille_y; $b += 1)
    $a[$b] = fgets(STDIN);
$tableau = $a;
echo programme_candidat($tableau, $taille_x, $taille_y), "\n";


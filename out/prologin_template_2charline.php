<?php
function programme_candidat(&$tableau1, $taille1, &$tableau2, $taille2) {
    $out0 = 0;
    for ($i = 0; $i < $taille1; $i++)
    {
        $out0 += ord($tableau1[$i]) * $i;
        echo $tableau1[$i];
    }
    echo "--\n";
    for ($j = 0; $j < $taille2; $j++)
    {
        $out0 += ord($tableau2[$j]) * $j * 100;
        echo $tableau2[$j];
    }
    echo "--\n";
    return $out0;
}

$taille1 = intval(trim(fgets(STDIN)));
$tableau1 = fgets(STDIN);
$taille2 = intval(trim(fgets(STDIN)));
$tableau2 = fgets(STDIN);
echo programme_candidat($tableau1, $taille1, $tableau2, $taille2), "\n";


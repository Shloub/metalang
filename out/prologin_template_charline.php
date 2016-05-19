<?php

function programme_candidat(&$tableau, $taille) {
    $out0 = 0;
    for ($i = 0; $i < $taille; $i++)
    {
        $out0 += ord($tableau[$i]) * $i;
        echo $tableau[$i];
    }
    echo "--\n";
    return $out0;
}

$taille = intval(trim(fgets(STDIN)));
$tableau = fgets(STDIN);
echo programme_candidat($tableau, $taille), "\n";


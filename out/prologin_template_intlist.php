<?php
function programme_candidat(&$tableau, $taille) {
    $out0 = 0;
    for ($i = 0; $i < $taille; $i += 1)
        $out0 += $tableau[$i];
    return $out0;
}

$taille = intval(trim(fgets(STDIN)));
$tableau = array_map("intval", explode(" ", fgets(STDIN)));
echo programme_candidat($tableau, $taille), "\n";


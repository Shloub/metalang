<?php
function programme_candidat(&$tableau, $x, $y){
  $out0 = 0;
  for ($i = 0 ; $i < $y; $i++)
    for ($j = 0 ; $j < $x; $j++)
      $out0 += $tableau[$i][$j] * ($i * 2 + $j);
  return $out0;
}

$taille_x = intval(trim(fgets(STDIN)));
$taille_y = intval(trim(fgets(STDIN)));
$e = array();
for ($f = 0 ; $f < $taille_y; $f++)
  $e[$f] = array_map("intval", explode(" ", fgets(STDIN)));
$tableau = $e;
echo programme_candidat($tableau, $taille_x, $taille_y), "\n";
?>

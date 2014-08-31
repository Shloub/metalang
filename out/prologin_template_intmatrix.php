<?php
function programme_candidat(&$tableau, $x, $y){
  $out_ = 0;
  for ($i = 0 ; $i < $y; $i++)
    for ($j = 0 ; $j < $x; $j++)
      $out_ += $tableau[$i][$j] * ($i * 2 + $j);
  return $out_;
}

$taille_x = intval(trim(fgets(STDIN)));
$taille_y = intval(trim(fgets(STDIN)));
$e = array();
for ($f = 0 ; $f < $taille_y; $f++)
  $e[$f] = array_map("intval", explode(" ", fgets(STDIN)));
$tableau = $e;
echo programme_candidat($tableau, $taille_x, $taille_y), "\n";
?>

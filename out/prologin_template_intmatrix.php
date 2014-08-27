<?php
function &read_int_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
    $tab[$z] = array_map("intval", explode(" ", fgets(STDIN)));
  return $tab;
}

function programme_candidat(&$tableau, $x, $y){
  $out_ = 0;
  for ($i = 0 ; $i < $y; $i++)
    for ($j = 0 ; $j < $x; $j++)
      $out_ += $tableau[$i][$j] * ($i * 2 + $j);
  return $out_;
}

$taille_x = intval(trim(fgets(STDIN)));
$taille_y = intval(trim(fgets(STDIN)));
$tableau = read_int_matrix($taille_x, $taille_y);
echo programme_candidat($tableau, $taille_x, $taille_y), "\n";
?>

<?php
function read_int(){
  return intval(trim(fgets(STDIN)));
}

function &read_int_line($n){
  return array_map("intval", explode(" ", fgets(STDIN)));
}

function &read_int_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
    $tab[$z] = read_int_line($x);
  return $tab;
}

function programme_candidat(&$tableau, $x, $y){
  $out_ = 0;
  for ($i = 0 ; $i < $y; $i++)
    for ($j = 0 ; $j < $x; $j++)
      $out_ += $tableau[$i][$j] * ($i * 2 + $j);
  return $out_;
}

$taille_x = read_int();
$taille_y = read_int();
$tableau = read_int_matrix($taille_x, $taille_y);
echo programme_candidat($tableau, $taille_x, $taille_y), "\n";
?>

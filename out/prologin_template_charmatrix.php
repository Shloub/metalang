<?php
function read_int(){
  return intval(trim(fgets(STDIN)));
}

function read_char_line($n){
  return fgets(STDIN);
}

function read_char_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
    $tab[$z] = read_char_line($x);
  return $tab;
}

function programme_candidat(&$tableau, $taille_x, $taille_y){
  $out_ = 0;
  for ($i = 0 ; $i < $taille_y; $i++)
  {
    for ($j = 0 ; $j < $taille_x; $j++)
    {
      $out_ += ord($tableau[$i][$j]) * ($i + $j * 2);
      $a = $tableau[$i][$j];
      echo $a;
    }
    echo "--\n";
  }
  return $out_;
}

$taille_x = read_int();
$taille_y = read_int();
$tableau = read_char_matrix($taille_x, $taille_y);
$b = programme_candidat($tableau, $taille_x, $taille_y);
echo $b, "\n";
?>

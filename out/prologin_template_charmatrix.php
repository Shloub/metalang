<?php
function &read_char_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
  {
    $a = fgets(STDIN);
    $tab[$z] = $a;
  }
  return $tab;
}

function programme_candidat(&$tableau, $taille_x, $taille_y){
  $out_ = 0;
  for ($i = 0 ; $i < $taille_y; $i++)
  {
    for ($j = 0 ; $j < $taille_x; $j++)
    {
      $out_ += ord($tableau[$i][$j]) * ($i + $j * 2);
      echo $tableau[$i][$j];
    }
    echo "--\n";
  }
  return $out_;
}

$taille_x = intval(trim(fgets(STDIN)));
$taille_y = intval(trim(fgets(STDIN)));
$tableau = read_char_matrix($taille_x, $taille_y);
echo programme_candidat($tableau, $taille_x, $taille_y), "\n";
?>

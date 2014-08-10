<?php
function read_int(){
  return intval(trim(fgets(STDIN)));
}

function &read_int_line($n){
  return array_map("intval", explode(" ", fgets(STDIN)));
}

function programme_candidat(&$tableau, $taille){
  $out_ = 0;
  for ($i = 0 ; $i < $taille; $i++)
    $out_ += $tableau[$i];
  return $out_;
}

$taille = read_int();
$tableau = read_int_line($taille);
echo programme_candidat($tableau, $taille), "\n";
?>

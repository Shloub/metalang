<?php
function read_int(){
  return intval(trim(fgets(STDIN)));
}

function &read_char_line($n){
  return fgets(STDIN);
}

function programme_candidat(&$tableau, $taille){
  $out_ = 0;
  for ($i = 0 ; $i < $taille; $i++)
  {
    $out_ += ord($tableau[$i]) * $i;
    echo $tableau[$i];
  }
  echo "--\n";
  return $out_;
}

$taille = read_int();
$tableau = read_char_line($taille);
echo programme_candidat($tableau, $taille), "\n";
?>

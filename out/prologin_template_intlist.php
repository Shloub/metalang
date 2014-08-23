<?php
function programme_candidat(&$tableau, $taille){
  $out_ = 0;
  for ($i = 0 ; $i < $taille; $i++)
    $out_ += $tableau[$i];
  return $out_;
}

$taille = intval(trim(fgets(STDIN)));
$tableau = array_map("intval", explode(" ", fgets(STDIN)));
echo programme_candidat($tableau, $taille), "\n";
?>

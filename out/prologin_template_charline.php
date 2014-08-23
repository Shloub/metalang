<?php
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

$taille = intval(trim(fgets(STDIN)));
$tableau = fgets(STDIN);
echo programme_candidat($tableau, $taille), "\n";
?>

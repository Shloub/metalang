<?php
function programme_candidat(&$tableau1, $taille1, &$tableau2, $taille2){
  $out_ = 0;
  for ($i = 0 ; $i < $taille1; $i++)
  {
    $out_ += ord($tableau1[$i]) * $i;
    echo $tableau1[$i];
  }
  echo "--\n";
  for ($j = 0 ; $j < $taille2; $j++)
  {
    $out_ += ord($tableau2[$j]) * $j * 100;
    echo $tableau2[$j];
  }
  echo "--\n";
  return $out_;
}

$taille1 = intval(trim(fgets(STDIN)));
$taille2 = intval(trim(fgets(STDIN)));
$tableau1 = fgets(STDIN);
$tableau2 = fgets(STDIN);
echo programme_candidat($tableau1, $taille1, $tableau2, $taille2), "\n";
?>

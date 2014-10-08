<?php
function programme_candidat(&$tableau, $taille_x, $taille_y){
  $out0 = 0;
  for ($i = 0 ; $i < $taille_y; $i++)
  {
    for ($j = 0 ; $j < $taille_x; $j++)
    {
      $out0 += ord($tableau[$i][$j]) * ($i + $j * 2);
      echo $tableau[$i][$j];
    }
    echo "--\n";
  }
  return $out0;
}

$taille_x = intval(trim(fgets(STDIN)));
$taille_y = intval(trim(fgets(STDIN)));
$e = array();
for ($f = 0 ; $f < $taille_y; $f++)
  $e[$f] = fgets(STDIN);
$tableau = $e;
echo programme_candidat($tableau, $taille_x, $taille_y), "\n";
?>

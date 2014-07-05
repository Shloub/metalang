<?php
function read_int(){
  return intval(trim(fgets(STDIN)));
}

function read_char_line($n){
  return fgets(STDIN);
}

function programme_candidat(&$tableau1, $taille1, &$tableau2, $taille2){
  $out_ = 0;
  for ($i = 0 ; $i < $taille1; $i++)
  {
    $out_ += ord($tableau1[$i]) * $i;
    $a = $tableau1[$i];
    echo $a;
  }
  echo "--\n";
  for ($j = 0 ; $j < $taille2; $j++)
  {
    $out_ += ord($tableau2[$j]) * $j * 100;
    $b = $tableau2[$j];
    echo $b;
  }
  echo "--\n";
  return $out_;
}

$taille1 = read_int();
$taille2 = read_int();
$tableau1 = read_char_line($taille1);
$tableau2 = read_char_line($taille2);
$c = programme_candidat($tableau1, $taille1, $tableau2, $taille2);
echo $c, "\n";
?>

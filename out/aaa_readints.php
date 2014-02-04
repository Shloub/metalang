<?php

function read_int_line($n){
  $a = array_map("intval", explode(" ", fgets(STDIN)));
  return $a;
}

function read_int_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
  {
    $out_ = read_int_line($x);
    $tab[$z] = $out_;
  }
  return $tab;
}

$l0 = read_int_line(1);
$len = $l0[0];
echo $len, "=len\n";
$tab1 = read_int_line($len);
for ($i = 0 ; $i < $len; $i++)
{
  echo $i, "=>";
  $b = $tab1[$i];
  echo $b, "\n";
}
$l0 = read_int_line(1);
$len = $l0[0];
$tab2 = read_int_matrix($len, $len - 1);
for ($i = 0 ; $i <= $len - 2; $i++)
{
  for ($j = 0 ; $j < $len; $j++)
  {
    $c = $tab2[$i][$j];
    echo $c, " ";
  }
  echo "\n";
}
?>

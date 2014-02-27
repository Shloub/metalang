<?php


function read_int(){
  return intval(trim(fgets(STDIN)));
}

function read_int_line($n){
  return array_map("intval", explode(" ", fgets(STDIN)));
}

function read_int_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
    $tab[$z] = read_int_line($x);
  return $tab;
}

$len = read_int();
echo $len, "=len\n";
$tab1 = read_int_line($len);
for ($i = 0 ; $i < $len; $i++)
{
  echo $i, "=>";
  $a = $tab1[$i];
  echo $a, "\n";
}
$len = read_int();
$tab2 = read_int_matrix($len, $len - 1);
for ($i = 0 ; $i <= $len - 2; $i++)
{
  for ($j = 0 ; $j < $len; $j++)
  {
    $b = $tab2[$i][$j];
    echo $b, " ";
  }
  echo "\n";
}
?>

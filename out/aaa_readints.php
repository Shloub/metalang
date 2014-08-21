<?php
function &read_int_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
  {
    $a = array_map("intval", explode(" ", fgets(STDIN)));
    $tab[$z] = $a;
  }
  return $tab;
}

$b = intval(trim(fgets(STDIN)));
$len = $b;
echo $len, "=len\n";
$c = array_map("intval", explode(" ", fgets(STDIN)));
$tab1 = $c;
for ($i = 0 ; $i < $len; $i++)
{
  echo $i, "=>", $tab1[$i], "\n";
}
$d = intval(trim(fgets(STDIN)));
$len = $d;
$tab2 = read_int_matrix($len, $len - 1);
for ($i = 0 ; $i <= $len - 2; $i++)
{
  for ($j = 0 ; $j < $len; $j++)
  {
    echo $tab2[$i][$j], " ";
  }
  echo "\n";
}
?>

<?php
function &read_int_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
    $tab[$z] = array_map("intval", explode(" ", fgets(STDIN)));
  return $tab;
}

$len = intval(trim(fgets(STDIN)));
echo $len, "=len\n";
$tab1 = array_map("intval", explode(" ", fgets(STDIN)));
for ($i = 0 ; $i < $len; $i++)
{
  echo $i, "=>", $tab1[$i], "\n";
}
$len = intval(trim(fgets(STDIN)));
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

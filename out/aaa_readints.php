<?php
$len = intval(trim(fgets(STDIN)));
echo $len, "=len\n";
$tab1 = array_map("intval", explode(" ", fgets(STDIN)));
for ($i = 0 ; $i < $len; $i++)
{
  echo $i, "=>", $tab1[$i], "\n";
}
$len = intval(trim(fgets(STDIN)));
$g = array();
for ($h = 0 ; $h < $len - 1; $h++)
  $g[$h] = array_map("intval", explode(" ", fgets(STDIN)));
$tab2 = $g;
for ($i = 0 ; $i <= $len - 2; $i++)
{
  for ($j = 0 ; $j < $len; $j++)
  {
    echo $tab2[$i][$j], " ";
  }
  echo "\n";
}
?>

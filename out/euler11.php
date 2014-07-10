<?php
function max2($a, $b){
  return max($a, $b);
}

function read_int_line($n){
  return array_map("intval", explode(" ", fgets(STDIN)));
}

function read_int_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
  {
    $d = array_map("intval", explode(" ", fgets(STDIN)));
    $tab[$z] = $d;
  }
  return $tab;
}

function find($n, &$m, $x, $y, $dx, $dy){
  if ($x < 0 || $x == 20 || $y < 0 || $y == 20)
    return -1;
  else if ($n == 0)
    return 1;
  else
    return $m[$y][$x] * find($n - 1, $m, $x + $dx, $y + $dy, $dx, $dy);
}

$c = 8;
$directions = array();
for ($i = 0 ; $i < $c; $i++)
  if ($i == 0)
  $directions[$i] = array(0, 1);
else if ($i == 1)
  $directions[$i] = array(1, 0);
else if ($i == 2)
  $directions[$i] = array(0, -1);
else if ($i == 3)
  $directions[$i] = array(-1, 0);
else if ($i == 4)
  $directions[$i] = array(1, 1);
else if ($i == 5)
  $directions[$i] = array(1, -1);
else if ($i == 6)
  $directions[$i] = array(-1, 1);
else
  $directions[$i] = array(-1, -1);
$max_ = 0;
$m = read_int_matrix(20, 20);
for ($j = 0 ; $j <= 7; $j++)
{
  list($dx, $dy) = $directions[$j];
  for ($x = 0 ; $x <= 19; $x++)
    for ($y = 0 ; $y <= 19; $y++)
      $max_ = max2($max_, find(4, $m, $x, $y, $dx, $dy));
}
echo $max_, "\n";
?>

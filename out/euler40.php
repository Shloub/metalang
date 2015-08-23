<?php
function exp0($a, $e){
  $o = 1;
  for ($i = 1 ; $i <= $e; $i++)
    $o *= $a;
  return $o;
}

function e(&$t, $n){
  for ($i = 1 ; $i <= 8; $i++)
    if ($n >= $t[$i] * $i)
    $n -= $t[$i] * $i;
  else
  {
    $nombre = exp0(10, $i - 1) + intval($n / $i);
    $chiffre = $i - 1 - $n % $i;
    return intval($nombre / exp0(10, $chiffre)) % 10;
  }
  return -1;
}

$t = array();
for ($i = 0 ; $i < 9; $i++)
  $t[$i] = exp0(10, $i) - exp0(10, $i - 1);
for ($i2 = 1 ; $i2 <= 8; $i2++)
  echo $i2, " => ", $t[$i2], "\n";
for ($j = 0 ; $j <= 80; $j++)
  echo e($t, $j);
echo "\n";
for ($k = 1 ; $k <= 50; $k++)
  echo $k;
echo "\n";
for ($j2 = 169 ; $j2 <= 220; $j2++)
  echo e($t, $j2);
echo "\n";
for ($k2 = 90 ; $k2 <= 110; $k2++)
  echo $k2;
echo "\n";
$out0 = 1;
for ($l = 0 ; $l <= 6; $l++)
{
  $puiss = exp0(10, $l);
  $v = e($t, $puiss - 1);
  $out0 *= $v;
  echo "10^", $l, "=", $puiss, " v=", $v, "\n";
}
echo $out0, "\n";
?>

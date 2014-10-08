<?php
function eratostene(&$t, $max0){
  $n = 0;
  for ($i = 2 ; $i < $max0; $i++)
    if ($t[$i] == $i)
  {
    $n ++;
    $j = $i * $i;
    while ($j < $max0 && $j > 0)
    {
      $t[$j] = 0;
      $j += $i;
    }
  }
  return $n;
}

function fillPrimesFactors(&$t, $n, &$primes, $nprimes){
  for ($i = 0 ; $i < $nprimes; $i++)
  {
    $d = $primes[$i];
    while (($n % $d) == 0)
    {
      $t[$d] = $t[$d] + 1;
      $n = intval($n / $d);
    }
    if ($n == 1)
      return $primes[$i];
  }
  return $n;
}

function sumdivaux2(&$t, $n, $i){
  while ($i < $n && $t[$i] == 0)
    $i ++;
  return $i;
}

function sumdivaux(&$t, $n, $i){
  if ($i > $n)
    return 1;
  else if ($t[$i] == 0)
    return sumdivaux($t, $n, sumdivaux2($t, $n, $i + 1));
  else
  {
    $o = sumdivaux($t, $n, sumdivaux2($t, $n, $i + 1));
    $out0 = 0;
    $p = $i;
    for ($j = 1 ; $j <= $t[$i]; $j++)
    {
      $out0 += $p;
      $p *= $i;
    }
    return ($out0 + 1) * $o;
  }
}

function sumdiv($nprimes, &$primes, $n){
  $t = array();
  for ($i = 0 ; $i < $n + 1; $i++)
    $t[$i] = 0;
  $max0 = fillPrimesFactors($t, $n, $primes, $nprimes);
  return sumdivaux($t, $max0, 0);
}

$maximumprimes = 1001;
$era = array();
for ($j = 0 ; $j < $maximumprimes; $j++)
  $era[$j] = $j;
$nprimes = eratostene($era, $maximumprimes);
$primes = array();
for ($o = 0 ; $o < $nprimes; $o++)
  $primes[$o] = 0;
$l = 0;
for ($k = 2 ; $k < $maximumprimes; $k++)
  if ($era[$k] == $k)
{
  $primes[$l] = $k;
  $l ++;
}
echo $l, " == ", $nprimes, "\n";
$sum = 0;
for ($n = 2 ; $n <= 1000; $n++)
{
  $other = sumdiv($nprimes, $primes, $n) - $n;
  if ($other > $n)
  {
    $othersum = sumdiv($nprimes, $primes, $other) - $other;
    if ($othersum == $n)
    {
      echo $other, " & ", $n, "\n";
      $sum += $other + $n;
    }
  }
}
echo "\n", $sum, "\n";
?>

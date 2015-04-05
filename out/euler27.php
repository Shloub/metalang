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

function isPrime($n, &$primes, $len){
  $i = 0;
  if ($n < 0)
    $n = -$n;
  while ($primes[$i] * $primes[$i] < $n)
  {
    if (($n % $primes[$i]) == 0)
      return false;
    $i ++;
  }
  return true;
}

function test($a, $b, &$primes, $len){
  for ($n = 0 ; $n <= 200; $n++)
  {
    $j = $n * $n + $a * $n + $b;
    if (!isPrime($j, $primes, $len))
      return $n;
  }
  return 200;
}

$maximumprimes = 1000;
$era = array();
for ($j = 0 ; $j < $maximumprimes; $j++)
  $era[$j] = $j;
$result = 0;
$max0 = 0;
$nprimes = eratostene($era, $maximumprimes);
$primes = array_fill(0, $nprimes, 0);
$l = 0;
for ($k = 2 ; $k < $maximumprimes; $k++)
  if ($era[$k] == $k)
{
  $primes[$l] = $k;
  $l ++;
}
echo $l, " == ", $nprimes, "\n";
$ma = 0;
$mb = 0;
for ($b = 3 ; $b <= 999; $b++)
  if ($era[$b] == $b)
  for ($a = -999 ; $a <= 999; $a++)
  {
    $n1 = test($a, $b, $primes, $nprimes);
    $n2 = test($a, -$b, $primes, $nprimes);
    if ($n1 > $max0)
    {
      $max0 = $n1;
      $result = $a * $b;
      $ma = $a;
      $mb = $b;
    }
    if ($n2 > $max0)
    {
      $max0 = $n2;
      $result = -$a * $b;
      $ma = $a;
      $mb = -$b;
    }
}
echo $ma, " ", $mb, "\n", $max0, "\n", $result, "\n";
?>

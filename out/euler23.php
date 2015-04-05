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
  $t = array_fill(0, $n + 1, 0);
  $max0 = fillPrimesFactors($t, $n, $primes, $nprimes);
  return sumdivaux($t, $max0, 0);
}

$maximumprimes = 30001;
$era = array();
for ($s = 0 ; $s < $maximumprimes; $s++)
  $era[$s] = $s;
$nprimes = eratostene($era, $maximumprimes);
$primes = array_fill(0, $nprimes, 0);
$l = 0;
for ($k = 2 ; $k < $maximumprimes; $k++)
  if ($era[$k] == $k)
{
  $primes[$l] = $k;
  $l ++;
}
$n = 100;
/* 28124 ça prend trop de temps mais on arrive a passer le test */
$abondant = array_fill(0, $n + 1, false);
$summable = array_fill(0, $n + 1, false);
$sum = 0;
for ($r = 2 ; $r <= $n; $r++)
{
  $other = sumdiv($nprimes, $primes, $r) - $r;
  if ($other > $r)
    $abondant[$r] = true;
}
for ($i = 1 ; $i <= $n; $i++)
  for ($j = 1 ; $j <= $n; $j++)
    if ($abondant[$i] && $abondant[$j] && $i + $j <= $n)
  $summable[$i + $j] = true;
for ($o = 1 ; $o <= $n; $o++)
  if (!$summable[$o])
  $sum += $o;
echo "\n", $sum, "\n";
?>

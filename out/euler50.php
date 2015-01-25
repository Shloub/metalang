<?php
function eratostene(&$t, $max0){
  $n = 0;
  for ($i = 2 ; $i < $max0; $i++)
    if ($t[$i] == $i)
  {
    $n ++;
    if (intval($max0 / $i) > $i)
    {
      $j = $i * $i;
      while ($j < $max0 && $j > 0)
      {
        $t[$j] = 0;
        $j += $i;
      }
    }
  }
  return $n;
}

$maximumprimes = 1000001;
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
$sum = array();
for ($i_ = 0 ; $i_ < $nprimes; $i_++)
  $sum[$i_] = $primes[$i_];
$maxl = 0;
$process = true;
$stop = $maximumprimes - 1;
$len = 1;
$resp = 1;
while ($process)
{
  $process = false;
  for ($i = 0 ; $i <= $stop; $i++)
    if ($i + $len < $nprimes)
  {
    $sum[$i] = $sum[$i] + $primes[$i + $len];
    if ($maximumprimes > $sum[$i])
    {
      $process = true;
      if ($era[$sum[$i]] == $sum[$i])
      {
        $maxl = $len;
        $resp = $sum[$i];
      }
    }
    else
    {
      $c = min($stop, $i);
      $stop = $c;
    }
  }
  $len ++;
}
echo $resp, "\n", $maxl, "\n";
?>

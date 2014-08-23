<?php
function next_($n){
  if (($n % 2) == 0)
    return intval($n / 2);
  else
    return 3 * $n + 1;
}

function find($n, &$m){
  if ($n == 1)
    return 1;
  else if ($n >= 1000000)
    return 1 + find(next_($n), $m);
  else if ($m[$n] != 0)
    return $m[$n];
  else
  {
    $m[$n] = 1 + find(next_($n), $m);
    return $m[$n];
  }
}

$m = array();
for ($j = 0 ; $j < 1000000; $j++)
  $m[$j] = 0;
$max_ = 0;
$maxi = 0;
for ($i = 1 ; $i <= 999; $i++)
{
  /* normalement on met 999999 mais ça dépasse les int32... */
  $n2 = find($i, $m);
  if ($n2 > $max_)
  {
    $max_ = $n2;
    $maxi = $i;
  }
}
echo $max_, "\n", $maxi, "\n";
?>

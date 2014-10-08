<?php
function eratostene(&$t, $max0){
  $sum = 0;
  for ($i = 2 ; $i < $max0; $i++)
    if ($t[$i] == $i)
  {
    $sum += $i;
    $j = $i * $i;
    /*
			detect overflow
			*/
    if (intval($j / $i) == $i)
      while ($j < $max0 && $j > 0)
    {
      $t[$j] = 0;
      $j += $i;
    }
  }
  return $sum;
}

$n = 100000;
/* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
$t = array();
for ($i = 0 ; $i < $n; $i++)
  $t[$i] = $i;
$t[1] = 0;
echo eratostene($t, $n), "\n";
?>

<?php
function max2($a, $b){
  return max($a, $b);
}

function min2($a, $b){
  return min($a, $b);
}

function pgcd($a, $b){
  $c = min2($a, $b);
  $d = max2($a, $b);
  $reste = $d % $c;
  if ($reste == 0)
    return $c;
  else
    return pgcd($c, $reste);
}

$top = 1;
$bottom = 1;
for ($i = 1 ; $i <= 9; $i++)
  for ($j = 1 ; $j <= 9; $j++)
    for ($k = 1 ; $k <= 9; $k++)
      if ($i != $j && $j != $k)
{
  $a = $i * 10 + $j;
  $b = $j * 10 + $k;
  if ($a * $k == $i * $b)
  {
    echo $a, "/", $b, "\n";
    $top *= $a;
    $bottom *= $b;
  }
}
echo $top, "/", $bottom, "\n";
$p = pgcd($top, $bottom);
echo "pgcd=", $p, "\n", intval($bottom / $p), "\n";
?>

<?php
/*
La suite de fibonaci
*/
function fibo($a, $b, $i){
  $out_ = 0;
  $a2 = $a;
  $b2 = $b;
  for ($j = 0 ; $j <= $i + 1; $j++)
  {
    echo $j;
    $out_ += $a2;
    $tmp = $b2;
    $b2 += $a2;
    $a2 = $tmp;
  }
  return $out_;
}

$l = fibo(1, 2, 4);
echo $l;
?>

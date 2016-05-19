<?php
$a = 1;
$b = 2;
$sum = 0;
while ($a < 4000000)
{
    if ($a % 2 == 0)
      $sum += $a;
    $c = $a;
    $a = $b;
    $b += $c;
}
echo $sum, "\n";


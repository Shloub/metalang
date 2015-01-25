<?php
$maximum = 1;
$b0 = 2;
$a = 408464633;
$sqrtia = intval(sqrt($a));
while ($a != 1)
{
  $b = $b0;
  $found = false;
  while ($b <= $sqrtia)
  {
    if (($a % $b) == 0)
    {
      $a = intval($a / $b);
      $b0 = $b;
      $b = $a;
      $e = intval(sqrt($a));
      $sqrtia = $e;
      $found = true;
    }
    $b ++;
  }
  if (!$found)
  {
    echo $a, "\n";
    $a = 1;
  }
}
?>

<?php
$maximum = 1;
$b0 = 2;
$a = 408464633;
while ($a != 1)
{
  $b = $b0;
  $found = false;
  while ($b * $b < $a)
  {
    if (($a % $b) == 0)
    {
      $a = intval($a / $b);
      $b0 = $b;
      $b = $a;
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

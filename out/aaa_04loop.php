<?php
$j = 0;
for ($k = 0 ; $k <= 10; $k++)
{
  $j += $k;
  echo $j, "\n";
}
$i = 4;
while ($i < 10)
{
  echo $i;
  $i ++;
  $j += $i;
}
echo $j, $i;
?>

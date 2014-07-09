<?php
$n = 10;
/* normalement on doit mettre 20 mais là on se tape un overflow */
$n ++;
$tab = array();
for ($i = 0 ; $i < $n; $i++)
{
  $tab2 = array();
  for ($j = 0 ; $j < $n; $j++)
    $tab2[$j] = 0;
  $tab[$i] = $tab2;
}
for ($l = 0 ; $l < $n; $l++)
{
  $tab[$n - 1][$l] = 1;
  $tab[$l][$n - 1] = 1;
}
for ($o = 2 ; $o <= $n; $o++)
{
  $r = $n - $o;
  for ($p = 2 ; $p <= $n; $p++)
  {
    $q = $n - $p;
    $tab[$r][$q] = $tab[$r + 1][$q] + $tab[$r][$q + 1];
  }
}
for ($m = 0 ; $m < $n; $m++)
{
  for ($k = 0 ; $k < $n; $k++)
  {
    echo $tab[$m][$k], " ";
  }
  echo "\n";
}
echo $tab[0][0], "\n";
?>

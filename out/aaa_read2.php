<?php
/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
$a = intval(trim(fgets(STDIN)));
$len = $a;
echo $len, "=len\n";
$b = array_map("intval", explode(" ", fgets(STDIN)));
$tab = $b;
for ($i = 0 ; $i < $len; $i++)
{
  echo $i, "=>", $tab[$i], " ";
}
echo "\n";
$d = array_map("intval", explode(" ", fgets(STDIN)));
$tab2 = $d;
for ($i_ = 0 ; $i_ < $len; $i_++)
{
  echo $i_, "==>", $tab2[$i_], " ";
}
$e = intval(trim(fgets(STDIN)));
$strlen = $e;
echo $strlen, "=strlen\n";
$f = fgets(STDIN);
$tab4 = $f;
for ($i3 = 0 ; $i3 < $strlen; $i3++)
{
  $tmpc = $tab4[$i3];
  $c = ord($tmpc);
  echo $tmpc, ":", $c, " ";
  if ($tmpc != " ")
    $c = (($c - ord("a")) + 13) % 26 + ord("a");
  $tab4[$i3] = chr($c);
}
for ($j = 0 ; $j < $strlen; $j++)
  echo $tab4[$j];
?>

<?php
function read_int(){
  return intval(trim(fgets(STDIN)));
}

function read_int_line($n){
  return array_map("intval", explode(" ", fgets(STDIN)));
}

function read_char_line($n){
  return fgets(STDIN);
}

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
$a = intval(trim(fgets(STDIN)));
$len = $a;
echo $len, "=len\n";
$d = $len;
$b = array_map("intval", explode(" ", fgets(STDIN)));
$tab = $b;
for ($i = 0 ; $i < $len; $i++)
{
  echo $i, "=>", $tab[$i], " ";
}
echo "\n";
$f = $len;
$e = array_map("intval", explode(" ", fgets(STDIN)));
$tab2 = $e;
for ($i_ = 0 ; $i_ < $len; $i_++)
{
  echo $i_, "==>", $tab2[$i_], " ";
}
$g = intval(trim(fgets(STDIN)));
$strlen = $g;
echo $strlen, "=strlen\n";
$k = $strlen;
$h = fgets(STDIN);
$tab4 = $h;
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

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
$len = read_int();
echo $len, "=len\n";
$tab = read_int_line($len);
for ($i = 0 ; $i < $len; $i++)
{
  echo $i, "=>";
  $a = $tab[$i];
  echo $a, " ";
}
echo "\n";
$tab2 = read_int_line($len);
for ($i_ = 0 ; $i_ < $len; $i_++)
{
  echo $i_, "==>";
  $b = $tab2[$i_];
  echo $b, " ";
}
$strlen = read_int();
echo $strlen, "=strlen\n";
$tab4 = read_char_line($strlen);
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
{
  $d = $tab4[$j];
  echo $d;
}
?>

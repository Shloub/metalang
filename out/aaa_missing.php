<?php
/*
  Ce test a été généré par Metalang.
*/
function result($len, &$tab){
  $tab2 = array();
  for ($i = 0 ; $i < $len; $i++)
    $tab2[$i] = false;
  for ($i1 = 0 ; $i1 < $len; $i1++)
    $tab2[$tab[$i1]] = true;
  for ($i2 = 0 ; $i2 < $len; $i2++)
    if (!$tab2[$i2])
    return $i2;
  return -1;
}

$a = intval(trim(fgets(STDIN)));
$len = $a;
echo $len, "\n";
$b = array_map("intval", explode(" ", fgets(STDIN)));
$tab = $b;
echo result($len, $tab);
?>

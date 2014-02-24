<?php

function read_int_line($n){
  $a = array_map("intval", explode(" ", fgets(STDIN)));
  return $a;
}

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

$l0 = read_int_line(1);
$len = $l0[0];
$tab = read_int_line($len);
$b = result($len, $tab);
echo $b;
?>

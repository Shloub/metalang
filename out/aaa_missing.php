<?php
function read_int(){
  return intval(trim(fgets(STDIN)));
}

function read_int_line($n){
  return array_map("intval", explode(" ", fgets(STDIN)));
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

$len = read_int();
echo $len, "\n";
$tab = read_int_line($len);
echo result($len, $tab);
?>

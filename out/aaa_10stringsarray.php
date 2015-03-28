<?php
/*
TODO ajouter un record qui contient des chaines.
*/
function idstring($s){
  return $s;
}

function printstring($s){
  echo idstring($s), "\n";
}

$tab = array();
for ($i = 0 ; $i < 2; $i++)
  $tab[$i] = idstring("chaine de test");
for ($j = 0 ; $j <= 1; $j++)
  printstring(idstring($tab[$j]));
?>

<?php
/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
$input = " ";
$current_pos = 500;
$a = 1000;
$mem = array();
for ($i = 0 ; $i < $a; $i++)
  $mem[$i] = 0;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$current_pos ++;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
while ($mem[$current_pos] != 0)
{
  $mem[$current_pos] = $mem[$current_pos] - 1;
  $current_pos --;
  $mem[$current_pos] = $mem[$current_pos] + 1;
  echo chr($mem[$current_pos]);
  $current_pos ++;
}
?>

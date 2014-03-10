<?php

/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
$input = ' ';
$current_pos = 500;
$a = 1000;
$mem_ = array();
for ($i = 0 ; $i < $a; $i++)
  $mem_[$i] = 0;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$current_pos ++;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
$mem_[$current_pos] = $mem_[$current_pos] + 1;
while ($mem_[$current_pos] != 0)
{
  $mem_[$current_pos] = $mem_[$current_pos] - 1;
  $current_pos --;
  $mem_[$current_pos] = $mem_[$current_pos] + 1;
  $b = chr($mem_[$current_pos]);
  echo $b;
  $current_pos ++;
}
?>

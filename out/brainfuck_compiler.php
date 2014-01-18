<?php

/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
$input = ord(' ');
$current_pos = 500;
$j = 1000;
$mem = array();
for ($i = 0 ; $i < $j; $i++)
  $mem[$i] = 0;
?>

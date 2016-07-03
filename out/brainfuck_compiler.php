<?php
/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
$input = " ";
$current_pos = 500;
$mem = array_fill(0, 1000, 0);
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$current_pos++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
$mem[$current_pos]++;
while ($mem[$current_pos] != 0)
{
    $mem[$current_pos]--;
    $current_pos--;
    $mem[$current_pos]++;
    echo chr($mem[$current_pos]);
    $current_pos++;
}


<?php
$i = 0;
$i -= 1;
echo $i, "\n";
$i += 55;
echo $i, "\n";
$i *= 13;
echo $i, "\n";
$i = intval($i / 2);
echo $i, "\n";
$i += 1;
echo $i, "\n";
$i = intval($i / 3);
echo $i, "\n";
$i -= 1;
echo $i, "\n";
/*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
echo intval(117 / 17), "\n", intval(117 / -17), "\n", intval(-117 / 17), "\n", intval(-117 / -17), "\n", 117 % 17, "\n", 117 % -17, "\n", -117 % 17, "\n", -117 % -17, "\n";


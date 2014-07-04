<?php
$i = 0;
$i --;
echo $i, "\n";
$i += 55;
echo $i, "\n";
$i *= 13;
echo $i, "\n";
$i = intval($i / 2);
echo $i, "\n";
$i ++;
echo $i, "\n";
$i = intval($i / 3);
echo $i, "\n";
$i --;
echo $i, "\n";
/*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
$a = intval(117 / 17);
echo $a, "\n";
$b = intval(117 / -17);
echo $b, "\n";
$c = intval(-117 / 17);
echo $c, "\n";
$d = intval(-117 / -17);
echo $d, "\n";
$e = 117 % 17;
echo $e, "\n";
$f = 117 % -17;
echo $f, "\n";
$g = -117 % 17;
echo $g, "\n";
$h = -117 % -17;
echo $h, "\n";
?>

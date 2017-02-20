<?php
/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/

$len = intval(trim(fgets(STDIN)));
echo $len, "=len\n";
$tab = array_map("intval", explode(" ", fgets(STDIN)));
for ($i = 0; $i < $len; $i++)
    echo $i, "=>", $tab[$i], " ";
echo "\n";
$tab2 = array_map("intval", explode(" ", fgets(STDIN)));
for ($i_ = 0; $i_ < $len; $i_++)
    echo $i_, "==>", $tab2[$i_], " ";
$strlen = intval(trim(fgets(STDIN)));
echo $strlen, "=strlen\n";
$tab4 = fgets(STDIN);
for ($i3 = 0; $i3 < $strlen; $i3++)
{
    $tmpc = $tab4[$i3];
    $c = ord($tmpc);
    echo $tmpc, ":", $c, " ";
    if ($tmpc != " ")
        $c = ($c - ord("a") + 13) % 26 + ord("a");
    $tab4[$i3] = chr($c);
}
for ($j = 0; $j < $strlen; $j++)
    echo $tab4[$j];


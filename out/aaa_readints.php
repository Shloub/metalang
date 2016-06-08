<?php
$len = intval(trim(fgets(STDIN)));
echo $len, "=len\n";
$tab1 = array_map("intval", explode(" ", fgets(STDIN)));
for ($i = 0; $i < $len; $i += 1)
    echo $i, "=>", $tab1[$i], "\n";
$len = intval(trim(fgets(STDIN)));
$tab2 = array();
for ($a = 0; $a < $len - 1; $a += 1)
    $tab2[$a] = array_map("intval", explode(" ", fgets(STDIN)));
for ($i = 0; $i < $len - 1; $i += 1)
{
    for ($j = 0; $j < $len; $j += 1)
        echo $tab2[$i][$j], " ";
    echo "\n";
}


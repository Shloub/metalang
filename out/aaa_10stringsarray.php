<?php

function idstring($s) {
    return $s;
}

function printstring($s) {
    echo idstring($s), "\n";
}

function print_toto(&$t) {
    echo $t["s"], " = ", $t["v"], "\n";
}

$tab = array();
for ($i = 0; $i < 2; $i += 1)
    $tab[$i] = idstring("chaine de test");
for ($j = 0; $j < 2; $j += 1)
    printstring(idstring($tab[$j]));
$a = array(
    "s" => "one",
    "v" => 1);
print_toto($a);


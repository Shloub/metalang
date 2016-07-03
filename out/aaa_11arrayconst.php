<?php
function test(&$tab, $len) {
    for ($i = 0; $i < $len; $i++)
        echo $tab[$i], " ";
    echo "\n";
}

$t = array_fill(0, 5, 1);
test($t, 5);


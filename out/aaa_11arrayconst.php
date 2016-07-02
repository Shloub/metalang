<?php
function test(&$tab, $len) {
    for ($i = 0; $i < $len; $i += 1)
        echo $tab[$i], " ";
    echo "\n";
}

$t = array_fill(0, 5, 1);
test($t, 5);


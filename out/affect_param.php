<?php

function foo($a) {
    $a = 4;
}

$a = 0;
foo($a);
echo $a, "\n";


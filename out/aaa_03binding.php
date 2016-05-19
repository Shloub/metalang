<?php

function g($i) {
    $j = $i * 4;
    if ($j % 2 == 1)
      return 0;
    return $j;
}


function h($i) {
    echo $i, "\n";
}

h(14);
$a = 4;
$b = 5;
echo $a + $b;
/* main */
h(15);
$a = 2;
$b = 1;
echo $a + $b;


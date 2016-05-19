<?php

function &id(&$b) {
    return $b;
}


function g(&$t, $index) {
    $t[$index] = false;
}

$j = 0;
$a = array();
for ($i = 0; $i < 5; $i++)
{
    echo $i;
    $j += $i;
    $a[$i] = $i % 2 == 0;
}
echo $j, " ";
if ($a[0])
  echo "True";
else
  echo "False";
echo "\n";
g(id($a), 0);
if ($a[0])
  echo "True";
else
  echo "False";
echo "\n";


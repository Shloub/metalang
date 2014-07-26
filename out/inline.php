<?php
function foo($i){
  echo $i, "\n";
}

function foobar($i){
  echo $i, "\n", "foobar";
}

$a = 0;
echo $a, "\n";
$b = 12;
echo $b, "\n", "foobar";
$c = 1;
echo $c, "\n";
?>

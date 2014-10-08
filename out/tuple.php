<?php
function f($tuple0){
  list($a, $b) = $tuple0;
  return array($a + 1, $b + 1);
}

$t = f(array(0, 1));
list($a, $b) = $t;
echo $a, " -- ", $b, "--\n";
?>

<?php
function f($tuple_){
  list($a, $b) = $tuple_;
  return array($a + 1, $b + 1);
}

$t = f(array(0, 1));
list($a, $b) = $t;
echo $a, " -- ", $b, "--\n";
?>

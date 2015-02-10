<?php

$bar_ = intval(trim(fgets(STDIN)));
$t = array(
  "foo"=>array_map("intval", explode(" ", fgets(STDIN))),
  "bar"=>$bar_
);

list($a, $b) = $t["foo"];
echo $a, " ", $b, " ", $t["bar"], "\n";
?>

<?php
function &id(&$b){
  return $b;
}

function g(&$t, $index){
  $t[$index] = false;
}

$c = 5;
$a = array();
for ($i = 0 ; $i < $c; $i++)
{
  echo $i;
  $a[$i] = ($i % 2) == 0;
}
$d = $a[0];
if ($d)
  echo "True";
else
  echo "False";
echo "\n";
g(id($a), 0);
$e = $a[0];
if ($e)
  echo "True";
else
  echo "False";
echo "\n";
?>

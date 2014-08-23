<?php
function &id(&$b){
  return $b;
}

function g(&$t, $index){
  $t[$index] = false;
}

$a = array();
for ($i = 0 ; $i < 5; $i++)
{
  echo $i;
  $a[$i] = ($i % 2) == 0;
}
$c = $a[0];
if ($c)
  echo "True";
else
  echo "False";
echo "\n";
g(id($a), 0);
$d = $a[0];
if ($d)
  echo "True";
else
  echo "False";
echo "\n";
?>

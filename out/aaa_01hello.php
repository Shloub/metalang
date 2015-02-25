<?php
echo "Hello World";
$a = 5;
echo (4 + 6) * 2, " ", "\n", $a, "foo", "";
$b = 1 + intval(((1 + 1) * 2 * (3 + 8)) / 4) - (1 - 2) - 3 == 12 && true;
if ($b)
  echo "True";
else
  echo "False";
echo "\n";
$c = (3 * (4 + 5 + 6) * 2 == 45) == false;
if ($c)
  echo "True";
else
  echo "False";
echo intval((intval((4 + 1) / 3)) / (2 + 1)), intval((intval((4 * 1) / 3)) / (2 *
                                                                               1));
$d = !(!($a == 0) && !($a == 4));
if ($d)
  echo "True";
else
  echo "False";
$e = true && !false && !(true && false);
if ($e)
  echo "True";
else
  echo "False";
echo "\n";
?>

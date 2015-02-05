<?php
for ($i = 1 ; $i <= 3; $i++)
{
  list($a, $b) = array_map("intval", explode(" ", fgets(STDIN)));
  echo "a = ", $a, " b = ", $b, "\n";
}
?>

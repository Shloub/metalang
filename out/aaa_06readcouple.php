<?php
for ($i = 1; $i < 4; $i += 1)
{
    list($a, $b) = array_map("intval", explode(" ", fgets(STDIN)));
    echo "a = ", $a, " b = ", $b, "\n";
}
$l = array_map("intval", explode(" ", fgets(STDIN)));
for ($j = 0; $j < 10; $j += 1)
    echo $l[$j], "\n";


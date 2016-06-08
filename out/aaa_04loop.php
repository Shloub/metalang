<?php

function h($i) {
    /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
    $j = $i - 2;
    while ($j <= $i + 2)
    {
        if ($i % $j == 5)
            return true;
        $j += 1;
    }
    return false;
}

$j = 0;
for ($k = 0; $k <= 10; $k += 1)
{
    $j += $k;
    echo $j, "\n";
}
$i = 4;
while ($i < 10)
{
    echo $i;
    $i += 1;
    $j += $i;
}
echo $j, $i, "FIN TEST\n";


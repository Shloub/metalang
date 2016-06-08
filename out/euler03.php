<?php
$maximum = 1;
$b0 = 2;
$a = 408464633;
$sqrtia = intval(sqrt($a));
while ($a != 1)
{
    $b = $b0;
    $found = false;
    while ($b <= $sqrtia)
    {
        if ($a % $b == 0)
        {
            $a = intval($a / $b);
            $b0 = $b;
            $b = $a;
            $sqrtia = intval(sqrt($a));
            $found = true;
        }
        $b += 1;
    }
    if (!$found)
    {
        echo $a, "\n";
        $a = 1;
    }
}


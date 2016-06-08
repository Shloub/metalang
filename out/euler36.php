<?php

function palindrome2(&$pow2, $n) {
    $t = array();
    for ($i = 0; $i < 20; $i += 1)
        $t[$i] = intval($n / $pow2[$i]) % 2 == 1;
    $nnum = 0;
    for ($j = 1; $j <= 19; $j += 1)
        if ($t[$j])
            $nnum = $j;
    for ($k = 0; $k <= intval($nnum / 2); $k += 1)
        if ($t[$k] != $t[$nnum - $k])
            return false;
    return true;
}

$p = 1;
$pow2 = array();
for ($i = 0; $i < 20; $i += 1)
{
    $p *= 2;
    $pow2[$i] = intval($p / 2);
}
$sum = 0;
for ($d = 1; $d <= 9; $d += 1)
{
    if (palindrome2($pow2, $d))
    {
        echo $d, "\n";
        $sum += $d;
    }
    if (palindrome2($pow2, $d * 10 + $d))
    {
        echo $d * 10 + $d, "\n";
        $sum += $d * 10 + $d;
    }
}
for ($a0 = 0; $a0 <= 4; $a0 += 1)
{
    $a = $a0 * 2 + 1;
    for ($b = 0; $b <= 9; $b += 1)
    {
        for ($c = 0; $c <= 9; $c += 1)
        {
            $num0 = $a * 100000 + $b * 10000 + $c * 1000 + $c * 100 + $b * 10 + $a;
            if (palindrome2($pow2, $num0))
            {
                echo $num0, "\n";
                $sum += $num0;
            }
            $num1 = $a * 10000 + $b * 1000 + $c * 100 + $b * 10 + $a;
            if (palindrome2($pow2, $num1))
            {
                echo $num1, "\n";
                $sum += $num1;
            }
        }
        $num2 = $a * 100 + $b * 10 + $a;
        if (palindrome2($pow2, $num2))
        {
            echo $num2, "\n";
            $sum += $num2;
        }
        $num3 = $a * 1000 + $b * 100 + $b * 10 + $a;
        if (palindrome2($pow2, $num3))
        {
            echo $num3, "\n";
            $sum += $num3;
        }
    }
}
echo "sum=", $sum, "\n";


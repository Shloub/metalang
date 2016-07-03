<?php
function triangle($n) {
    if ($n % 2 == 0)
        return intval($n / 2) * ($n + 1);
    else
        return $n * intval(($n + 1) / 2);
}

function penta($n) {
    if ($n % 2 == 0)
        return intval($n / 2) * (3 * $n - 1);
    else
        return intval((3 * $n - 1) / 2) * $n;
}

function hexa($n) {
    return $n * (2 * $n - 1);
}

function findPenta2($n, $a, $b) {
    if ($b == $a + 1)
        return penta($a) == $n || penta($b) == $n;
    $c = intval(($a + $b) / 2);
    $p = penta($c);
    if ($p == $n)
        return true;
    else if ($p < $n)
        return findPenta2($n, $c, $b);
    else
        return findPenta2($n, $a, $c);
}

function findHexa2($n, $a, $b) {
    if ($b == $a + 1)
        return hexa($a) == $n || hexa($b) == $n;
    $c = intval(($a + $b) / 2);
    $p = hexa($c);
    if ($p == $n)
        return true;
    else if ($p < $n)
        return findHexa2($n, $c, $b);
    else
        return findHexa2($n, $a, $c);
}

for ($n = 285; $n < 55386; $n += 1)
{
    $t = triangle($n);
    if (findPenta2($t, intval($n / 5), $n) && findHexa2($t, intval($n / 5), intval($n / 2) + 10))
        echo $n, "\n", $t, "\n";
}


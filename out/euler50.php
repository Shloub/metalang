<?php

function eratostene(&$t, $max0) {
    $n = 0;
    for ($i = 2; $i < $max0; $i += 1)
        if ($t[$i] == $i)
        {
            $n += 1;
            if (intval($max0 / $i) > $i)
            {
                $j = $i * $i;
                while ($j < $max0 && $j > 0)
                {
                    $t[$j] = 0;
                    $j += $i;
                }
            }
        }
    return $n;
}

$maximumprimes = 1000001;
$era = array();
for ($j = 0; $j < $maximumprimes; $j += 1)
    $era[$j] = $j;
$nprimes = eratostene($era, $maximumprimes);
$primes = array_fill(0, $nprimes, 0);
$l = 0;
for ($k = 2; $k < $maximumprimes; $k += 1)
    if ($era[$k] == $k)
    {
        $primes[$l] = $k;
        $l += 1;
    }
echo $l, " == ", $nprimes, "\n";
$sum = array();
for ($i_ = 0; $i_ < $nprimes; $i_ += 1)
    $sum[$i_] = $primes[$i_];
$maxl = 0;
$process = true;
$stop = $maximumprimes - 1;
$len = 1;
$resp = 1;
while ($process)
{
    $process = false;
    for ($i = 0; $i <= $stop; $i += 1)
        if ($i + $len < $nprimes)
        {
            $sum[$i] += $primes[$i + $len];
            if ($maximumprimes > $sum[$i])
            {
                $process = true;
                if ($era[$sum[$i]] == $sum[$i])
                {
                    $maxl = $len;
                    $resp = $sum[$i];
                }
            }
            else
                $stop = min($stop, $i);
        }
    $len += 1;
}
echo $resp, "\n", $maxl, "\n";


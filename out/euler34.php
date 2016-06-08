<?php
$f = array_fill(0, 10, 1);
for ($i = 1; $i <= 9; $i += 1)
{
    $f[$i] *= $i * $f[$i - 1];
    echo $f[$i], " ";
}
$out0 = 0;
echo "\n";
for ($a = 0; $a <= 9; $a += 1)
    for ($b = 0; $b <= 9; $b += 1)
        for ($c = 0; $c <= 9; $c += 1)
            for ($d = 0; $d <= 9; $d += 1)
                for ($e = 0; $e <= 9; $e += 1)
                    for ($g = 0; $g <= 9; $g += 1)
                    {
                        $sum = $f[$a] + $f[$b] + $f[$c] + $f[$d] + $f[$e] + $f[$g];
                        $num = (((($a * 10 + $b) * 10 + $c) * 10 + $d) * 10 + $e) * 10 + $g;
                        if ($a == 0)
                        {
                            $sum -= 1;
                            if ($b == 0)
                            {
                                $sum -= 1;
                                if ($c == 0)
                                {
                                    $sum -= 1;
                                    if ($d == 0)
                                        $sum -= 1;
                                }
                            }
                        }
                        if ($sum == $num && $sum != 1 && $sum != 2)
                        {
                            $out0 += $num;
                            echo $num, " ";
                        }
                    }
echo "\n", $out0, "\n";


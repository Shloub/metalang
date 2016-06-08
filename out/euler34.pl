#!/usr/bin/perl

my $f = [];
foreach my $j (0 .. 10 - 1)
{
    $f->[$j] = 1;
}
foreach my $i (1 .. 9)
{
    $f->[$i] = $f->[$i] * $i * $f->[$i - 1];
    print($f->[$i], " ");
}
my $out0 = 0;
print "\n";
foreach my $a (0 .. 9)
{
    foreach my $b (0 .. 9)
    {
        foreach my $c (0 .. 9)
        {
            foreach my $d (0 .. 9)
            {
                foreach my $e (0 .. 9)
                {
                    foreach my $g (0 .. 9)
                    {
                        my $sum = $f->[$a] + $f->[$b] + $f->[$c] + $f->[$d] + $f->[$e] + $f->[$g];
                        my $num = (((($a * 10 + $b) * 10 + $c) * 10 + $d) * 10 + $e) * 10 + $g;
                        if ($a eq 0)
                        {
                            $sum = $sum - 1;
                            if ($b eq 0)
                            {
                                $sum = $sum - 1;
                                if ($c eq 0)
                                {
                                    $sum = $sum - 1;
                                    if ($d eq 0)
                                    {
                                        $sum = $sum - 1;
                                    }
                                }
                            }
                        }
                        if ($sum eq $num && $sum ne 1 && $sum ne 2)
                        {
                            $out0 = $out0 + $num;
                            print($num, " ");
                        }
                    }
                }
            }
        }
    }
}
print("\n", $out0, "\n");



#!/usr/bin/perl

my $t = [];
foreach my $i (0 .. 1000)
{
    $t->[$i] = 0;
}
foreach my $a (1 .. 1000)
{
    foreach my $b (1 .. 1000)
    {
        my $c2 = $a * $a + $b * $b;
        my $c = int(sqrt($c2));
        if ($c * $c eq $c2)
        {
            my $p = $a + $b + $c;
            if ($p < 1001)
            {
                $t->[$p] = $t->[$p] + 1;
            }
        }
    }
}
my $j = 0;
foreach my $k (1 .. 1000)
{
    if ($t->[$k] > $t->[$j])
    {
        $j = $k;
    }
}
print $j;



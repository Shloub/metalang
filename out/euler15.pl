#!/usr/bin/perl

my $n = 10;
# normalement on doit mettre 20 mais là on se tape un overflow 

$n = $n + 1;
my $tab = [];
foreach my $i (0 .. $n - 1)
{
    my $tab2 = [];
    foreach my $j (0 .. $n - 1)
    {
        $tab2->[$j] = 0;
    }
    $tab->[$i] = $tab2;
}
foreach my $l (0 .. $n - 1)
{
    $tab->[$n - 1]->[$l] = 1;
    $tab->[$l]->[$n - 1] = 1;
}
foreach my $o (2 .. $n)
{
    my $r = $n - $o;
    foreach my $p (2 .. $n)
    {
        my $q = $n - $p;
        $tab->[$r]->[$q] = $tab->[$r + 1]->[$q] + $tab->[$r]->[$q + 1];
    }
}
foreach my $m (0 .. $n - 1)
{
    foreach my $k (0 .. $n - 1)
    {
        print($tab->[$m]->[$k], " ");
    }
    print "\n";
}
print($tab->[0]->[0], "\n");



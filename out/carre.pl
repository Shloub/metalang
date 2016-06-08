#!/usr/bin/perl
use List::Util qw(min max);

my $x = int( <STDIN> );
my $y = int( <STDIN> );
my $tab = [];
foreach my $d (0 .. $y - 1)
{
    $tab->[$d] = [ map { int($_) } split(/\s+/, <STDIN>) ];
}
foreach my $ix (1 .. $x - 1)
{
    foreach my $iy (1 .. $y - 1)
    {
        if ($tab->[$iy]->[$ix] eq 1)
        {
            $tab->[$iy]->[$ix] = min($tab->[$iy]->[$ix - 1], $tab->[$iy - 1]->[$ix], $tab->[$iy - 1]->[$ix - 1]) + 1;
        }
    }
}
foreach my $jy (0 .. $y - 1)
{
    foreach my $jx (0 .. $x - 1)
    {
        print($tab->[$jy]->[$jx], " ");
    }
    print "\n";
}



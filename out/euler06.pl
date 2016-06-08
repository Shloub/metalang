#!/usr/bin/perl

my $lim = 100;
my $sum = int($lim * ($lim + 1) / 2);
my $carressum = $sum * $sum;
my $sumcarres = int($lim * ($lim + 1) * (2 * $lim + 1) / 6);
print $carressum - $sumcarres;



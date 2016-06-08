#!/usr/bin/perl


my $bar_ = int( <STDIN> );
my $t = {"foo" => [ map { int($_) } split(/\s+/, <STDIN>) ], "bar" => $bar_};
my ($a, $b) = @{$t->{"foo"}};
print($a, " ", $b, " ", $t->{"bar"}, "\n");



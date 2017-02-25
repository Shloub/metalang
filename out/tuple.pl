#!/usr/bin/perl

sub f{
  my($tuple0) = @_;
  my ($a, $b) = @{$tuple0};
  return [$a + 1, $b + 1];
}
my $t = f([0, 1]);
my ($a, $b) = @{$t};
print($a, " -- ", $b, "--\n");



#!/usr/bin/perl

sub f{
  my($tuple_) = @_;
  my ($a, $b) = @{ $tuple_ };
  return [$a + 1, $b + 1];
}

my $t = f([0, 1]);
my ($a, $b) = @{ $t };
print($a, " -- ", $b, "--\n");



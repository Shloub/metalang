#!/usr/bin/perl

foreach my $i (1 .. 3) {
  my ($a, $b) = @{ [ map { int($_) } split(/\s+/, <STDIN>) ] };
  print("a = ", $a, " b = ", $b, "\n");
}



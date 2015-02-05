#!/usr/bin/perl

#
#	a + b + c = 1000 && a * a + b * b = c * c
#	

foreach my $a (1 .. 1000) {
  foreach my $b ($a + 1 .. 1000) {
    my $c = 1000 - $a - $b;
    my $a2b2 = $a * $a + $b * $b;
    my $cc = $c * $c;
    if ($cc eq $a2b2 && $c > $a) {
      print($a, "\n", $b, "\n", $c, "\n", $a * $b * $c, "\n");
    }
  }
}



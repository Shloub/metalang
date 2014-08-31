#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

my $sum = 0;
foreach my $i (0 .. 999) {
  if ((remainder($i, 3)) eq 0 || (remainder($i, 5)) eq 0) {
    $sum = $sum + $i;
  }
  }
print($sum, "\n");



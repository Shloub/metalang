#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

my $a = 1;
my $b = 2;
my $sum = 0;
while ($a < 4000000)
{
  if (remainder($a, 2) eq 0) {
    $sum = $sum + $a;
  }
  my $c = $a;
  $a = $b;
  $b = $b + $c;
}
print($sum, "\n");



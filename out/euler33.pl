#!/usr/bin/perl
use List::Util qw(min max);
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub pgcd{
  my($a, $b) = @_;
  my $c = min($a, $b);
  my $d = max($a, $b);
  my $reste = remainder($d, $c);
  if ($reste eq 0) {
    return $c;
  }else{
    return pgcd($c, $reste);
  }
}

my $top = 1;
my $bottom = 1;
foreach my $i (1 .. 9) {
  foreach my $j (1 .. 9) {
    foreach my $k (1 .. 9) {
      if ($i ne $j && $j ne $k) {
        my $a = $i * 10 + $j;
        my $b = $j * 10 + $k;
        if ($a * $k eq $i * $b) {
          print($a, "/", $b, "\n");
          $top = $top * $a;
          $bottom = $bottom * $b;
        }
      }
    }
  }
}
print($top, "/", $bottom, "\n");
my $p = pgcd($top, $bottom);
print("pgcd=", $p, "\n", int($bottom / $p), "\n");



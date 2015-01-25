#!/usr/bin/perl

sub eratostene{
  my($t,
  $max0) = @_;
  my $sum = 0;
  foreach my $i (2 .. $max0 - 1) {
    if ($t->[$i] eq $i) {
      $sum = $sum + $i;
      if (int(($max0) / ($i)) > $i) {
        my $j = $i * $i;
        while ($j < $max0 && $j > 0)
        {
          $t->[$j] = 0;
          $j = $j + $i;
        }
      }
    }
    }
  return $sum;
}

my $n = 100000;
# normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 

my $t = [];
foreach my $i (0 .. $n - 1) {
  $t->[$i] = $i;
  }
$t->[1] = 0;
print(eratostene($t, $n), "\n");



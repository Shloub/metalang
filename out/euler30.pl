#!/usr/bin/perl

#
#a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
#  a ^ 5 +
#  b ^ 5 +
#  c ^ 5 +
#  d ^ 5 +
#  e ^ 5
#

my $p = [];
foreach my $i (0 .. 10 - 1) {
  $p->[$i] = $i * $i * $i * $i * $i;
}
my $sum = 0;
foreach my $a (0 .. 9) {
  foreach my $b (0 .. 9) {
    foreach my $c (0 .. 9) {
      foreach my $d (0 .. 9) {
        foreach my $e (0 .. 9) {
          foreach my $f (0 .. 9) {
            my $s = $p->[$a] + $p->[$b] + $p->[$c] + $p->[$d] + $p->[$e] + $p->[$f];
            my $r = $a + $b * 10 + $c * 100 + $d * 1000 + $e * 10000 + $f * 100000;
            if ($s eq $r && $r ne 1) {
              print($f, $e, $d, $c, $b, $a, " ", $r, "\n");
              $sum = $sum + $r;
            }
          }
        }
      }
    }
  }
}
print($sum);



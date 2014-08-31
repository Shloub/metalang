#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub fact{
  my($n) = @_;
  my $prod = 1;
  foreach my $i (2 .. $n) {
    $prod = $prod * $i;
    }
  return $prod;
}

sub show{
  my($lim,
  $nth) = @_;
  my $t = [];
  foreach my $i (0 .. $lim - 1) {
    $t->[$i] = $i;
    }
  my $pris = [];
  foreach my $j (0 .. $lim - 1) {
    $pris->[$j] = 0;
    }
  foreach my $k (1 .. $lim - 1) {
    my $n = fact($lim - $k);
    my $nchiffre = int(($nth) / ($n));
    $nth = remainder($nth, $n);
    foreach my $l (0 .. $lim - 1) {
      if (!$pris->[$l]) {
        if ($nchiffre eq 0) {
          print($l);
          $pris->[$l] = 1;
        }
        $nchiffre = $nchiffre - 1;
      }
      }
    }
  foreach my $m (0 .. $lim - 1) {
    if (!$pris->[$m]) {
      print($m);
    }
    }
  print("\n");
}

show(10, 999999);



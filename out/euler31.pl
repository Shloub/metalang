#!/usr/bin/perl

sub result{
  my($sum, $t, $maxIndex, $cache) = @_;
  if ($cache->[$sum]->[$maxIndex] ne 0) {
    return $cache->[$sum]->[$maxIndex];
  }elsif ($sum eq 0 || $maxIndex eq 0) {
    return 1;
  }else{
    my $out0 = 0;
    my $div = int($sum / $t->[$maxIndex]);
    foreach my $i (0 .. $div) {
      $out0 =
      $out0 + result($sum - $i * $t->[$maxIndex], $t, $maxIndex - 1, $cache);
    }
    $cache->[$sum]->[$maxIndex] = $out0;
    return $out0;
  }
}

my $t = [];
foreach my $i (0 .. 8 - 1) {
  $t->[$i] = 0;
}
$t->[0] = 1;
$t->[1] = 2;
$t->[2] = 5;
$t->[3] = 10;
$t->[4] = 20;
$t->[5] = 50;
$t->[6] = 100;
$t->[7] = 200;
my $cache = [];
foreach my $j (0 .. 201 - 1) {
  my $o = [];
  foreach my $k (0 .. 8 - 1) {
    $o->[$k] = 0;
  }
  $cache->[$j] = $o;
}
print result(200, $t, 7, $cache);



#!/usr/bin/perl
use List::Util qw(min max);

sub find{
  my($n, $m, $x, $y, $dx, $dy) = @_;
  if ($x < 0 || $x eq 20 || $y < 0 || $y eq 20) {
    return -1;
  }elsif ($n eq 0) {
    return 1;
  }else{
    return $m->[$y]->[$x] * find($n - 1, $m, $x + $dx, $y + $dy, $dx, $dy);
  }
}

my $directions = [];
foreach my $i (0 .. 8 - 1) {
  if ($i eq 0) {
    $directions->[$i] = [0, 1];
  }elsif ($i eq 1) {
    $directions->[$i] = [1, 0];
  }elsif ($i eq 2) {
    $directions->[$i] = [0, -1];
  }elsif ($i eq 3) {
    $directions->[$i] = [-1, 0];
  }elsif ($i eq 4) {
    $directions->[$i] = [1, 1];
  }elsif ($i eq 5) {
    $directions->[$i] = [1, -1];
  }elsif ($i eq 6) {
    $directions->[$i] = [-1, 1];
  }else{
    $directions->[$i] = [-1, -1];
  }
}
my $max0 = 0;
my $m = [];
foreach my $h (0 .. 20 - 1) {
  $m->[$h] = [ map { int($_) } split(/\s+/, <STDIN>) ];
}
foreach my $j (0 .. 7) {
  my ($dx, $dy) = @{ $directions->[$j] };
  foreach my $x (0 .. 19) {
    foreach my $y (0 .. 19) {
      $max0 = max($max0, find(4, $m, $x, $y, $dx, $dy));
    }
  }
}
print($max0, "\n");



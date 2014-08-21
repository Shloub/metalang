#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub next_{
  my($n) = @_;
  if ((remainder($n, 2)) eq 0) {
  return int(($n) / (2));
  }else{
  return 3 * $n + 1;
  }
}

sub find{
  my($n,
  $m) = @_;
  if ($n eq 1) {
  return 1;
  }else{
  if ($n >= 1000000) {
  return 1 + find(next_($n), $m);
  }else{
  if ($m->[$n] ne 0) {
  return $m->[$n];
  }else{
  $m->[$n] = 1 + find(next_($n), $m);
  return $m->[$n];
  }
  }
  }
}

my $a = 1000000;
my $m = [];
foreach my $j (0 .. $a - 1) {
  $m->[$j] = 0;
  }
my $max_ = 0;
my $maxi = 0;
foreach my $i (1 .. 999) {
  # normalement on met 999999 mais ça dépasse les int32... 
  
  my $n2 = find($i, $m);
  if ($n2 > $max_) {
  $max_ = $n2;
  $maxi = $i;
  }else{
  
  }
  }
print($max_, "\n", $maxi, "\n");



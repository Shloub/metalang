#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub eratostene{
  my($t,
  $max_) = @_;
  my $n = 0;
  foreach my $i (2 .. $max_ - 1) {
    if ($t->[$i] eq $i) {
      $n = $n + 1;
      my $j = $i * $i;
      while ($j < $max_ && $j > 0)
      {
        $t->[$j] = 0;
        $j = $j + $i;
      }
    }
    }
  return $n;
}

sub fillPrimesFactors{
  my($t,
  $n,
  $primes,
  $nprimes) = @_;
  foreach my $i (0 .. $nprimes - 1) {
    my $d = $primes->[$i];
    while ((remainder($n, $d)) eq 0)
    {
      $t->[$d] = $t->[$d] + 1;
      $n = int(($n) / ($d));
    }
    if ($n eq 1) {
      return $primes->[$i];
    }
    }
  return $n;
}

sub sumdivaux2{
  my($t,
  $n,
  $i) = @_;
  while ($i < $n && $t->[$i] eq 0)
  {
    $i = $i + 1;
  }
  return $i;
}

sub sumdivaux{
  my($t,
  $n,
  $i) = @_;
  if ($i > $n) {
    return 1;
  }elsif ($t->[$i] eq 0) {
    return sumdivaux($t, $n, sumdivaux2($t, $n, $i + 1));
  }else{
    my $o = sumdivaux($t, $n, sumdivaux2($t, $n, $i + 1));
    my $out_ = 0;
    my $p = $i;
    foreach my $j (1 .. $t->[$i]) {
      $out_ = $out_ + $p;
      $p = $p * $i;
      }
    return ($out_ + 1) * $o;
  }
}

sub sumdiv{
  my($nprimes,
  $primes,
  $n) = @_;
  my $t = [];
  foreach my $i (0 .. $n + 1 - 1) {
    $t->[$i] = 0;
    }
  my $max_ = fillPrimesFactors($t, $n, $primes, $nprimes);
  return sumdivaux($t, $max_, 0);
}

my $maximumprimes = 1001;
my $era = [];
foreach my $j (0 .. $maximumprimes - 1) {
  $era->[$j] = $j;
  }
my $nprimes = eratostene($era, $maximumprimes);
my $primes = [];
foreach my $o (0 .. $nprimes - 1) {
  $primes->[$o] = 0;
  }
my $l = 0;
foreach my $k (2 .. $maximumprimes - 1) {
  if ($era->[$k] eq $k) {
    $primes->[$l] = $k;
    $l = $l + 1;
  }
  }
print($l, " == ", $nprimes, "\n");
my $sum = 0;
foreach my $n (2 .. 1000) {
  my $other = sumdiv($nprimes, $primes, $n) - $n;
  if ($other > $n) {
    my $othersum = sumdiv($nprimes, $primes, $other) - $other;
    if ($othersum eq $n) {
      print($other, " & ", $n, "\n");
      $sum = $sum + $other
      +
      $n;
    }
  }
  }
print("\n", $sum, "\n");



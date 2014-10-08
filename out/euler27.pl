#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub eratostene{
  my($t,
  $max0) = @_;
  my $n = 0;
  foreach my $i (2 .. $max0 - 1) {
    if ($t->[$i] eq $i) {
      $n = $n + 1;
      my $j = $i * $i;
      while ($j < $max0 && $j > 0)
      {
        $t->[$j] = 0;
        $j = $j + $i;
      }
    }
    }
  return $n;
}

sub isPrime{
  my($n,
  $primes,
  $len) = @_;
  my $i = 0;
  if ($n < 0) {
    $n = -$n;
  }
  while ($primes->[$i] * $primes->[$i] < $n)
  {
    if ((remainder($n, $primes->[$i])) eq 0) {
      return 0;
    }
    $i = $i + 1;
  }
  return 1;
}

sub test{
  my($a,
  $b,
  $primes,
  $len) = @_;
  foreach my $n (0 .. 200) {
    my $j = $n * $n + $a * $n + $b;
    if (!isPrime($j, $primes, $len)) {
      return $n;
    }
    }
  return 200;
}

my $maximumprimes = 1000;
my $era = [];
foreach my $j (0 .. $maximumprimes - 1) {
  $era->[$j] = $j;
  }
my $result = 0;
my $max0 = 0;
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
my $ma = 0;
my $mb = 0;
foreach my $b (3 .. 999) {
  if ($era->[$b] eq $b) {
    foreach my $a (-999 .. 999) {
      my $n1 = test($a, $b, $primes, $nprimes);
      my $n2 = test($a, -$b, $primes, $nprimes);
      if ($n1 > $max0) {
        $max0 = $n1;
        $result = $a * $b;
        $ma = $a;
        $mb = $b;
      }
      if ($n2 > $max0) {
        $max0 = $n2;
        $result = -$a * $b;
        $ma = $a;
        $mb = -$b;
      }
      }
  }
  }
print($ma, " ", $mb, "\n", $max0, "\n", $result, "\n");



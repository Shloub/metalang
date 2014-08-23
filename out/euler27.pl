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
    }else{
    
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
  }else{
  
  }
  while ($primes->[$i] * $primes->[$i] < $n)
  {
    if ((remainder($n, $primes->[$i])) eq 0) {
    return 0;
    }else{
    
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
    }else{
    
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
my $max_ = 0;
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
  }else{
  
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
    if ($n1 > $max_) {
    $max_ = $n1;
    $result = $a * $b;
    $ma = $a;
    $mb = $b;
    }else{
    
    }
    if ($n2 > $max_) {
    $max_ = $n2;
    $result = -$a * $b;
    $ma = $a;
    $mb = -$b;
    }else{
    
    }
    }
  }else{
  
  }
  }
print($ma, " ", $mb, "\n", $max_, "\n", $result, "\n");


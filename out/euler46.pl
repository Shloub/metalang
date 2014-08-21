#!/usr/bin/perl

sub eratostene{
  my($t,
  $max_) = @_;
  my $n = 0;
  foreach my $i (2 .. $max_ - 1) {
    if ($t->[$i] eq $i) {
    $n = $n + 1;
    my $j = $i * $i;
    if (int(($j) / ($i)) eq $i) {
    # overflow test 
    
    while ($j < $max_ && $j > 0)
    {
      $t->[$j] = 0;
      $j = $j + $i;
    }
    }else{
    
    }
    }else{
    
    }
    }
  return $n;
}

my $maximumprimes = 6000;
my $era = [];
foreach my $j_ (0 .. $maximumprimes - 1) {
  $era->[$j_] = $j_;
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
  }else{
  
  }
  }
print($l, " == ", $nprimes, "\n");
my $canbe = [];
foreach my $i_ (0 .. $maximumprimes - 1) {
  $canbe->[$i_] = 0;
  }
foreach my $i (0 .. $nprimes - 1) {
  foreach my $j (0 .. $maximumprimes - 1) {
    my $n = $primes->[$i] + 2 * $j * $j;
    if ($n < $maximumprimes) {
    $canbe->[$n] = 1;
    }else{
    
    }
    }
  }
foreach my $m (1 .. $maximumprimes) {
  my $m2 = $m * 2 + 1;
  if ($m2 < $maximumprimes && !$canbe->[$m2]) {
  print($m2, "\n");
  }else{
  
  }
  }



#!/usr/bin/perl

sub min2_{
  my($a,
  $b) = @_;
  if ($a < $b) {
    return $a;
  }else{
    return $b;
  }
}

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
      }
    }
    }
  return $n;
}

my $maximumprimes = 1000001;
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
my $sum = [];
foreach my $i_ (0 .. $nprimes - 1) {
  $sum->[$i_] = $primes->[$i_];
  }
my $maxl = 0;
my $process = 1;
my $stop = $maximumprimes - 1;
my $len = 1;
my $resp = 1;
while ($process)
{
  $process = 0;
  foreach my $i (0 .. $stop) {
    if ($i + $len < $nprimes) {
      $sum->[$i] = $sum->[$i] + $primes->[$i + $len];
      if ($maximumprimes > $sum->[$i]) {
        $process = 1;
        if ($era->[$sum->[$i]] eq $sum->[$i]) {
          $maxl = $len;
          $resp = $sum->[$i];
        }
      }else{
        my $c = min2_($stop, $i);
        $stop = $c;
      }
    }
    }
  $len = $len + 1;
}
print($resp, "\n", $maxl, "\n");



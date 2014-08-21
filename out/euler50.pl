#!/usr/bin/perl

sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
    if (!defined $currentchar){ nextchar() ; }
    my $o = $currentchar; nextchar(); return $o; }
sub readint {
    if (!defined $currentchar){ nextchar(); }
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') { $sign = -1; nextchar(); }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}

sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub min2{
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
  foreach $i (2 .. $max_ - 1) {
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

my $maximumprimes = 1000001;
my $era = [];
foreach $j (0 .. $maximumprimes - 1) {
  $era->[$j] = $j;
  }
my $nprimes = eratostene($era, $maximumprimes);
my $primes = [];
foreach $o (0 .. $nprimes - 1) {
  $primes->[$o] = 0;
  }
my $l = 0;
foreach $k (2 .. $maximumprimes - 1) {
  if ($era->[$k] eq $k) {
  $primes->[$l] = $k;
  $l = $l + 1;
  }else{
  
  }
  }
print($l);
print(" == ");
print($nprimes);
print("\n");
my $sum = [];
foreach $i_ (0 .. $nprimes - 1) {
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
  foreach $i (0 .. $stop) {
    if ($i + $len < $nprimes) {
    $sum->[$i] = $sum->[$i] + $primes->[$i + $len];
    if ($maximumprimes > $sum->[$i]) {
    $process = 1;
    if ($era->[$sum->[$i]] eq $sum->[$i]) {
    $maxl = $len;
    $resp = $sum->[$i];
    }else{
    
    }
    }else{
    $stop = min2($stop, $i);
    }
    }else{
    
    }
    }
  $len = $len + 1;
}
print($resp);
print("\n");
print($maxl);
print("\n");



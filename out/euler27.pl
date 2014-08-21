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

sub eratostene{
  my($t,
  $max_) = @_;
  my $n = 0;
  foreach $i (2 .. $max_ - 1) {
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
  foreach $n (0 .. 200) {
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
foreach $j (0 .. $maximumprimes - 1) {
  $era->[$j] = $j;
  }
my $result = 0;
my $max_ = 0;
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
my $ma = 0;
my $mb = 0;
foreach $b (3 .. 999) {
  if ($era->[$b] eq $b) {
  foreach $a (-999 .. 999) {
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
print($ma);
print(" ");
print($mb);
print("\n");
print($max_);
print("\n");
print($result);
print("\n");



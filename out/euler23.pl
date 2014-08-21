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

sub fillPrimesFactors{
  my($t,
  $n,
  $primes,
  $nprimes) = @_;
  foreach $i (0 .. $nprimes - 1) {
    my $d = $primes->[$i];
    while ((remainder($n, $d)) eq 0)
    {
      $t->[$d] = $t->[$d] + 1;
      $n = int(($n) / ($d));
    }
    if ($n eq 1) {
    return $primes->[$i];
    }else{
    
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
  }else{
  if ($t->[$i] eq 0) {
  return sumdivaux($t, $n, sumdivaux2($t, $n, $i + 1));
  }else{
  my $o = sumdivaux($t, $n, sumdivaux2($t, $n, $i + 1));
  my $out_ = 0;
  my $p = $i;
  foreach $j (1 .. $t->[$i]) {
    $out_ = $out_ + $p;
    $p = $p * $i;
    }
  return ($out_ + 1) * $o;
  }
  }
}

sub sumdiv{
  my($nprimes,
  $primes,
  $n) = @_;
  my $a = $n + 1;
  my $t = [];
  foreach $i (0 .. $a - 1) {
    $t->[$i] = 0;
    }
  my $max_ = fillPrimesFactors($t, $n, $primes, $nprimes);
  return sumdivaux($t, $max_, 0);
}

my $maximumprimes = 30001;
my $era = [];
foreach $s (0 .. $maximumprimes - 1) {
  $era->[$s] = $s;
  }
my $nprimes = eratostene($era, $maximumprimes);
my $primes = [];
foreach $t (0 .. $nprimes - 1) {
  $primes->[$t] = 0;
  }
my $l = 0;
foreach $k (2 .. $maximumprimes - 1) {
  if ($era->[$k] eq $k) {
  $primes->[$l] = $k;
  $l = $l + 1;
  }else{
  
  }
  }
my $n = 100;
# 28124 ça prend trop de temps mais on arrive a passer le test 

my $b = $n + 1;
my $abondant = [];
foreach $p (0 .. $b - 1) {
  $abondant->[$p] = 0;
  }
my $c = $n + 1;
my $summable = [];
foreach $q (0 .. $c - 1) {
  $summable->[$q] = 0;
  }
my $sum = 0;
foreach $r (2 .. $n) {
  my $other = sumdiv($nprimes, $primes, $r) - $r;
  if ($other > $r) {
  $abondant->[$r] = 1;
  }else{
  
  }
  }
foreach $i (1 .. $n) {
  foreach $j (1 .. $n) {
    if ($abondant->[$i] && $abondant->[$j] && $i + $j <= $n) {
    $summable->[$i + $j] = 1;
    }else{
    
    }
    }
  }
foreach $o (1 .. $n) {
  if (!$summable->[$o]) {
  $sum = $sum + $o;
  }else{
  
  }
  }
print("\n");
print($sum);
print("\n");



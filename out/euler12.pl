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

sub max2{
  my($a,
  $b) = @_;
  if ($a > $b) {
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
    my $j = $i * $i;
    $n = $n + 1;
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

sub find{
  my($ndiv2) = @_;
  my $maximumprimes = 110;
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
  foreach $n (1 .. 10000) {
    my $c = $n + 2;
    my $primesFactors = [];
    foreach $m (0 .. $c - 1) {
      $primesFactors->[$m] = 0;
      }
    my $max_ = max2(fillPrimesFactors($primesFactors, $n, $primes, $nprimes), fillPrimesFactors($primesFactors, $n + 1, $primes, $nprimes));
    $primesFactors->[2] = $primesFactors->[2] - 1;
    my $ndivs = 1;
    foreach $i (0 .. $max_) {
      if ($primesFactors->[$i] ne 0) {
      $ndivs = $ndivs * 1
      +
      $primesFactors->[$i];
      }else{
      
      }
      }
    if ($ndivs > $ndiv2) {
    return int(($n * ($n + 1)) / (2));
    }else{
    
    }
    # print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" 
    
    }
  return 0;
}

print(find(500));
print("\n");



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
foreach $j_ (0 .. $maximumprimes - 1) {
  $era->[$j_] = $j_;
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
my $canbe = [];
foreach $i_ (0 .. $maximumprimes - 1) {
  $canbe->[$i_] = 0;
  }
foreach $i (0 .. $nprimes - 1) {
  foreach $j (0 .. $maximumprimes - 1) {
    my $n = $primes->[$i] + 2 * $j * $j;
    if ($n < $maximumprimes) {
    $canbe->[$n] = 1;
    }else{
    
    }
    }
  }
foreach $m (1 .. $maximumprimes) {
  my $m2 = $m * 2 + 1;
  if ($m2 < $maximumprimes && !$canbe->[$m2]) {
  print($m2);
  print("\n");
  }else{
  
  }
  }



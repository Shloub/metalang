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

sub primesfactors{
  my($n) = @_;
  my $c = $n + 1;
  my $tab = [];
  foreach $i (0 .. $c - 1) {
    $tab->[$i] = 0;
    }
  my $d = 2;
  while ($n ne 1 && $d * $d <= $n)
  {
    if ((remainder($n, $d)) eq 0) {
    $tab->[$d] = $tab->[$d] + 1;
    $n = int(($n) / ($d));
    }else{
    $d = $d + 1;
    }
  }
  $tab->[$n] = $tab->[$n] + 1;
  return $tab;
}

my $lim = 20;
my $e = $lim + 1;
my $o = [];
foreach $m (0 .. $e - 1) {
  $o->[$m] = 0;
  }
foreach $i (1 .. $lim) {
  my $t = primesfactors($i);
  foreach $j (1 .. $i) {
    $o->[$j] = max2($o->[$j], $t->[$j]);
    }
  }
my $product = 1;
foreach $k (1 .. $lim) {
  foreach $l (1 .. $o->[$k]) {
    $product = $product * $k;
    }
  }
print($product);
print("\n");



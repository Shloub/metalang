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

my $n = 10;
# normalement on doit mettre 20 mais là on se tape un overflow 

$n = $n + 1;
my $tab = [];
foreach $i (0 .. $n - 1) {
  my $tab2 = [];
  foreach $j (0 .. $n - 1) {
    $tab2->[$j] = 0;
    }
  $tab->[$i] = $tab2;
  }
foreach $l (0 .. $n - 1) {
  $tab->[$n - 1]->[$l] = 1;
  $tab->[$l]->[$n - 1] = 1;
  }
foreach $o (2 .. $n) {
  my $r = $n - $o;
  foreach $p (2 .. $n) {
    my $q = $n - $p;
    $tab->[$r]->[$q] = $tab->[$r + 1]->[$q] + $tab->[$r]->[$q + 1];
    }
  }
foreach $m (0 .. $n - 1) {
  foreach $k (0 .. $n - 1) {
    print($tab->[$m]->[$k]);
    print(" ");
    }
  print("\n");
  }
print($tab->[0]->[0]);
print("\n");



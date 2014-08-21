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
  my $sum = 0;
  foreach $i (2 .. $max_ - 1) {
    if ($t->[$i] eq $i) {
    $sum = $sum + $i;
    my $j = $i * $i;
    #
    #			detect overflow
    #			
    
    if (int(($j) / ($i)) eq $i) {
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
  return $sum;
}

my $n = 100000;
# normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 

my $t = [];
foreach $i (0 .. $n - 1) {
  $t->[$i] = $i;
  }
$t->[1] = 0;
print(eratostene($t, $n));
print("\n");



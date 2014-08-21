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

sub score{
  readspaces();
  my $len = 0;
  $len = readint();
  readspaces();
  my $sum = 0;
  foreach $i (1 .. $len) {
    my $c = '_';
    $c = readchar();
    $sum = $sum + (ord($c) - ord('A'))
    +
    1;
    #		print c print " " print sum print " " 
    
    }
  return $sum;
}

my $sum = 0;
my $n = 0;
$n = readint();
foreach $i (1 .. $n) {
  $sum = $sum + $i
  *
  score();
  }
print($sum);
print("\n");



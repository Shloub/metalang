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

sub isqrt{
  my($c) = @_;
  return int(sqrt($c));
}

sub is_triangular{
  my($n) = @_;
  #
  #   n = k * (k + 1) / 2
  #	  n * 2 = k * (k + 1)
  #   
  
  my $a = isqrt($n * 2);
  return $a * ($a + 1) eq $n * 2;
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
  if (is_triangular($sum)) {
  return 1;
  }else{
  return 0;
  }
}

foreach $i (1 .. 55) {
  if (is_triangular($i)) {
  print($i);
  print(" ");
  }else{
  
  }
  }
print("\n");
my $sum = 0;
my $n = 0;
$n = readint();
foreach $i (1 .. $n) {
  $sum = $sum + score();
  }
print($sum);
print("\n");



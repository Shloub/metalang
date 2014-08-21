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

my $a = 1;
my $b = 2;
my $sum = 0;
while ($a < 4000000)
{
  if ((remainder($a, 2)) eq 0) {
  $sum = $sum + $a;
  }else{
  
  }
  my $c = $a;
  $a = $b;
  $b = $b + $c;
}
print($sum);
print("\n");



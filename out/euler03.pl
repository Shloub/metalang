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

my $maximum = 1;
my $b0 = 2;
my $a = 408464633;
while ($a ne 1)
{
  my $b = $b0;
  my $found = 0;
  while ($b * $b < $a)
  {
    if ((remainder($a, $b)) eq 0) {
    $a = int(($a) / ($b));
    $b0 = $b;
    $b = $a;
    $found = 1;
    }else{
    
    }
    $b = $b + 1;
  }
  if (!$found) {
  print($a);
  print("\n");
  $a = 1;
  }else{
  
  }
}



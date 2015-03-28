#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar;
  return $o;
}
sub readint {
  nextchar() if (!defined $currentchar);
  my $o = 0, $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar;
  }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar;
  }
  return $o * $sign;
}
sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub score{
  readspaces();
  my $len = readint();
  readspaces();
  my $sum = 0;
  foreach my $i (1 .. $len) {
    my $c = readchar();
    $sum = $sum + (ord($c) - ord("A")) + 1;
    #		print c print " " print sum print " " 
    
  }
  return $sum;
}

my $sum = 0;
my $n = readint();
foreach my $i (1 .. $n) {
  $sum = $sum + $i * score();
}
print($sum, "\n");



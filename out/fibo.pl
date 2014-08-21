#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readint {
  if (!defined $currentchar){
     nextchar();
  }
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar();
  }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

#
#La suite de fibonaci
#

sub fibo_{
  my($a,
  $b,
  $i) = @_;
  my $out_ = 0;
  my $a2 = $a;
  my $b2 = $b;
  foreach my $j (0 .. $i + 1) {
    $out_ = $out_ + $a2;
    my $tmp = $b2;
    $b2 = $b2 + $a2;
    $a2 = $tmp;
    }
  return $out_;
}

my $a = 0;
my $b = 0;
my $i = 0;
$a = readint();
readspaces();
$b = readint();
readspaces();
$i = readint();
print(fibo_($a, $b, $i));



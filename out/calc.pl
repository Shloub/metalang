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

#
#La suite de fibonaci
#

sub fibo{
  my($a,
  $b,
  $i) = @_;
  my $out_ = 0;
  my $a2 = $a;
  my $b2 = $b;
  foreach $j (0 .. $i + 1) {
    print($j);
    $out_ = $out_ + $a2;
    my $tmp = $b2;
    $b2 = $b2 + $a2;
    $a2 = $tmp;
    }
  return $out_;
}

print(fibo(1, 2, 4));



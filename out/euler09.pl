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
#	a + b + c = 1000 && a * a + b * b = c * c
#	

foreach $a (1 .. 1000) {
  foreach $b ($a + 1 .. 1000) {
    my $c = 1000 - $a - $b;
    my $a2b2 = $a * $a + $b * $b;
    my $cc = $c * $c;
    if ($cc eq $a2b2 && $c > $a) {
    print($a);
    print("\n");
    print($b);
    print("\n");
    print($c);
    print("\n");
    print($a
    *
    $b
    *
    $c);
    print("\n");
    }else{
    
    }
    }
  }



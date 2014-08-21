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

sub divisible{
  my($n,
  $t,
  $size) = @_;
  foreach $i (0 .. $size - 1) {
    if ((remainder($n, $t->[$i])) eq 0) {
    return 1;
    }else{
    
    }
    }
  return 0;
}

sub find{
  my($n,
  $t,
  $used,
  $nth) = @_;
  while ($used ne $nth)
  {
    if (divisible($n, $t, $used)) {
    $n = $n + 1;
    }else{
    $t->[$used] = $n;
    $n = $n + 1;
    $used = $used + 1;
    }
  }
  return $t->[$used - 1];
}

my $n = 10001;
my $t = [];
foreach $i (0 .. $n - 1) {
  $t->[$i] = 2;
  }
print(find(3, $t, 1, $n));
print("\n");



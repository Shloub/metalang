#!/usr/bin/perl

sub min2{
  my($a,
  $b) = @_;
  if ($a < $b) {
  return $a;
  }else{
  return $b;
  }
}

my $e = 2;
my $f = 3;
my $g = 4;
print(min2(min2($e, $f), $g), " ");
my $i = 2;
my $j = 4;
my $k = 3;
print(min2(min2($i, $j), $k), " ");
my $m = 3;
my $n = 2;
my $o = 4;
print(min2(min2($m, $n), $o), " ");
my $q = 3;
my $r = 4;
my $s = 2;
print(min2(min2($q, $r), $s), " ");
my $u = 4;
my $v = 2;
my $w = 3;
print(min2(min2($u, $v), $w), " ");
my $y = 4;
my $z = 3;
my $ba = 2;
print(min2(min2($y, $z), $ba), "\n");



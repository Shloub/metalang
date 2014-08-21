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

sub max2{
  my($a,
  $b) = @_;
  if ($a > $b) {
  return $a;
  }else{
  return $b;
  }
}

#
#
#(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
#a * d + a * e * 10 + a * f * 100 +
#10 * (b * d + b * e * 10 + b * f * 100)+
#100 * (c * d + c * e * 10 + c * f * 100) =
#
#a * d       + a * e * 10   + a * f * 100 +
#b * d * 10  + b * e * 100  + b * f * 1000 +
#c * d * 100 + c * e * 1000 + c * f * 10000 =
#
#a * d +
#10 * ( a * e + b * d) +
#100 * (a * f + b * e + c * d) +
#(c * e + b * f) * 1000 +
#c * f * 10000
#
#

sub chiffre{
  my($c,
  $m) = @_;
  if ($c eq 0) {
  return remainder($m, 10);
  }else{
  return chiffre($c - 1, int(($m) / (10)));
  }
}

my $m = 1;
foreach $a (0 .. 9) {
  foreach $f (1 .. 9) {
    foreach $d (0 .. 9) {
      foreach $c (1 .. 9) {
        foreach $b (0 .. 9) {
          foreach $e (0 .. 9) {
            my $mul = $a * $d + 10 * ($a * $e + $b * $d) + 100 * ($a * $f + $b * $e + $c * $d) + 1000 * ($c * $e + $b * $f) + 10000 * $c * $f;
            if (chiffre(0, $mul) eq chiffre(5, $mul) && chiffre(1, $mul) eq chiffre(4, $mul) && chiffre(2, $mul) eq chiffre(3, $mul)) {
            $m = max2($mul, $m);
            }else{
            
            }
            }
          }
        }
      }
    }
  }
print($m);
print("\n");



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

sub min2{
  my($a,
  $b) = @_;
  if ($a < $b) {
  return $a;
  }else{
  return $b;
  }
}

sub pgcd{
  my($a,
  $b) = @_;
  my $c = min2($a, $b);
  my $d = max2($a, $b);
  my $reste = remainder($d, $c);
  if ($reste eq 0) {
  return $c;
  }else{
  return pgcd($c, $reste);
  }
}

my $top = 1;
my $bottom = 1;
foreach $i (1 .. 9) {
  foreach $j (1 .. 9) {
    foreach $k (1 .. 9) {
      if ($i ne $j && $j ne $k) {
      my $a = $i * 10 + $j;
      my $b = $j * 10 + $k;
      if ($a * $k eq $i * $b) {
      print($a);
      print("/");
      print($b);
      print("\n");
      $top = $top * $a;
      $bottom = $bottom * $b;
      }else{
      
      }
      }else{
      
      }
      }
    }
  }
print($top);
print("/");
print($bottom);
print("\n");
my $p = pgcd($top, $bottom);
print("pgcd=");
print($p);
print("\n");
print(int(($bottom) / ($p)));
print("\n");



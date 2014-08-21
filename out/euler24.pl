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

sub fact{
  my($n) = @_;
  my $prod = 1;
  foreach $i (2 .. $n) {
    $prod = $prod * $i;
    }
  return $prod;
}

sub show{
  my($lim,
  $nth) = @_;
  my $t = [];
  foreach $i (0 .. $lim - 1) {
    $t->[$i] = $i;
    }
  my $pris = [];
  foreach $j (0 .. $lim - 1) {
    $pris->[$j] = 0;
    }
  foreach $k (1 .. $lim - 1) {
    my $n = fact($lim - $k);
    my $nchiffre = int(($nth) / ($n));
    $nth = remainder($nth, $n);
    foreach $l (0 .. $lim - 1) {
      if (!$pris->[$l]) {
      if ($nchiffre eq 0) {
      print($l);
      $pris->[$l] = 1;
      }else{
      
      }
      $nchiffre = $nchiffre - 1;
      }else{
      
      }
      }
    }
  foreach $m (0 .. $lim - 1) {
    if (!$pris->[$m]) {
    print($m);
    }else{
    
    }
    }
  print("\n");
}

show(10, 999999);



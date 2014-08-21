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

sub periode{
  my($restes,
  $len,
  $a,
  $b) = @_;
  while ($a ne 0)
  {
    my $chiffre = int(($a) / ($b));
    my $reste = remainder($a, $b);
    foreach $i (0 .. $len - 1) {
      if ($restes->[$i] eq $reste) {
      return $len - $i;
      }else{
      
      }
      }
    $restes->[$len] = $reste;
    $len = $len + 1;
    $a = $reste * 10;
  }
  return 0;
}

my $c = 1000;
my $t = [];
foreach $j (0 .. $c - 1) {
  $t->[$j] = 0;
  }
my $m = 0;
my $mi = 0;
foreach $i (1 .. 1000) {
  my $p = periode($t, 0, 1, $i);
  if ($p > $m) {
  $mi = $i;
  $m = $p;
  }else{
  
  }
  }
print($mi);
print("\n");
print($m);
print("\n");



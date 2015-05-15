#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
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

sub go0{
  my($tab, $a, $b) = @_;
  my $m = int(($a + $b) / 2);
  if ($a eq $m) {
    if ($tab->[$a] eq $m) {
      return $b;
    }else{
      return $a;
    }
  }
  my $i = $a;
  my $j = $b;
  while ($i < $j)
  {
    my $e = $tab->[$i];
    if ($e < $m) {
      $i = $i + 1;
    }else{
      $j = $j - 1;
      $tab->[$i] = $tab->[$j];
      $tab->[$j] = $e;
    }
  }
  if ($i < $m) {
    return go0($tab, $a, $m);
  }else{
    return go0($tab, $m, $b);
  }
}

sub plus_petit0{
  my($tab, $len) = @_;
  return go0($tab, 0, $len);
}

my $len = 0;
$len = readint();
readspaces();
my $tab = [];
foreach my $i (0 .. $len - 1) {
  my $tmp = 0;
  $tmp = readint();
  readspaces();
  $tab->[$i] = $tmp;
}
print plus_petit0($tab, $len);



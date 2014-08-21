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

sub go_{
  my($tab,
  $a,
  $b) = @_;
  my $m = int(($a + $b) / (2));
  if ($a eq $m) {
  if ($tab->[$a] eq $m) {
  return $b;
  }else{
  return $a;
  }
  }else{
  
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
  return go_($tab, $a, $m);
  }else{
  return go_($tab, $m, $b);
  }
}

sub plus_petit_{
  my($tab,
  $len) = @_;
  return go_($tab, 0, $len);
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
print(plus_petit_($tab, $len));



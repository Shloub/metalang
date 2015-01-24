#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readint {
  nextchar() if (!defined $currentchar);
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

my $f = readint();
readspaces();
my $len = $f;
print($len, "=len\n");
my $tab1 = [];
foreach my $k (0 .. $len - 1) {
  $tab1->[$k] = readint();
  readspaces();
  }
foreach my $i (0 .. $len - 1) {
  print($i, "=>", $tab1->[$i], "\n");
  }
$len = readint();
readspaces();
my $tab2 = [];
foreach my $s (0 .. $len - 1 - 1) {
  my $ba = [];
  foreach my $v (0 .. $len - 1) {
    my $w = readint();
    readspaces();
    $ba->[$v] = $w;
    }
  $tab2->[$s] = $ba;
  }
foreach my $i (0 .. $len - 2) {
  foreach my $j (0 .. $len - 1) {
    print($tab2->[$i]->[$j], " ");
    }
  print("\n");
  }



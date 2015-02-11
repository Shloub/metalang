#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar();
  return $o;
}
sub readint {
  nextchar() if (!defined $currentchar);
  my $o = 0, $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar();
  }
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
#Ce test permet de vérifier si les différents backends pour les langages implémentent bien
#read int, read char et skip
#

my $len = readint();
readspaces();
print($len, "=len\n");
$len = $len * 2;
print("len*2=", $len, "\n");
$len = int(($len) / (2));
my $tab = [];
foreach my $i (0 .. $len - 1) {
  my $tmpi1 = readint();
  readspaces();
  print($i, "=>", $tmpi1, " ");
  $tab->[$i] = $tmpi1;
}
print("\n");
my $tab2 = [];
foreach my $i_ (0 .. $len - 1) {
  my $tmpi2 = readint();
  readspaces();
  print($i_, "==>", $tmpi2, " ");
  $tab2->[$i_] = $tmpi2;
}
my $strlen = readint();
readspaces();
print($strlen, "=strlen\n");
my $tab4 = [];
foreach my $toto (0 .. $strlen - 1) {
  my $tmpc = readchar();
  my $c = ord($tmpc);
  print($tmpc, ":", $c, " ");
  if ($tmpc ne ' ') {
    $c = remainder(($c - ord('a')) + 13, 26) + ord('a');
  }
  $tab4->[$toto] = chr($c);
}
foreach my $j (0 .. $strlen - 1) {
  print($tab4->[$j]);
}



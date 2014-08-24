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

sub read_int_matrix{
  my($x,
  $y) = @_;
  my $tab = [];
  foreach my $z (0 .. $y - 1) {
    my $b = [];
    foreach my $c (0 .. $x - 1) {
      my $d = readint();
      readspaces();
      $b->[$c] = $d;
      }
    my $a = $b;
    $tab->[$z] = $a;
    }
  return $tab;
}

my $f = readint();
readspaces();
my $len = $f;
print($len, "=len\n");
my $h = [];
foreach my $k (0 .. $len - 1) {
  my $l = readint();
  readspaces();
  $h->[$k] = $l;
  }
my $tab1 = $h;
foreach my $i (0 .. $len - 1) {
  print($i, "=>", $tab1->[$i], "\n");
  }
my $o = readint();
readspaces();
$len = $o;
my $tab2 = read_int_matrix($len, $len - 1);
foreach my $i (0 .. $len - 2) {
  foreach my $j (0 .. $len - 1) {
    print($tab2->[$i]->[$j], " ");
    }
  print("\n");
  }



#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  if (!defined $currentchar){ nextchar() ; }
  my $o = $currentchar;
  nextchar();
  return $o;
}
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
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub read_int{
  my $out_ = 0;
  $out_ = readint();
  readspaces();
  return $out_;
}

sub read_int_line{
  my($n) = @_;
  my $tab = [];
  foreach my $i (0 .. $n - 1) {
    my $t = 0;
    $t = readint();
    readspaces();
    $tab->[$i] = $t;
    }
  return $tab;
}

sub read_char_line{
  my($n) = @_;
  my $tab = [];
  foreach my $i (0 .. $n - 1) {
    my $t = '_';
    $t = readchar();
    $tab->[$i] = $t;
    }
  readspaces();
  return $tab;
}

#
#Ce test permet de vérifier si les différents backends pour les langages implémentent bien
#read int, read char et skip
#

my $len = read_int();
print($len, "=len\n");
my $tab = read_int_line($len);
foreach my $i (0 .. $len - 1) {
  print($i, "=>", $tab->[$i], " ");
  }
print("\n");
my $tab2 = read_int_line($len);
foreach my $i_ (0 .. $len - 1) {
  print($i_, "==>", $tab2->[$i_], " ");
  }
my $strlen = read_int();
print($strlen, "=strlen\n");
my $tab4 = read_char_line($strlen);
foreach my $i3 (0 .. $strlen - 1) {
  my $tmpc = $tab4->[$i3];
  my $c = ord($tmpc);
  print($tmpc, ":", $c, " ");
  if ($tmpc ne ' ') {
  $c = remainder(($c - ord('a')) + 13, 26) + ord('a');
  }else{
  
  }
  $tab4->[$i3] = chr($c);
  }
foreach my $j (0 .. $strlen - 1) {
  print($tab4->[$j]);
  }



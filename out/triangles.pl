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
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar(); }
}

# Ce code a été généré par metalang
#   Il gère les entrées sorties pour un programme dynamique classique
#   dans les épreuves de prologin
#on le retrouve ici : http://projecteuler.net/problem=18
#

sub find0{
  my($len, $tab, $cache, $x, $y) = @_;
  #
  #	Cette fonction est récursive
  #	
  
  if ($y eq $len - 1) {
    return $tab->[$y]->[$x];
  }elsif ($x > $y) {
    return -10000;
  }elsif ($cache->[$y]->[$x] ne 0) {
    return $cache->[$y]->[$x];
  }
  my $result = 0;
  my $out0 = find0($len, $tab, $cache, $x, $y + 1);
  my $out1 = find0($len, $tab, $cache, $x + 1, $y + 1);
  if ($out0 > $out1) {
    $result = $out0 + $tab->[$y]->[$x];
  }else{
    $result = $out1 + $tab->[$y]->[$x];
  }
  $cache->[$y]->[$x] = $result;
  return $result;
}

sub find{
  my($len, $tab) = @_;
  my $tab2 = [];
  foreach my $i (0 .. $len - 1) {
    my $tab3 = [];
    foreach my $j (0 .. $i + 1 - 1) {
      $tab3->[$j] = 0;
    }
    $tab2->[$i] = $tab3;
  }
  return find0($len, $tab, $tab2, 0, 0);
}

my $len = 0;
$len = readint();
readspaces();
my $tab = [];
foreach my $i (0 .. $len - 1) {
  my $tab2 = [];
  foreach my $j (0 .. $i + 1 - 1) {
    my $tmp = 0;
    $tmp = readint();
    readspaces();
    $tab2->[$j] = $tmp;
  }
  $tab->[$i] = $tab2;
}
print(find($len, $tab), "\n");
foreach my $k (0 .. $len - 1) {
  foreach my $l (0 .. $k) {
    print($tab->[$k]->[$l], " ");
  }
  print "\n";
}



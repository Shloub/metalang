#!/usr/bin/perl
use List::Util qw(min max);
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar;
  return $o;
}
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

sub pathfind_aux{
  my($cache, $tab, $x, $y, $posX, $posY) = @_;
  if ($posX eq $x - 1 && $posY eq $y - 1) {
    return 0;
  }elsif ($posX < 0 || $posY < 0 || $posX >= $x || $posY >= $y) {
    return $x * $y * 10;
  }elsif ($tab->[$posY]->[$posX] eq "#") {
    return $x * $y * 10;
  }elsif ($cache->[$posY]->[$posX] ne -1) {
    return $cache->[$posY]->[$posX];
  }else{
    $cache->[$posY]->[$posX] = $x * $y * 10;
    my $val1 = pathfind_aux($cache, $tab, $x, $y, $posX + 1, $posY);
    my $val2 = pathfind_aux($cache, $tab, $x, $y, $posX - 1, $posY);
    my $val3 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY - 1);
    my $val4 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY + 1);
    my $out0 = 1 + min($val1, $val2, $val3, $val4);
    $cache->[$posY]->[$posX] = $out0;
    return $out0;
  }
}

sub pathfind{
  my($tab, $x, $y) = @_;
  my $cache = [];
  foreach my $i (0 .. $y - 1) {
    my $tmp = [];
    foreach my $j (0 .. $x - 1) {
      $tmp->[$j] = -1;
    }
    $cache->[$i] = $tmp;
  }
  return pathfind_aux($cache, $tab, $x, $y, 0, 0);
}

my $x = 0;
my $y = 0;
$x = readint();
readspaces();
$y = readint();
readspaces();
my $tab = [];
foreach my $i (0 .. $y - 1) {
  my $tab2 = [];
  foreach my $j (0 .. $x - 1) {
    my $tmp = "\x00";
    $tmp = readchar();
    $tab2->[$j] = $tmp;
  }
  readspaces();
  $tab->[$i] = $tab2;
}
my $result = pathfind($tab, $x, $y);
print $result;



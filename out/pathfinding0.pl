#!/usr/bin/perl
use List::Util qw(min max);
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar();
  return $o;
}
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

sub pathfind_aux{
  my($cache,
  $tab,
  $x,
  $y,
  $posX,
  $posY) = @_;
  if ($posX eq $x - 1 && $posY eq $y - 1) {
    return 0;
  }elsif ($posX < 0 || $posY < 0 || $posX >= $x || $posY >= $y) {
    return $x * $y * 10;
  }elsif ($tab->[$posY]->[$posX] eq '#') {
    return $x * $y * 10;
  }elsif ($cache->[$posY]->[$posX] ne -1) {
    return $cache->[$posY]->[$posX];
  }else{
    $cache->[$posY]->[$posX] = $x * $y * 10;
    my $val1 = pathfind_aux($cache, $tab, $x, $y, $posX + 1, $posY);
    my $val2 = pathfind_aux($cache, $tab, $x, $y, $posX - 1, $posY);
    my $val3 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY - 1);
    my $val4 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY + 1);
    my $k = min($val1, $val2, $val3, $val4);
    my $out_ = 1 + $k;
    $cache->[$posY]->[$posX] = $out_;
    return $out_;
  }
}

sub pathfind{
  my($tab,
  $x,
  $y) = @_;
  my $cache = [];
  foreach my $i (0 .. $y - 1) {
    my $tmp = [];
    foreach my $j (0 .. $x - 1) {
      print($tab->[$i]->[$j]);
      $tmp->[$j] = -1;
      }
    print("\n");
    $cache->[$i] = $tmp;
    }
  return pathfind_aux($cache, $tab, $x, $y, 0, 0);
}

my $m = readint();
readspaces();
my $x = $m;
my $p = readint();
readspaces();
my $y = $p;
print($x, " ", $y, "\n");
my $r = [];
foreach my $s (0 .. $y - 1) {
  my $u = [];
  foreach my $v (0 .. $x - 1) {
    my $w = readchar();
    $u->[$v] = $w;
    }
  readspaces();
  $r->[$s] = $u;
  }
my $tab = $r;
my $result = pathfind($tab, $x, $y);
print($result);



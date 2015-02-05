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

sub pathfind_aux{
  my($cache, $tab, $len, $pos) = @_;
  if ($pos >= $len - 1) {
    return 0;
  }elsif ($cache->[$pos] ne -1) {
    return $cache->[$pos];
  }else{
    $cache->[$pos] = $len * 2;
    my $posval = pathfind_aux($cache, $tab, $len, $tab->[$pos]);
    my $oneval = pathfind_aux($cache, $tab, $len, $pos + 1);
    my $out0 = 0;
    if ($posval < $oneval) {
      $out0 = 1 + $posval;
    }else{
      $out0 = 1 + $oneval;
    }
    $cache->[$pos] = $out0;
    return $out0;
  }
}

sub pathfind{
  my($tab, $len) = @_;
  my $cache = [];
  foreach my $i (0 .. $len - 1) {
    $cache->[$i] = -1;
  }
  return pathfind_aux($cache, $tab, $len, 0);
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
my $result = pathfind($tab, $len);
print($result);



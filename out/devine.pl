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

sub devine0{
  my($nombre, $tab, $len) = @_;
  my $min0 = $tab->[0];
  my $max0 = $tab->[1];
  foreach my $i (2 .. $len - 1) {
    if ($tab->[$i] > $max0 || $tab->[$i] < $min0) {
      return 0;
    }
    if ($tab->[$i] < $nombre) {
      $min0 = $tab->[$i];
    }
    if ($tab->[$i] > $nombre) {
      $max0 = $tab->[$i];
    }
    if ($tab->[$i] eq $nombre && $len ne $i + 1) {
      return 0;
    }
  }
  return 1;
}

my $nombre = readint();
readspaces();
my $len = readint();
readspaces();
my $tab = [];
foreach my $i (0 .. $len - 1) {
  my $tmp = readint();
  readspaces();
  $tab->[$i] = $tmp;
}
my $a = devine0($nombre, $tab, $len);
if ($a) {
  print "True";
}else{
  print "False";
}



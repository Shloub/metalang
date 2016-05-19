#!/usr/bin/perl
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
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar(); }
}

sub nth{
  my($tab, $tofind, $len) = @_;
  my $out0 = 0;
  foreach my $i (0 .. $len - 1) {
    if ($tab->[$i] eq $tofind) {
      $out0 = $out0 + 1;
    }
  }
  return $out0;
}

my $len = 0;
$len = readint();
readspaces();
my $tofind = "\x00";
$tofind = readchar();
readspaces();
my $tab = [];
foreach my $i (0 .. $len - 1) {
  my $tmp = "\x00";
  $tmp = readchar();
  $tab->[$i] = $tmp;
}
my $result = nth($tab, $tofind, $len);
print $result;



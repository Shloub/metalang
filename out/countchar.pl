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

sub nth{
  my($tab,
  $tofind,
  $len) = @_;
  my $out_ = 0;
  foreach my $i (0 .. $len - 1) {
    if ($tab->[$i] eq $tofind) {
    $out_ = $out_ + 1;
    }
    }
  return $out_;
}

my $len = 0;
$len = readint();
readspaces();
my $tofind = '\000';
$tofind = readchar();
readspaces();
my $tab = [];
foreach my $i (0 .. $len - 1) {
  my $tmp = '\000';
  $tmp = readchar();
  $tab->[$i] = $tmp;
  }
my $result = nth($tab, $tofind, $len);
print($result);



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

#
#Ce test effectue un rot13 sur une chaine lue en entrée
#

my $strlen = readint();
readspaces();
my $tab4 = [];
foreach my $toto (0 .. $strlen - 1) {
  my $tmpc = readchar();
  my $c = ord($tmpc);
  if ($tmpc ne ' ') {
    $c = remainder(($c - ord('a')) + 13, 26) + ord('a');
  }
  $tab4->[$toto] = chr($c);
  }
foreach my $j (0 .. $strlen - 1) {
  print($tab4->[$j]);
  }



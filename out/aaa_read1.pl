#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar();
  return $o;
}
sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

my $str = [];
foreach my $d (0 .. 12 - 1) {
  $str->[$d] = readchar();
  }
readspaces();
foreach my $i (0 .. 11) {
  print($str->[$i]);
  }



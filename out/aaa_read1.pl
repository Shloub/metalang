#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  if (!defined $currentchar){ nextchar() ; }
  my $o = $currentchar;
  nextchar();
  return $o;
}
sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

my $c = [];
foreach my $d (0 .. 12 - 1) {
  $c->[$d] = readchar();
  }
readspaces();
my $str = $c;
foreach my $i (0 .. 11) {
  print($str->[$i]);
  }



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

my $b = 12;
my $c = [];
foreach my $d (0 .. $b - 1) {
  my $e = '_';
  $e = readchar();
  $c->[$d] = $e;
  }
readspaces();
my $a = $c;
my $str = $a;
foreach my $i (0 .. 11) {
  print($str->[$i]);
  }



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

sub read_char_line{
  my($n) = @_;
  my $tab = [];
  foreach my $i (0 .. $n - 1) {
    my $t = '_';
    $t = readchar();
    $tab->[$i] = $t;
    }
  readspaces();
  return $tab;
}

my $str = read_char_line(12);
foreach my $i (0 .. 11) {
  print($str->[$i]);
  }



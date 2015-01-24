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

sub programme_candidat{
  my($tableau,
  $taille) = @_;
  my $out0 = 0;
  foreach my $i (0 .. $taille - 1) {
    $out0 = $out0 + $tableau->[$i];
    }
  return $out0;
}

my $b = readint();
readspaces();
my $taille = $b;
my $tableau = [];
foreach my $e (0 .. $taille - 1) {
  $tableau->[$e] = readint();
  readspaces();
  }
print(programme_candidat($tableau, $taille), "\n");



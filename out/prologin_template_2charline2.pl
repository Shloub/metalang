#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar();
  return $o;
}
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
  my($tableau1,
  $taille1,
  $tableau2,
  $taille2) = @_;
  my $out0 = 0;
  foreach my $i (0 .. $taille1 - 1) {
    $out0 = $out0 + ord($tableau1->[$i]) *
    $i;
    print($tableau1->[$i]);
    }
  print("--\n");
  foreach my $j (0 .. $taille2 - 1) {
    $out0 = $out0 + ord($tableau2->[$j]) *
    $j *
    100;
    print($tableau2->[$j]);
    }
  print("--\n");
  return $out0;
}

my $taille1 = readint();
readspaces();
my $taille2 = readint();
readspaces();
my $tableau1 = [];
foreach my $g (0 .. $taille1 - 1) {
  $tableau1->[$g] = readchar();
  }
readspaces();
my $tableau2 = [];
foreach my $m (0 .. $taille2 - 1) {
  $tableau2->[$m] = readchar();
  }
readspaces();
print(programme_candidat($tableau1, $taille1, $tableau2, $taille2), "\n");



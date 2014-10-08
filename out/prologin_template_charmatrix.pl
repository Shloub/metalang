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
  my($tableau,
  $taille_x,
  $taille_y) = @_;
  my $out0 = 0;
  foreach my $i (0 .. $taille_y - 1) {
    foreach my $j (0 .. $taille_x - 1) {
      $out0 = $out0 + ord($tableau->[$i]->[$j]) *
      ($i + $j * 2);
      print($tableau->[$i]->[$j]);
      }
    print("--\n");
    }
  return $out0;
}

my $f = readint();
readspaces();
my $taille_x = $f;
my $h = readint();
readspaces();
my $taille_y = $h;
my $l = [];
foreach my $m (0 .. $taille_y - 1) {
  my $o = [];
  foreach my $p (0 .. $taille_x - 1) {
    my $q = readchar();
    $o->[$p] = $q;
    }
  readspaces();
  $l->[$m] = $o;
  }
my $tableau = $l;
print(programme_candidat($tableau, $taille_x, $taille_y), "\n");



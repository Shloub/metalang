#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
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

sub read_int_matrix{
  my($x,
  $y) = @_;
  my $tab = [];
  foreach my $z (0 .. $y - 1) {
    my $b = [];
    foreach my $c (0 .. $x - 1) {
      my $d = 0;
      $d = readint();
      readspaces();
      $b->[$c] = $d;
      }
    my $a = $b;
    $tab->[$z] = $a;
    }
  return $tab;
}

sub programme_candidat{
  my($tableau,
  $x,
  $y) = @_;
  my $out_ = 0;
  foreach my $i (0 .. $y - 1) {
    foreach my $j (0 .. $x - 1) {
      $out_ = $out_ + $tableau->[$i]->[$j]
      *
      ($i * 2 + $j);
      }
    }
  return $out_;
}

my $f = 0;
$f = readint();
readspaces();
my $taille_x = $f;
my $h = 0;
$h = readint();
readspaces();
my $taille_y = $h;
my $tableau = read_int_matrix($taille_x, $taille_y);
print(programme_candidat($tableau, $taille_x, $taille_y), "\n");



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

sub read_int{
  my $out_ = 0;
  $out_ = readint();
  readspaces();
  return $out_;
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

sub read_char_matrix{
  my($x,
  $y) = @_;
  my $tab = [];
  foreach my $z (0 .. $y - 1) {
    $tab->[$z] = read_char_line($x);
    }
  return $tab;
}

sub programme_candidat{
  my($tableau,
  $taille_x,
  $taille_y) = @_;
  my $out_ = 0;
  foreach my $i (0 .. $taille_y - 1) {
    foreach my $j (0 .. $taille_x - 1) {
      $out_ = $out_ + ord($tableau->[$i]->[$j])
      *
      ($i + $j * 2);
      print($tableau->[$i]->[$j]);
      }
    print("--\n");
    }
  return $out_;
}

my $taille_x = read_int();
my $taille_y = read_int();
my $tableau = read_char_matrix($taille_x, $taille_y);
print(programme_candidat($tableau, $taille_x, $taille_y), "\n");



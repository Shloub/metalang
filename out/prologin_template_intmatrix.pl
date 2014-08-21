#!/usr/bin/perl

sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
    if (!defined $currentchar){ nextchar() ; }
    my $o = $currentchar; nextchar(); return $o; }
sub readint {
    if (!defined $currentchar){ nextchar(); }
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') { $sign = -1; nextchar(); }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}

sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub read_int{
  my $out_ = 0;
  $out_ = readint();
  readspaces();
  return $out_;
}

sub read_int_line{
  my($n) = @_;
  my $tab = [];
  foreach $i (0 .. $n - 1) {
    my $t = 0;
    $t = readint();
    readspaces();
    $tab->[$i] = $t;
    }
  return $tab;
}

sub read_int_matrix{
  my($x,
  $y) = @_;
  my $tab = [];
  foreach $z (0 .. $y - 1) {
    $tab->[$z] = read_int_line($x);
    }
  return $tab;
}

sub programme_candidat{
  my($tableau,
  $x,
  $y) = @_;
  my $out_ = 0;
  foreach $i (0 .. $y - 1) {
    foreach $j (0 .. $x - 1) {
      $out_ = $out_ + $tableau->[$i]->[$j]
      *
      ($i * 2 + $j);
      }
    }
  return $out_;
}

my $taille_x = read_int();
my $taille_y = read_int();
my $tableau = read_int_matrix($taille_x, $taille_y);
print(programme_candidat($tableau, $taille_x, $taille_y));
print("\n");



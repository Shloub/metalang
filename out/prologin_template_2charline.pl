#!/usr/bin/perl

sub programme_candidat{
  my($tableau1, $taille1, $tableau2, $taille2) = @_;
  my $out0 = 0;
  foreach my $i (0 .. $taille1 - 1)
  {
      $out0 = $out0 + ord($tableau1->[$i]) * $i;
      print $tableau1->[$i];
  }
  print "--\n";
  foreach my $j (0 .. $taille2 - 1)
  {
      $out0 = $out0 + ord($tableau2->[$j]) * $j * 100;
      print $tableau2->[$j];
  }
  print "--\n";
  return $out0;
}

my $taille1 = int( <STDIN> );
my $tableau1 = [split(//, <STDIN>)];
my $taille2 = int( <STDIN> );
my $tableau2 = [split(//, <STDIN>)];
print(programme_candidat($tableau1, $taille1, $tableau2, $taille2), "\n");



#!/usr/bin/perl

sub programme_candidat{
  my($tableau, $taille_x, $taille_y) = @_;
  my $out0 = 0;
  foreach my $i (0 .. $taille_y - 1)
  {
      foreach my $j (0 .. $taille_x - 1)
      {
          $out0 = $out0 + ord($tableau->[$i]->[$j]) * ($i + $j * 2);
          print $tableau->[$i]->[$j];
      }
      print "--\n";
  }
  return $out0;
}

my $taille_x = int( <STDIN> );
my $taille_y = int( <STDIN> );
my $a = [];
foreach my $b (0 .. $taille_y - 1)
{
    $a->[$b] = [split(//, <STDIN>)];
}
my $tableau = $a;
print(programme_candidat($tableau, $taille_x, $taille_y), "\n");



#!/usr/bin/perl

sub programme_candidat{
  my($tableau, $x, $y) = @_;
  my $out0 = 0;
  foreach my $i (0 .. $y - 1)
  {
      foreach my $j (0 .. $x - 1)
      {
          $out0 = $out0 + $tableau->[$i]->[$j] * ($i * 2 + $j);
      }
  }
  return $out0;
}

my $taille_x = int( <STDIN> );
my $taille_y = int( <STDIN> );
my $tableau = [];
foreach my $a (0 .. $taille_y - 1)
{
    $tableau->[$a] = [ map { int($_) } split(/\s+/, <STDIN>) ];
}
print(programme_candidat($tableau, $taille_x, $taille_y), "\n");



#!/usr/bin/perl

sub programme_candidat{
  my($tableau, $taille) = @_;
  my $out0 = 0;
  foreach my $i (0 .. $taille - 1)
  {
      $out0 = $out0 + $tableau->[$i];
  }
  return $out0;
}
my $taille = int( <STDIN> );
my $tableau = [ map { int($_) } split(/\s+/, <STDIN>) ];
print(programme_candidat($tableau, $taille), "\n");



#!/usr/bin/perl

sub programme_candidat{
  my($tableau, $taille) = @_;
  my $out0 = 0;
  foreach my $i (0 .. $taille - 1)
  {
      $out0 = $out0 + ord($tableau->[$i]) * $i;
      print $tableau->[$i];
  }
  print "--\n";
  return $out0;
}
my $taille = int( <STDIN> );
my $tableau = [split(//, <STDIN>)];
print(programme_candidat($tableau, $taille), "\n");



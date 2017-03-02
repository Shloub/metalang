#!/usr/bin/perl

#
#  Ce test a été généré par Metalang.
#

sub result{
  my($len, $tab) = @_;
  my $tab2 = [];
  foreach my $i (0 .. $len - 1)
  {
      $tab2->[$i] = !(1);
  }
  foreach my $i1 (0 .. $len - 1)
  {
      print($tab->[$i1], " ");
      $tab2->[$tab->[$i1]] = !(0);
  }
  print "\n";
  foreach my $i2 (0 .. $len - 1)
  {
      if (!$tab2->[$i2])
      {
          return $i2;
      }
  }
  return -1;
}
my $len = int( <STDIN> );
print($len, "\n");
my $tab = [ map { int($_) } split(/\s+/, <STDIN>) ];
print(result($len, $tab), "\n");



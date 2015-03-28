#!/usr/bin/perl

#
#TODO ajouter un record qui contient des chaines.
#

sub idstring{
  my($s) = @_;
  return $s;
}

sub printstring{
  my($s) = @_;
  print(idstring($s), "\n");
}

my $tab = [];
foreach my $i (0 .. 2 - 1) {
  $tab->[$i] = idstring("chaine de test");
}
foreach my $j (0 .. 1) {
  printstring(idstring($tab->[$j]));
}



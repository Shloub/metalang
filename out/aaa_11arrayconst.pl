#!/usr/bin/perl

sub test{
  my($tab, $len) = @_;
  foreach my $i (0 .. $len - 1) {
    print($tab->[$i], " ");
  }
  print "\n";
}

my $t = [];
foreach my $i (0 .. 5 - 1) {
  $t->[$i] = 1;
}
test($t, 5);



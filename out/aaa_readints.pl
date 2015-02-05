#!/usr/bin/perl

my $len = int( <STDIN> );
print($len, "=len\n");
my $tab1 = [ map { int($_) } split(/\s+/, <STDIN>) ];
foreach my $i (0 .. $len - 1) {
  print($i, "=>", $tab1->[$i], "\n");
}
$len = int( <STDIN> );
my $tab2 = [];
foreach my $h (0 .. $len - 1 - 1) {
  $tab2->[$h] = [ map { int($_) } split(/\s+/, <STDIN>) ];
}
foreach my $i (0 .. $len - 2) {
  foreach my $j (0 .. $len - 1) {
    print($tab2->[$i]->[$j], " ");
  }
  print("\n");
}



#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

#
#Ce test permet de vérifier si les différents backends pour les langages implémentent bien
#read int, read char et skip
#

my $len = int( <STDIN> );
print($len, "=len\n");
my $tab = [ map { int($_) } split(/\s+/, <STDIN>) ];
foreach my $i (0 .. $len - 1) {
  print($i, "=>", $tab->[$i], " ");
}
print "\n";
my $tab2 = [ map { int($_) } split(/\s+/, <STDIN>) ];
foreach my $i_ (0 .. $len - 1) {
  print($i_, "==>", $tab2->[$i_], " ");
}
my $strlen = int( <STDIN> );
print($strlen, "=strlen\n");
my $tab4 = [split(//, <STDIN>)];
foreach my $i3 (0 .. $strlen - 1) {
  my $tmpc = $tab4->[$i3];
  my $c = ord($tmpc);
  print($tmpc, ":", $c, " ");
  if ($tmpc ne ' ') {
    $c = remainder(($c - ord('a')) + 13, 26) + ord('a');
  }
  $tab4->[$i3] = chr($c);
}
foreach my $j (0 .. $strlen - 1) {
  print $tab4->[$j];
}



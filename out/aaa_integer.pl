#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

my $i = 0;
$i = $i - 1;
print($i, "\n");
$i = $i + 55;
print($i, "\n");
$i = $i * 13;
print($i, "\n");
$i = int(($i) / (2));
print($i, "\n");
$i = $i + 1;
print($i, "\n");
$i = int(($i) / (3));
print($i, "\n");
$i = $i - 1;
print($i, "\n");
#
#http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
#

print(int((117) / (17)), "\n", int((117) / (-17)), "\n", int((-117) / (17)), "\n", int((-117) / (-17)), "\n", remainder(117, 17), "\n", remainder(117, -17), "\n", remainder(-117, 17), "\n", remainder(-117, -17), "\n");



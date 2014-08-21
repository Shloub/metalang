#!/usr/bin/perl

sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
    if (!defined $currentchar){ nextchar() ; }
    my $o = $currentchar; nextchar(); return $o; }
sub readint {
    if (!defined $currentchar){ nextchar(); }
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') { $sign = -1; nextchar(); }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}

sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

my $i = 0;
$i = $i - 1;
print($i);
print("\n");
$i = $i + 55;
print($i);
print("\n");
$i = $i * 13;
print($i);
print("\n");
$i = int(($i) / (2));
print($i);
print("\n");
$i = $i + 1;
print($i);
print("\n");
$i = int(($i) / (3));
print($i);
print("\n");
$i = $i - 1;
print($i);
print("\n");
#
#http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
#

print(int((117) / (17)));
print("\n");
print(int((117) / (-17)));
print("\n");
print(int((-117) / (17)));
print("\n");
print(int((-117) / (-17)));
print("\n");
print(remainder(117, 17));
print("\n");
print(remainder(117, -17));
print("\n");
print(remainder(-117, 17));
print("\n");
print(remainder(-117, -17));
print("\n");



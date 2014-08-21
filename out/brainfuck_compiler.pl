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

#
#Ce test permet de tester les macros
#C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
#et qui produit les macros metalang correspondante
#

my $input = ' ';
my $current_pos = 500;
my $a = 1000;
my $mem = [];
foreach $i (0 .. $a - 1) {
  $mem->[$i] = 0;
  }
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$current_pos = $current_pos + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
$mem->[$current_pos] = $mem->[$current_pos] + 1;
while ($mem->[$current_pos] ne 0)
{
  $mem->[$current_pos] = $mem->[$current_pos] - 1;
  $current_pos = $current_pos - 1;
  $mem->[$current_pos] = $mem->[$current_pos] + 1;
  print(chr($mem->[$current_pos]));
  $current_pos = $current_pos + 1;
}



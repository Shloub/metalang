#!/usr/bin/perl

#
#Ce test permet de tester les macros
#C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
#et qui produit les macros metalang correspondante
#

my $input = ' ';
my $current_pos = 500;
my $mem = [];
foreach my $i (0 .. 1000 - 1) {
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



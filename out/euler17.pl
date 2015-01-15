#!/usr/bin/perl

my $one = 3;
my $two = 3;
my $three = 5;
my $four = 4;
my $five = 4;
my $six = 3;
my $seven = 5;
my $eight = 5;
my $nine = 4;
my $ten = 3;
my $eleven = 6;
my $twelve = 6;
my $thirteen = 8;
my $fourteen = 8;
my $fifteen = 7;
my $sixteen = 7;
my $seventeen = 9;
my $eighteen = 8;
my $nineteen = 8;
my $twenty = 6;
my $thirty = 6;
my $forty = 5;
my $fifty = 5;
my $sixty = 5;
my $seventy = 7;
my $eighty = 6;
my $ninety = 6;
my $hundred = 7;
my $thousand = 8;
print($one + $two + $three + $four + $five, "\n");
my $hundred_and = 10;
my $one_to_nine = $one + $two + $three + $four + $five + $six + $seven + $eight + $nine;
print($one_to_nine, "\n");
my $one_to_ten = $one_to_nine + $ten;
my $one_to_twenty = $one_to_ten + $eleven + $twelve + $thirteen + $fourteen + $fifteen + $sixteen + $seventeen + $eighteen + $nineteen + $twenty;
my $one_to_thirty = $one_to_twenty + $twenty * 9 + $one_to_nine + $thirty;
my $one_to_forty = $one_to_thirty + $thirty * 9 + $one_to_nine + $forty;
my $one_to_fifty = $one_to_forty + $forty * 9 + $one_to_nine + $fifty;
my $one_to_sixty = $one_to_fifty + $fifty * 9 + $one_to_nine + $sixty;
my $one_to_seventy = $one_to_sixty + $sixty * 9 + $one_to_nine + $seventy;
my $one_to_eighty = $one_to_seventy + $seventy * 9 + $one_to_nine + $eighty;
my $one_to_ninety = $one_to_eighty + $eighty * 9 + $one_to_nine + $ninety;
my $one_to_ninety_nine = $one_to_ninety + $ninety * 9 + $one_to_nine;
print($one_to_ninety_nine, "\n", 100 * $one_to_nine + $one_to_ninety_nine * 10 + $hundred_and * 9 * 99 + $hundred * 9 + $one + $thousand, "\n");



#!/usr/bin/perl

my $str = [split(//, <STDIN>)];
foreach my $i (0 .. 11) {
  print($str->[$i]);
}



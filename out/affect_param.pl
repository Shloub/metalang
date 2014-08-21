#!/usr/bin/perl

sub foo{
  my($a) = @_;
  $a = 4;
}

my $a = 0;
foo($a);
print($a, "\n");



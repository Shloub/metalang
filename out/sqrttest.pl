#!/usr/bin/perl

sub isqrt{
  my($c) = @_;
  return int(sqrt($c));
}

print(isqrt(4), " ", isqrt(16), " ", isqrt(20), " ", isqrt(1000), " ", isqrt(500), " ", isqrt(10), " ");



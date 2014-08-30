#!/usr/bin/perl

sub min2{
  my($a,
  $b) = @_;
  if ($a < $b) {
  return $a;
  }else{
  return $b;
  }
}

print(min2(min2(2, 3), 4), " ", min2(min2(2, 4), 3), " ", min2(min2(3, 2), 4), " ", min2(min2(3, 4), 2), " ", min2(min2(4, 2), 3), " ", min2(min2(4, 3), 2), "\n");



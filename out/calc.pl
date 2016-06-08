#!/usr/bin/perl

#
#La suite de fibonaci
#

sub fibo{
  my($a, $b, $i) = @_;
  my $out_ = 0;
  my $a2 = $a;
  my $b2 = $b;
  foreach my $j (0 .. $i + 1)
  {
      print $j;
      $out_ = $out_ + $a2;
      my $tmp = $b2;
      $b2 = $b2 + $a2;
      $a2 = $tmp;
  }
  return $out_;
}

print fibo(1, 2, 4);



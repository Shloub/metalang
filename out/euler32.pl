#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

#
#We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
#for example, the 5-digit number, 15234, is 1 through 5 pandigital.
#
#The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
#and product is 1 through 9 pandigital.
#
#Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
#1 through 9 pandigital.
#
#HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
#
#
#(a * 10 + b) ( c * 100 + d * 10 + e) =
#  a * c * 1000 +
#  a * d * 100 +
#  a * e * 10 +
#  b * c * 100 +
#  b * d * 10 +
#  b * e
#  => b != e != b * e % 10 ET
#  a != d != (b * e / 10 + b * d + a * e ) % 10
#

sub okdigits{
  my($ok, $n) = @_;
  if ($n eq 0)
  {
      return !(0);
  }
  else
  {
      my $digit = remainder($n, 10);
      if ($ok->[$digit])
      {
          $ok->[$digit] = !(1);
          my $o = okdigits($ok, int($n / 10));
          $ok->[$digit] = !(0);
          return $o;
      }
      else
      {
          return !(1);
      }
  }
}

my $count = 0;
my $allowed = [];
foreach my $i (0 .. 9)
{
    $allowed->[$i] = $i ne 0;
}
my $counted = [];
foreach my $j (0 .. 99999)
{
    $counted->[$j] = !(1);
}
foreach my $e (1 .. 9)
{
    $allowed->[$e] = !(1);
    foreach my $b (1 .. 9)
    {
        if ($allowed->[$b])
        {
            $allowed->[$b] = !(1);
            my $be = remainder($b * $e, 10);
            if ($allowed->[$be])
            {
                $allowed->[$be] = !(1);
                foreach my $a (1 .. 9)
                {
                    if ($allowed->[$a])
                    {
                        $allowed->[$a] = !(1);
                        foreach my $c (1 .. 9)
                        {
                            if ($allowed->[$c])
                            {
                                $allowed->[$c] = !(1);
                                foreach my $d (1 .. 9)
                                {
                                    if ($allowed->[$d])
                                    {
                                        $allowed->[$d] = !(1);
                                        # 2 * 3 digits 
                                        
                                        my $product = ($a * 10 + $b) * ($c * 100 + $d * 10 + $e);
                                        if (!$counted->[$product] && okdigits($allowed, int($product / 10)))
                                        {
                                            $counted->[$product] = !(0);
                                            $count = $count + $product;
                                            print($product, " ");
                                        }
                                        # 1  * 4 digits 
                                        
                                        my $product2 = $b * ($a * 1000 + $c * 100 + $d * 10 + $e);
                                        if (!$counted->[$product2] && okdigits($allowed, int($product2 / 10)))
                                        {
                                            $counted->[$product2] = !(0);
                                            $count = $count + $product2;
                                            print($product2, " ");
                                        }
                                        $allowed->[$d] = !(0);
                                    }
                                }
                                $allowed->[$c] = !(0);
                            }
                        }
                        $allowed->[$a] = !(0);
                    }
                }
                $allowed->[$be] = !(0);
            }
            $allowed->[$b] = !(0);
        }
    }
    $allowed->[$e] = !(0);
}
print($count, "\n");



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
  if ($n eq 0) {
    return 1;
  }else{
    my $digit = remainder($n, 10);
    if ($ok->[$digit]) {
      $ok->[$digit] = ();
      my $o = okdigits($ok, int($n / 10));
      $ok->[$digit] = 1;
      return $o;
    }else{
      return ();
    }
  }
}

my $count = 0;
my $allowed = [];
foreach my $i (0 .. 10 - 1) {
  $allowed->[$i] = $i ne 0;
}
my $counted = [];
foreach my $j (0 .. 100000 - 1) {
  $counted->[$j] = ();
}
foreach my $e (1 .. 9) {
  $allowed->[$e] = ();
  foreach my $b (1 .. 9) {
    if ($allowed->[$b]) {
      $allowed->[$b] = ();
      my $be = remainder($b * $e, 10);
      if ($allowed->[$be]) {
        $allowed->[$be] = ();
        foreach my $a (1 .. 9) {
          if ($allowed->[$a]) {
            $allowed->[$a] = ();
            foreach my $c (1 .. 9) {
              if ($allowed->[$c]) {
                $allowed->[$c] = ();
                foreach my $d (1 .. 9) {
                  if ($allowed->[$d]) {
                    $allowed->[$d] = ();
                    # 2 * 3 digits 
                    
                    my $product = ($a * 10 + $b) * ($c * 100 + $d * 10 + $e);
                    if (!$counted->[$product] && okdigits($allowed, int($product / 10))) {
                      $counted->[$product] = 1;
                      $count = $count + $product;
                      print($product, " ");
                    }
                    # 1  * 4 digits 
                    
                    my $product2 = $b * ($a * 1000 + $c * 100 + $d * 10 + $e);
                    if (!$counted->[$product2] && okdigits($allowed, int($product2 / 10))) {
                      $counted->[$product2] = 1;
                      $count = $count + $product2;
                      print($product2, " ");
                    }
                    $allowed->[$d] = 1;
                  }
                }
                $allowed->[$c] = 1;
              }
            }
            $allowed->[$a] = 1;
          }
        }
        $allowed->[$be] = 1;
      }
      $allowed->[$b] = 1;
    }
  }
  $allowed->[$e] = 1;
}
print($count, "\n");



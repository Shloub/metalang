#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub palindrome2{
  my($pow2, $n) = @_;
  my $t = [];
  foreach my $i (0 .. 20 - 1)
  {
      $t->[$i] = remainder(int($n / $pow2->[$i]), 2) eq 1;
  }
  my $nnum = 0;
  foreach my $j (1 .. 19)
  {
      if ($t->[$j])
      {
          $nnum = $j;
      }
  }
  foreach my $k (0 .. int($nnum / 2))
  {
      if ($t->[$k] ne $t->[$nnum - $k])
      {
          return ();
      }
  }
  return 1;
}

my $p = 1;
my $pow2 = [];
foreach my $i (0 .. 20 - 1)
{
    $p = $p * 2;
    $pow2->[$i] = int($p / 2);
}
my $sum = 0;
foreach my $d (1 .. 9)
{
    if (palindrome2($pow2, $d))
    {
        print($d, "\n");
        $sum = $sum + $d;
    }
    if (palindrome2($pow2, $d * 10 + $d))
    {
        print($d * 10 + $d, "\n");
        $sum = $sum + $d * 10 + $d;
    }
}
foreach my $a0 (0 .. 4)
{
    my $a = $a0 * 2 + 1;
    foreach my $b (0 .. 9)
    {
        foreach my $c (0 .. 9)
        {
            my $num0 = $a * 100000 + $b * 10000 + $c * 1000 + $c * 100 + $b * 10 + $a;
            if (palindrome2($pow2, $num0))
            {
                print($num0, "\n");
                $sum = $sum + $num0;
            }
            my $num1 = $a * 10000 + $b * 1000 + $c * 100 + $b * 10 + $a;
            if (palindrome2($pow2, $num1))
            {
                print($num1, "\n");
                $sum = $sum + $num1;
            }
        }
        my $num2 = $a * 100 + $b * 10 + $a;
        if (palindrome2($pow2, $num2))
        {
            print($num2, "\n");
            $sum = $sum + $num2;
        }
        my $num3 = $a * 1000 + $b * 100 + $b * 10 + $a;
        if (palindrome2($pow2, $num3))
        {
            print($num3, "\n");
            $sum = $sum + $num3;
        }
    }
}
print("sum=", $sum, "\n");



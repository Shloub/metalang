#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub chiffre_sort{
  my($a) = @_;
  if ($a < 10)
  {
      return $a;
  }
  else
  {
      my $b = chiffre_sort(int($a / 10));
      my $c = remainder($a, 10);
      my $d = remainder($b, 10);
      my $e = int($b / 10);
      if ($c < $d)
      {
          return $c + $b * 10;
      }
      else
      {
          return $d + chiffre_sort($c + $e * 10) * 10;
      }
  }
}
sub same_numbers{
  my($a, $b, $c, $d, $e, $f) = @_;
  my $ca = chiffre_sort($a);
  return $ca eq chiffre_sort($b) && $ca eq chiffre_sort($c) && $ca eq chiffre_sort($d) && $ca eq chiffre_sort($e) && $ca eq chiffre_sort($f);
}
my $num = 142857;
if (same_numbers($num, $num * 2, $num * 3, $num * 4, $num * 6, $num * 5))
{
    print($num, " ", $num * 2, " ", $num * 3, " ", $num * 4, " ", $num * 5, " ", $num * 6, "\n");
}



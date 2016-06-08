#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub triangle{
  my($n) = @_;
  if (remainder($n, 2) eq 0)
  {
      return int($n / 2) * ($n + 1);
  }
  else
  {
      return $n * int(($n + 1) / 2);
  }
}

sub penta{
  my($n) = @_;
  if (remainder($n, 2) eq 0)
  {
      return int($n / 2) * (3 * $n - 1);
  }
  else
  {
      return int((3 * $n - 1) / 2) * $n;
  }
}

sub hexa{
  my($n) = @_;
  return $n * (2 * $n - 1);
}

sub findPenta2{
  my($n, $a, $b) = @_;
  if ($b eq $a + 1)
  {
      return penta($a) eq $n || penta($b) eq $n;
  }
  my $c = int(($a + $b) / 2);
  my $p = penta($c);
  if ($p eq $n)
  {
      return 1;
  }
  elsif ($p < $n)
      {
          return findPenta2($n, $c, $b);
      }
      else
      {
          return findPenta2($n, $a, $c);
      }
}

sub findHexa2{
  my($n, $a, $b) = @_;
  if ($b eq $a + 1)
  {
      return hexa($a) eq $n || hexa($b) eq $n;
  }
  my $c = int(($a + $b) / 2);
  my $p = hexa($c);
  if ($p eq $n)
  {
      return 1;
  }
  elsif ($p < $n)
      {
          return findHexa2($n, $c, $b);
      }
      else
      {
          return findHexa2($n, $a, $c);
      }
}

foreach my $n (285 .. 55385)
{
    my $t = triangle($n);
    if (findPenta2($t, int($n / 5), $n) && findHexa2($t, int($n / 5), int($n / 2) + 10))
    {
        print($n, "\n", $t, "\n");
    }
}



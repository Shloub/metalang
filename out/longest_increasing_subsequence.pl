#!/usr/bin/perl

sub dichofind{
  my($len, $tab, $tofind, $a, $b) = @_;
  if ($a >= $b - 1)
  {
      return $a;
  }
  else
  {
      my $c = int(($a + $b) / 2);
      if ($tab->[$c] < $tofind)
      {
          return dichofind($len, $tab, $tofind, $c, $b);
      }
      else
      {
          return dichofind($len, $tab, $tofind, $a, $c);
      }
  }
}

sub process{
  my($len, $tab) = @_;
  my $size = [];
  foreach my $j (0 .. $len - 1)
  {
      if ($j eq 0)
      {
          $size->[$j] = 0;
      }
      else
      {
          $size->[$j] = $len * 2;
      }
  }
  foreach my $i (0 .. $len - 1)
  {
      my $k = dichofind($len, $size, $tab->[$i], 0, $len - 1);
      if ($size->[$k + 1] > $tab->[$i])
      {
          $size->[$k + 1] = $tab->[$i];
      }
  }
  foreach my $l (0 .. $len - 1)
  {
      print($size->[$l], " ");
  }
  foreach my $m (0 .. $len - 1)
  {
      my $k = $len - 1 - $m;
      if ($size->[$k] ne $len * 2)
      {
          return $k;
      }
  }
  return 0;
}
my $n = int( <STDIN> );
foreach my $i (1 .. $n)
{
    my $len = int( <STDIN> );
    print(process($len, [ map { int($_) } split(/\s+/, <STDIN>) ]), "\n");
}



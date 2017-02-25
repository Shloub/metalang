#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub periode{
  my($restes, $len, $a, $b) = @_;
  while ($a ne 0)
  {
      my $chiffre = int($a / $b);
      my $reste = remainder($a, $b);
      foreach my $i (0 .. $len - 1)
      {
          if ($restes->[$i] eq $reste)
          {
              return $len - $i;
          }
      }
      $restes->[$len] = $reste;
      $len = $len + 1;
      $a = $reste * 10;
  }
  return 0;
}
my $t = [];
foreach my $j (0 .. 999)
{
    $t->[$j] = 0;
}
my $m = 0;
my $mi = 0;
foreach my $i (1 .. 1000)
{
    my $p = periode($t, 0, 1, $i);
    if ($p > $m)
    {
        $mi = $i;
        $m = $p;
    }
}
print($mi, "\n", $m, "\n");



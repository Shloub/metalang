#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub exp0{
  my($a, $e) = @_;
  my $o = 1;
  foreach my $i (1 .. $e)
  {
      $o = $o * $a;
  }
  return $o;
}
sub e{
  my($t, $n) = @_;
  foreach my $i (1 .. 8)
  {
      if ($n >= $t->[$i] * $i)
      {
          $n = $n - $t->[$i] * $i;
      }
      else
      {
          my $nombre = exp0(10, $i - 1) + int($n / $i);
          my $chiffre = $i - 1 - remainder($n, $i);
          return remainder(int($nombre / exp0(10, $chiffre)), 10);
      }
  }
  return -1;
}
my $t = [];
foreach my $i (0 .. 8)
{
    $t->[$i] = exp0(10, $i) - exp0(10, $i - 1);
}
foreach my $i2 (1 .. 8)
{
    print($i2, " => ", $t->[$i2], "\n");
}
foreach my $j (0 .. 80)
{
    print e($t, $j);
}
print "\n";
foreach my $k (1 .. 50)
{
    print $k;
}
print "\n";
foreach my $j2 (169 .. 220)
{
    print e($t, $j2);
}
print "\n";
foreach my $k2 (90 .. 110)
{
    print $k2;
}
print "\n";
my $out0 = 1;
foreach my $l (0 .. 6)
{
    my $puiss = exp0(10, $l);
    my $v = e($t, $puiss - 1);
    $out0 = $out0 * $v;
    print("10^", $l, "=", $puiss, " v=", $v, "\n");
}
print($out0, "\n");



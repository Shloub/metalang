#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub h{
  my($i) = @_;
  #  for j = i - 2 to i + 2 do
  #    if i % j == 5 then return true end
  #  end 
  
  my $j = $i - 2;
  while ($j <= $i + 2)
  {
    if ((remainder($i, $j)) eq 5) {
      return 1;
    }
    $j = $j + 1;
  }
  return ();
}

my $j = 0;
foreach my $k (0 .. 10) {
  $j = $j + $k;
  print($j, "\n");
}
my $i = 4;
while ($i < 10)
{
  print $i;
  $i = $i + 1;
  $j = $j + $i;
}
print($j, $i, "FIN TEST\n");



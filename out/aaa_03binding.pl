#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub g{
  my($i) = @_;
  my $j = $i * 4;
  if (remainder($j, 2) eq 1)
  {
      return 0;
  }
  return $j;
}

sub h{
  my($i) = @_;
  print($i, "\n");
}

h(14);
my $a = 4;
my $b = 5;
print $a + $b;
# main 

h(15);
$a = 2;
$b = 1;
print $a + $b;



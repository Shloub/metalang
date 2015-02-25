#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub divisible{
  my($n, $t, $size) = @_;
  foreach my $i (0 .. $size - 1) {
    if ((remainder($n, $t->[$i])) eq 0) {
      return 1;
    }
  }
  return ();
}

sub find{
  my($n, $t, $used, $nth) = @_;
  while ($used ne $nth)
  {
    if (divisible($n, $t, $used)) {
      $n = $n + 1;
    }else{
      $t->[$used] = $n;
      $n = $n + 1;
      $used = $used + 1;
    }
  }
  return $t->[$used - 1];
}

my $n = 10001;
my $t = [];
foreach my $i (0 .. $n - 1) {
  $t->[$i] = 2;
}
print(find(3, $t, 1, $n), "\n");



#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub id{
  my($b) = @_;
  return $b;
}

sub g{
  my($t,
  $index) = @_;
  $t->[$index] = 0;
}

my $c = 5;
my $a = [];
foreach my $i (0 .. $c - 1) {
  print($i);
  $a->[$i] = (remainder($i, 2)) eq 0;
  }
my $d = $a->[0];
if ($d) {
print("True");
}else{
print("False");
}
print("\n");
g(id($a), 0);
my $e = $a->[0];
if ($e) {
print("True");
}else{
print("False");
}
print("\n");


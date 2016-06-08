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
  my($t, $index) = @_;
  $t->[$index] = ();
}

my $j = 0;
my $a = [];
foreach my $i (0 .. 5 - 1)
{
    print $i;
    $j = $j + $i;
    $a->[$i] = remainder($i, 2) eq 0;
}
print($j, " ");
if ($a->[0])
{
    print "True";
}
else
{
    print "False";
}
print "\n";
g(id($a), 0);
if ($a->[0])
{
    print "True";
}
else
{
    print "False";
}
print "\n";



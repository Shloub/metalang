#!/usr/bin/perl
use List::Util qw(min max);
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar();
  return $o;
}
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

my $i = 1;
my $last = [];
foreach my $j (0 .. 5 - 1) {
  my $c = readchar();
  my $d = ord($c) - ord('0');
  $i = $i * $d;
  $last->[$j] = $d;
  }
my $max_ = $i;
my $index = 0;
my $nskipdiv = 0;
foreach my $k (1 .. 995) {
  my $e = readchar();
  my $f = ord($e) - ord('0');
  if ($f eq 0) {
    $i = 1;
    $nskipdiv = 4;
  }else{
    $i = $i * $f;
    if ($nskipdiv < 0) {
      $i = int(($i) / ($last->[$index]));
    }
    $nskipdiv = $nskipdiv - 1;
  }
  $last->[$index] = $f;
  $index = remainder($index + 1, 5);
  $max_ = max($max_, $i);
  }
print($max_, "\n");



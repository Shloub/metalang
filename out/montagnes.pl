#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readint {
  nextchar() if (!defined $currentchar);
  my $o = 0, $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar;
  }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar;
  }
  return $o * $sign;
}
sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub montagnes0{
  my($tab, $len) = @_;
  my $max0 = 1;
  my $j = 1;
  my $i = $len - 2;
  while ($i >= 0)
  {
    my $x = $tab->[$i];
    while ($j >= 0 && $x > $tab->[$len - $j])
    {
      $j = $j - 1;
    }
    $j = $j + 1;
    $tab->[$len - $j] = $x;
    if ($j > $max0) {
      $max0 = $j;
    }
    $i = $i - 1;
  }
  return $max0;
}

my $len = 0;
$len = readint();
readspaces();
my $tab = [];
foreach my $i (0 .. $len - 1) {
  my $x = 0;
  $x = readint();
  readspaces();
  $tab->[$i] = $x;
}
print montagnes0($tab, $len);



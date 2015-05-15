#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub is_leap{
  my($year) = @_;
  return remainder($year, 400) eq 0 || remainder($year, 100) ne 0 && remainder($year, 4) eq 0;
}

sub ndayinmonth{
  my($month, $year) = @_;
  if ($month eq 0) {
    return 31;
  }elsif ($month eq 1) {
    if (is_leap($year)) {
      return 29;
    }else{
      return 28;
    }
  }elsif ($month eq 2) {
    return 31;
  }elsif ($month eq 3) {
    return 30;
  }elsif ($month eq 4) {
    return 31;
  }elsif ($month eq 5) {
    return 30;
  }elsif ($month eq 6) {
    return 31;
  }elsif ($month eq 7) {
    return 31;
  }elsif ($month eq 8) {
    return 30;
  }elsif ($month eq 9) {
    return 31;
  }elsif ($month eq 10) {
    return 30;
  }elsif ($month eq 11) {
    return 31;
  }
  return 0;
}

my $month = 0;
my $year = 1901;
my $dayofweek = 1;
# 01-01-1901 : mardi 

my $count = 0;
while ($year ne 2001)
{
  my $ndays = ndayinmonth($month, $year);
  $dayofweek = remainder($dayofweek + $ndays, 7);
  $month = $month + 1;
  if ($month eq 12) {
    $month = 0;
    $year = $year + 1;
  }
  if (remainder($dayofweek, 7) eq 6) {
    $count = $count + 1;
  }
}
print($count, "\n");



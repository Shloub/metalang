#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readint {
  nextchar() if (!defined $currentchar);
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar();
  }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub exp0{
  my($a,
  $b) = @_;
  if ($b eq 0) {
    return 1;
  }
  if ((remainder($b, 2)) eq 0) {
    my $o = exp0($a, int(($b) / (2)));
    return $o * $o;
  }else{
    return $a * exp0($a, $b - 1);
  }
}

my $a = 0;
my $b = 0;
$a = readint();
readspaces();
$b = readint();
print(exp0($a, $b));



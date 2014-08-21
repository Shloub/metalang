#!/usr/bin/perl

sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
    if (!defined $currentchar){ nextchar() ; }
    my $o = $currentchar; nextchar(); return $o; }
sub readint {
    if (!defined $currentchar){ nextchar(); }
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') { $sign = -1; nextchar(); }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}

sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub g{
  my($i) = @_;
  my $j = $i * 4;
  if ((remainder($j, 2)) eq 1) {
  return 0;
  }else{
  
  }
  return $j;
}

sub h{
  my($i) = @_;
  print($i);
  print("\n");
}

h(14);
my $a = 4;
my $b = 5;
print($a + $b);
# main 

h(15);
$a = 2;
$b = 1;
print($a + $b);



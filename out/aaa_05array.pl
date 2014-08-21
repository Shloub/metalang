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
foreach $i (0 .. $c - 1) {
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



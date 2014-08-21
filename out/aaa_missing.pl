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

sub read_int{
  my $out_ = 0;
  $out_ = readint();
  readspaces();
  return $out_;
}

sub read_int_line{
  my($n) = @_;
  my $tab = [];
  foreach $i (0 .. $n - 1) {
    my $t = 0;
    $t = readint();
    readspaces();
    $tab->[$i] = $t;
    }
  return $tab;
}

#
#  Ce test a été généré par Metalang.
#

sub result{
  my($len,
  $tab) = @_;
  my $tab2 = [];
  foreach $i (0 .. $len - 1) {
    $tab2->[$i] = 0;
    }
  foreach $i1 (0 .. $len - 1) {
    $tab2->[$tab->[$i1]] = 1;
    }
  foreach $i2 (0 .. $len - 1) {
    if (!$tab2->[$i2]) {
    return $i2;
    }else{
    
    }
    }
  return -1;
}

my $len = read_int();
print($len);
print("\n");
my $tab = read_int_line($len);
print(result($len, $tab));



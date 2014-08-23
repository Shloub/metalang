#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readint {
  if (!defined $currentchar){
     nextchar();
  }
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

#
#  Ce test a été généré par Metalang.
#

sub result{
  my($len,
  $tab) = @_;
  my $tab2 = [];
  foreach my $i (0 .. $len - 1) {
    $tab2->[$i] = 0;
    }
  foreach my $i1 (0 .. $len - 1) {
    $tab2->[$tab->[$i1]] = 1;
    }
  foreach my $i2 (0 .. $len - 1) {
    if (!$tab2->[$i2]) {
    return $i2;
    }else{
    
    }
    }
  return -1;
}

my $b = 0;
$b = readint();
readspaces();
my $len = $b;
print($len, "\n");
my $d = [];
foreach my $e (0 .. $len - 1) {
  my $f = 0;
  $f = readint();
  readspaces();
  $d->[$e] = $f;
  }
my $tab = $d;
print(result($len, $tab));



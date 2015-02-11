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

#
#Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
#


sub mktoto{
  my($v1) = @_;
  my $t = {"foo" => $v1,
           "bar" => $v1,
           "blah" => $v1};
  return $t;
}

sub mktoto2{
  my($v1) = @_;
  my $t = {"foo" => $v1 + 3,
           "bar" => $v1 + 2,
           "blah" => $v1 + 1};
  return $t;
}

sub result{
  my($t_, $t2_) = @_;
  my $t = $t_;
  my $t2 = $t2_;
  my $t3 = {"foo" => 0,
            "bar" => 0,
            "blah" => 0};
  $t3 = $t2;
  $t = $t2;
  $t2 = $t3;
  $t->{"blah"} = $t->{"blah"} + 1;
  my $len = 1;
  my $cache0 = [];
  foreach my $i (0 .. $len - 1) {
    $cache0->[$i] = -$i;
  }
  my $cache1 = [];
  foreach my $j (0 .. $len - 1) {
    $cache1->[$j] = $j;
  }
  my $cache2 = $cache0;
  $cache0 = $cache1;
  $cache2 = $cache0;
  return $t->{"foo"} + $t->{"blah"} * $t->{"bar"} + $t->{"bar"} * $t->{"foo"};
}

my $t = mktoto(4);
my $t2 = mktoto(5);
$t->{"bar"} = readint();
readspaces();
$t->{"blah"} = readint();
readspaces();
$t2->{"bar"} = readint();
readspaces();
$t2->{"blah"} = readint();
print(result($t, $t2), $t->{"blah"});



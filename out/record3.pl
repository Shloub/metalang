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


sub mktoto{
  my($v1) = @_;
  my $t = {"foo" => $v1,
           "bar" => 0,
           "blah" => 0};
  return $t;
}

sub result{
  my($t, $len) = @_;
  my $out0 = 0;
  foreach my $j (0 .. $len - 1) {
    $t->[$j]->{"blah"} = $t->[$j]->{"blah"} + 1;
    $out0 = $out0 + $t->[$j]->{"foo"} + $t->[$j]->{"blah"} * $t->[$j]->{"bar"} +
    $t->[$j]->{"bar"} * $t->[$j]->{"foo"};
  }
  return $out0;
}

my $t = [];
foreach my $i (0 .. 4 - 1) {
  $t->[$i] = mktoto($i);
}
$t->[0]->{"bar"} = readint();
readspaces();
$t->[1]->{"blah"} = readint();
my $titi = result($t, 4);
print($titi, $t->[2]->{"blah"});



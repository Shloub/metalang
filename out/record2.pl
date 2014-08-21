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


sub mktoto{
  my($v1) = @_;
  my $t = {"foo"=>$v1,
           "bar"=>0,
           "blah"=>0};
  return $t;
}

sub result{
  my($t) = @_;
  $t->{"blah"} = $t->{"blah"} + 1;
  return $t->{"foo"} + $t->{"blah"} * $t->{"bar"} + $t->{"bar"} * $t->{"foo"};
}

my $t = mktoto(4);
$t->{"bar"} = readint();
readspaces();
$t->{"blah"} = readint();
print(result($t));



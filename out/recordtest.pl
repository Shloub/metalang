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


my $param = {"foo" => 0,
             "bar" => 0};
$param->{"bar"} = readint();
readspaces();
$param->{"foo"} = readint();
print($param->{"bar"} + $param->{"foo"} * $param->{"bar"});



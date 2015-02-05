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
}

sub cons{
  my($list, $i) = @_;
  my $out0 = {"head" => $i,
              "tail" => $list};
  return $out0;
}

sub rev2{
  my($empty, $acc, $torev) = @_;
  if ($torev eq $empty) {
    return $acc;
  }else{
    my $acc2 = {"head" => $torev->{"head"},
                "tail" => $acc};
    return rev2($empty, $acc, $torev->{"tail"});
  }
}

sub rev{
  my($empty, $torev) = @_;
  return rev2($empty, $empty, $torev);
}

sub test{
  my($empty) = @_;
  my $list = $empty;
  my $i = -1;
  while ($i ne 0)
  {
    $i = readint();
    if ($i ne 0) {
      $list = cons($list, $i);
    }
  }
}





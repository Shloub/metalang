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
}

sub cons{
  my($list,
  $i) = @_;
  my $out_ = {"head" => $i,
              "tail" => $list};
  return $out_;
}

sub rev2{
  my($empty,
  $acc,
  $torev) = @_;
  if ($torev eq $empty) {
  return $acc;
  }else{
  my $acc2 = {"head" => $torev->{"head"},
              "tail" => $acc};
  return rev2($empty, $acc, $torev->{"tail"});
  }
}

sub rev{
  my($empty,
  $torev) = @_;
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
    }else{
    
    }
  }
}





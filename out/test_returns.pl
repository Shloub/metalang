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

sub is_pair{
  my($i) = @_;
  my $j = 1;
  if ($i < 10) {
  $j = 2;
  if ($i eq 0) {
  $j = 4;
  return 1;
  }else{
  
  }
  $j = 3;
  if ($i eq 2) {
  $j = 4;
  return 1;
  }else{
  
  }
  $j = 5;
  }else{
  
  }
  $j = 6;
  if ($i < 20) {
  if ($i eq 22) {
  $j = 0;
  }else{
  
  }
  $j = 8;
  }else{
  
  }
  return (remainder($i, 2)) eq 0;
}





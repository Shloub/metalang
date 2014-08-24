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

sub max2{
  my($a,
  $b) = @_;
  if ($a > $b) {
  return $a;
  }else{
  return $b;
  }
}

sub nbPassePartout{
  my($n,
  $passepartout,
  $m,
  $serrures) = @_;
  my $max_ancient = 0;
  my $max_recent = 0;
  foreach my $i (0 .. $m - 1) {
    if ($serrures->[$i]->[0] eq -1 && $serrures->[$i]->[1] > $max_ancient) {
    $max_ancient = $serrures->[$i]->[1];
    }else{
    
    }
    if ($serrures->[$i]->[0] eq 1 && $serrures->[$i]->[1] > $max_recent) {
    $max_recent = $serrures->[$i]->[1];
    }else{
    
    }
    }
  my $max_ancient_pp = 0;
  my $max_recent_pp = 0;
  foreach my $i (0 .. $n - 1) {
    my $pp = $passepartout->[$i];
    if ($pp->[0] >= $max_ancient && $pp->[1] >= $max_recent) {
    return 1;
    }else{
    
    }
    $max_ancient_pp = max2($max_ancient_pp, $pp->[0]);
    $max_recent_pp = max2($max_recent_pp, $pp->[1]);
    }
  if ($max_ancient_pp >= $max_ancient && $max_recent_pp >= $max_recent) {
  return 2;
  }else{
  return 0;
  }
}

my $n = readint();
readspaces();
my $passepartout = [];
foreach my $i (0 .. $n - 1) {
  my $out0 = [];
  foreach my $j (0 .. 2 - 1) {
    my $out__ = readint();
    readspaces();
    $out0->[$j] = $out__;
    }
  $passepartout->[$i] = $out0;
  }
my $m = readint();
readspaces();
my $serrures = [];
foreach my $k (0 .. $m - 1) {
  my $out1 = [];
  foreach my $l (0 .. 2 - 1) {
    my $out_ = readint();
    readspaces();
    $out1->[$l] = $out_;
    }
  $serrures->[$k] = $out1;
  }
print(nbPassePartout($n, $passepartout, $m, $serrures));



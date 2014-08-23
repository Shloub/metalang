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

sub read_int_matrix{
  my($x,
  $y) = @_;
  my $tab = [];
  foreach my $z (0 .. $y - 1) {
    my $d = [];
    foreach my $e (0 .. $x - 1) {
      my $f = 0;
      $f = readint();
      readspaces();
      $d->[$e] = $f;
      }
    my $c = $d;
    $tab->[$z] = $c;
    }
  return $tab;
}

sub find{
  my($n,
  $m,
  $x,
  $y,
  $dx,
  $dy) = @_;
  if ($x < 0 || $x eq 20 || $y < 0 || $y eq 20) {
  return -1;
  }else{
  if ($n eq 0) {
  return 1;
  }else{
  return $m->[$y]->[$x] * find($n - 1, $m, $x + $dx, $y + $dy, $dx, $dy);
  }
  }
}


my $directions = [];
foreach my $i (0 .. 8 - 1) {
  if ($i eq 0) {
  my $s = {"tuple_int_int_field_0"=>0,
           "tuple_int_int_field_1"=>1};
  $directions->[$i] = $s;
  }else{
  if ($i eq 1) {
  my $r = {"tuple_int_int_field_0"=>1,
           "tuple_int_int_field_1"=>0};
  $directions->[$i] = $r;
  }else{
  if ($i eq 2) {
  my $q = {"tuple_int_int_field_0"=>0,
           "tuple_int_int_field_1"=>-1};
  $directions->[$i] = $q;
  }else{
  if ($i eq 3) {
  my $p = {"tuple_int_int_field_0"=>-1,
           "tuple_int_int_field_1"=>0};
  $directions->[$i] = $p;
  }else{
  if ($i eq 4) {
  my $o = {"tuple_int_int_field_0"=>1,
           "tuple_int_int_field_1"=>1};
  $directions->[$i] = $o;
  }else{
  if ($i eq 5) {
  my $l = {"tuple_int_int_field_0"=>1,
           "tuple_int_int_field_1"=>-1};
  $directions->[$i] = $l;
  }else{
  if ($i eq 6) {
  my $k = {"tuple_int_int_field_0"=>-1,
           "tuple_int_int_field_1"=>1};
  $directions->[$i] = $k;
  }else{
  my $h = {"tuple_int_int_field_0"=>-1,
           "tuple_int_int_field_1"=>-1};
  $directions->[$i] = $h;
  }
  }
  }
  }
  }
  }
  }
  }
my $max_ = 0;
my $m = read_int_matrix(20, 20);
foreach my $j (0 .. 7) {
  my $g = $directions->[$j];
  my $dx = $g->{"tuple_int_int_field_0"};
  my $dy = $g->{"tuple_int_int_field_1"};
  foreach my $x (0 .. 19) {
    foreach my $y (0 .. 19) {
      $max_ = max2($max_, find(4, $m, $x, $y, $dx, $dy));
      }
    }
  }
print($max_, "\n");



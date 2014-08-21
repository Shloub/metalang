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

sub max2{
  my($a,
  $b) = @_;
  if ($a > $b) {
  return $a;
  }else{
  return $b;
  }
}

sub read_int_line{
  my($n) = @_;
  my $tab = [];
  foreach $i (0 .. $n - 1) {
    my $t = 0;
    $t = readint();
    readspaces();
    $tab->[$i] = $t;
    }
  return $tab;
}

sub read_int_matrix{
  my($x,
  $y) = @_;
  my $tab = [];
  foreach $z (0 .. $y - 1) {
    $tab->[$z] = read_int_line($x);
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


my $c = 8;
my $directions = [];
foreach $i (0 .. $c - 1) {
  if ($i eq 0) {
  my $p = {"tuple_int_int_field_0"=>0,
           "tuple_int_int_field_1"=>1};
  $directions->[$i] = $p;
  }else{
  if ($i eq 1) {
  my $o = {"tuple_int_int_field_0"=>1,
           "tuple_int_int_field_1"=>0};
  $directions->[$i] = $o;
  }else{
  if ($i eq 2) {
  my $l = {"tuple_int_int_field_0"=>0,
           "tuple_int_int_field_1"=>-1};
  $directions->[$i] = $l;
  }else{
  if ($i eq 3) {
  my $k = {"tuple_int_int_field_0"=>-1,
           "tuple_int_int_field_1"=>0};
  $directions->[$i] = $k;
  }else{
  if ($i eq 4) {
  my $h = {"tuple_int_int_field_0"=>1,
           "tuple_int_int_field_1"=>1};
  $directions->[$i] = $h;
  }else{
  if ($i eq 5) {
  my $g = {"tuple_int_int_field_0"=>1,
           "tuple_int_int_field_1"=>-1};
  $directions->[$i] = $g;
  }else{
  if ($i eq 6) {
  my $f = {"tuple_int_int_field_0"=>-1,
           "tuple_int_int_field_1"=>1};
  $directions->[$i] = $f;
  }else{
  my $e = {"tuple_int_int_field_0"=>-1,
           "tuple_int_int_field_1"=>-1};
  $directions->[$i] = $e;
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
foreach $j (0 .. 7) {
  my $d = $directions->[$j];
  my $dx = $d->{"tuple_int_int_field_0"};
  my $dy = $d->{"tuple_int_int_field_1"};
  foreach $x (0 .. 19) {
    foreach $y (0 .. 19) {
      $max_ = max2($max_, find(4, $m, $x, $y, $dx, $dy));
      }
    }
  }
print($max_);
print("\n");



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

sub read_int{
  my $out_ = 0;
  $out_ = readint();
  readspaces();
  return $out_;
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

my $len = read_int();
print($len);
print("=len\n");
my $tab1 = read_int_line($len);
foreach $i (0 .. $len - 1) {
  print($i);
  print("=>");
  print($tab1->[$i]);
  print("\n");
  }
$len = read_int();
my $tab2 = read_int_matrix($len, $len - 1);
foreach $i (0 .. $len - 2) {
  foreach $j (0 .. $len - 1) {
    print($tab2->[$i]->[$j]);
    print(" ");
    }
  print("\n");
  }



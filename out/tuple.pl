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


sub f{
  my($tuple_) = @_;
  my $c = $tuple_;
  my $a = $c->{"tuple_int_int_field_0"};
  my $b = $c->{"tuple_int_int_field_1"};
  my $e = {"tuple_int_int_field_0"=>$a + 1,
           "tuple_int_int_field_1"=>$b + 1};
  return $e;
}

my $g = {"tuple_int_int_field_0"=>0,
         "tuple_int_int_field_1"=>1};
my $t = f($g);
my $d = $t;
my $a = $d->{"tuple_int_int_field_0"};
my $b = $d->{"tuple_int_int_field_1"};
print($a);
print(" -- ");
print($b);
print("--\n");



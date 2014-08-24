#!/usr/bin/perl


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
print($d->{"tuple_int_int_field_0"}, " -- ", $d->{"tuple_int_int_field_1"}, "--\n");



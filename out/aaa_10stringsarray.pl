#!/usr/bin/perl


sub idstring{
  my($s) = @_;
  return $s;
}

sub printstring{
  my($s) = @_;
  print(idstring($s), "\n");
}

sub print_toto{
  my($t) = @_;
  print($t->{"s"}, " = ", $t->{"v"}, "\n");
}

my $tab = [];
foreach my $i (0 .. 2 - 1)
{
    $tab->[$i] = idstring("chaine de test");
}
foreach my $j (0 .. 1)
{
    printstring(idstring($tab->[$j]));
}
print_toto({"s" => "one", "v" => 1});



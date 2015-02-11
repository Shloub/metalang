#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readint {
  nextchar() if (!defined $currentchar);
  my $o = 0, $sign = 1;
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
sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

# lit un sudoku sur l'entrée standard 

sub read_sudoku{
  my $out0 = [];
  foreach my $i (0 .. 9 * 9 - 1) {
    my $k = readint();
    readspaces();
    $out0->[$i] = $k;
  }
  return $out0;
}

# affiche un sudoku 

sub print_sudoku{
  my($sudoku0) = @_;
  foreach my $y (0 .. 8) {
    foreach my $x (0 .. 8) {
      print($sudoku0->[$x + $y * 9], " ");
      if ((remainder($x, 3)) eq 2) {
        print(" ");
      }
    }
    print("\n");
    if ((remainder($y, 3)) eq 2) {
      print("\n");
    }
  }
  print("\n");
}

# dit si les variables sont toutes différentes 

# dit si les variables sont toutes différentes 

# dit si le sudoku est terminé de remplir 

sub sudoku_done{
  my($s) = @_;
  foreach my $i (0 .. 80) {
    if ($s->[$i] eq 0) {
      return 0;
    }
  }
  return 1;
}

# dit si il y a une erreur dans le sudoku 

# résout le sudoku

sub solve{
  my($sudoku0) = @_;
  if (0 || ($sudoku0->[0] ne 0 && $sudoku0->[0] eq $sudoku0->[9]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[18]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[18]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[27]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[27]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[27]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[36]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[36]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[36]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[36]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[54]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[54]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[54]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[54]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[54]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[54]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[10]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[28]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[28]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[28]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[37]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[37]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[37]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[37]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[55]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[55]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[55]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[55]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[55]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[55]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[11]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[29]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[29]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[29]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[47] ne
                                                                    0 &&
                                                                    $sudoku0->[47] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[47] ne
                                                                    0 &&
                                                                    $sudoku0->[47] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[47] ne
                                                                    0 &&
                                                                    $sudoku0->[47] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[12]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[30]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[30]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[30]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[57]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[57]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[57]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[57]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[57]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[57]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[13]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[31]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[31]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[31]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[49] ne
                                                                    0 &&
                                                                    $sudoku0->[49] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[49] ne
                                                                    0 &&
                                                                    $sudoku0->[49] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[49] ne
                                                                    0 &&
                                                                    $sudoku0->[49] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[67] ne
                                                                    0 &&
                                                                    $sudoku0->[67] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[23] ne
                                                                    0 &&
                                                                    $sudoku0->[23] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[23] ne
                                                                    0 &&
                                                                    $sudoku0->[23] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[23] ne
                                                                    0 &&
                                                                    $sudoku0->[23] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[23] ne
                                                                    0 &&
                                                                    $sudoku0->[23] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[50] ne
                                                                    0 &&
                                                                    $sudoku0->[50] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[23] ne
                                                                    0 &&
                                                                    $sudoku0->[23] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[50] ne
                                                                    0 &&
                                                                    $sudoku0->[50] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[23] ne
                                                                    0 &&
                                                                    $sudoku0->[23] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[50] ne
                                                                    0 &&
                                                                    $sudoku0->[50] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[68] ne
                                                                    0 &&
                                                                    $sudoku0->[68] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[33]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[33]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[33]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[51] ne
                                                                    0 &&
                                                                    $sudoku0->[51] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[51] ne
                                                                    0 &&
                                                                    $sudoku0->[51] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[51] ne
                                                                    0 &&
                                                                    $sudoku0->[51] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[69] ne
                                                                    0 &&
                                                                    $sudoku0->[69] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[25] ne
                                                                    0 &&
                                                                    $sudoku0->[25] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[25] ne
                                                                    0 &&
                                                                    $sudoku0->[25] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[25] ne
                                                                    0 &&
                                                                    $sudoku0->[25] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[43] ne
                                                                    0 &&
                                                                    $sudoku0->[43] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[25] ne
                                                                    0 &&
                                                                    $sudoku0->[25] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[43] ne
                                                                    0 &&
                                                                    $sudoku0->[43] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[52] ne
                                                                    0 &&
                                                                    $sudoku0->[52] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[25] ne
                                                                    0 &&
                                                                    $sudoku0->[25] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[43] ne
                                                                    0 &&
                                                                    $sudoku0->[43] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[52] ne
                                                                    0 &&
                                                                    $sudoku0->[52] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[25] ne
                                                                    0 &&
                                                                    $sudoku0->[25] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[43] ne
                                                                    0 &&
                                                                    $sudoku0->[43] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[52] ne
                                                                    0 &&
                                                                    $sudoku0->[52] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[70] ne
                                                                    0 &&
                                                                    $sudoku0->[70] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[26] ne
                                                                    0 &&
                                                                    $sudoku0->[26] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[26] ne
                                                                    0 &&
                                                                    $sudoku0->[26] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[26] ne
                                                                    0 &&
                                                                    $sudoku0->[26] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[44] ne
                                                                    0 &&
                                                                    $sudoku0->[44] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[26] ne
                                                                    0 &&
                                                                    $sudoku0->[26] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[44] ne
                                                                    0 &&
                                                                    $sudoku0->[44] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[53] ne
                                                                    0 &&
                                                                    $sudoku0->[53] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[26] ne
                                                                    0 &&
                                                                    $sudoku0->[26] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[44] ne
                                                                    0 &&
                                                                    $sudoku0->[44] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[53] ne
                                                                    0 &&
                                                                    $sudoku0->[53] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[62] ne
                                                                    0 &&
                                                                    $sudoku0->[62] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[26] ne
                                                                    0 &&
                                                                    $sudoku0->[26] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[44] ne
                                                                    0 &&
                                                                    $sudoku0->[44] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[53] ne
                                                                    0 &&
                                                                    $sudoku0->[53] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[62] ne
                                                                    0 &&
                                                                    $sudoku0->[62] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[71] ne
                                                                    0 &&
                                                                    $sudoku0->[71] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[1]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[2]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[2]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[3]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[3]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[3]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[4]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[4]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[4]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[4]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[5]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[5]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[5]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[5]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[5]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[6]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[6]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[6]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[6]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[6]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[6]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[7]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[7]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[7]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[7]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[7]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[7]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[7]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[10]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[11]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[11]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[12]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[12]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[12]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[13]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[13]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[13]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[13]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[23] ne
                                                                    0 &&
                                                                    $sudoku0->[23] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[23] ne
                                                                    0 &&
                                                                    $sudoku0->[23] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[20] ne
                                                                    0 &&
                                                                    $sudoku0->[20] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[23] ne
                                                                    0 &&
                                                                    $sudoku0->[23] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[25] ne
                                                                    0 &&
                                                                    $sudoku0->[25] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[28]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[29]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[29]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[30]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[30]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[30]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[31]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[31]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[31]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[31]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[33]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[33]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[33]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[33]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[33]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[33]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[37]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[43] ne
                                                                    0 &&
                                                                    $sudoku0->[43] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[47] ne
                                                                    0 &&
                                                                    $sudoku0->[47] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[47] ne
                                                                    0 &&
                                                                    $sudoku0->[47] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[47] ne
                                                                    0 &&
                                                                    $sudoku0->[47] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[49] ne
                                                                    0 &&
                                                                    $sudoku0->[49] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[47] ne
                                                                    0 &&
                                                                    $sudoku0->[47] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[49] ne
                                                                    0 &&
                                                                    $sudoku0->[49] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[50] ne
                                                                    0 &&
                                                                    $sudoku0->[50] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[47] ne
                                                                    0 &&
                                                                    $sudoku0->[47] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[49] ne
                                                                    0 &&
                                                                    $sudoku0->[49] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[50] ne
                                                                    0 &&
                                                                    $sudoku0->[50] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[51] ne
                                                                    0 &&
                                                                    $sudoku0->[51] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[47] ne
                                                                    0 &&
                                                                    $sudoku0->[47] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[49] ne
                                                                    0 &&
                                                                    $sudoku0->[49] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[50] ne
                                                                    0 &&
                                                                    $sudoku0->[50] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[51] ne
                                                                    0 &&
                                                                    $sudoku0->[51] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[52] ne
                                                                    0 &&
                                                                    $sudoku0->[52] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[55]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[57]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[57]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[57]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[60]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[67] ne
                                                                    0 &&
                                                                    $sudoku0->[67] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[67] ne
                                                                    0 &&
                                                                    $sudoku0->[67] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[68] ne
                                                                    0 &&
                                                                    $sudoku0->[68] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[67] ne
                                                                    0 &&
                                                                    $sudoku0->[67] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[68] ne
                                                                    0 &&
                                                                    $sudoku0->[68] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[69] ne
                                                                    0 &&
                                                                    $sudoku0->[69] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[67] ne
                                                                    0 &&
                                                                    $sudoku0->[67] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[68] ne
                                                                    0 &&
                                                                    $sudoku0->[68] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[69] ne
                                                                    0 &&
                                                                    $sudoku0->[69] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[70] ne
                                                                    0 &&
                                                                    $sudoku0->[70] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[73] ne
                                                                    0 &&
                                                                    $sudoku0->[73] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[73] ne
                                                                    0 &&
                                                                    $sudoku0->[73] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[74] ne
                                                                    0 &&
                                                                    $sudoku0->[74] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[73] ne
                                                                    0 &&
                                                                    $sudoku0->[73] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[74] ne
                                                                    0 &&
                                                                    $sudoku0->[74] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[75] ne
                                                                    0 &&
                                                                    $sudoku0->[75] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[73] ne
                                                                    0 &&
                                                                    $sudoku0->[73] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[74] ne
                                                                    0 &&
                                                                    $sudoku0->[74] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[75] ne
                                                                    0 &&
                                                                    $sudoku0->[75] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[76] ne
                                                                    0 &&
                                                                    $sudoku0->[76] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[73] ne
                                                                    0 &&
                                                                    $sudoku0->[73] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[74] ne
                                                                    0 &&
                                                                    $sudoku0->[74] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[75] ne
                                                                    0 &&
                                                                    $sudoku0->[75] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[76] ne
                                                                    0 &&
                                                                    $sudoku0->[76] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[77] ne
                                                                    0 &&
                                                                    $sudoku0->[77] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[73] ne
                                                                    0 &&
                                                                    $sudoku0->[73] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[74] ne
                                                                    0 &&
                                                                    $sudoku0->[74] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[75] ne
                                                                    0 &&
                                                                    $sudoku0->[75] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[76] ne
                                                                    0 &&
                                                                    $sudoku0->[76] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[77] ne
                                                                    0 &&
                                                                    $sudoku0->[77] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[78] ne
                                                                    0 &&
                                                                    $sudoku0->[78] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[73] ne
                                                                    0 &&
                                                                    $sudoku0->[73] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[74] ne
                                                                    0 &&
                                                                    $sudoku0->[74] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[75] ne
                                                                    0 &&
                                                                    $sudoku0->[75] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[76] ne
                                                                    0 &&
                                                                    $sudoku0->[76] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[77] ne
                                                                    0 &&
                                                                    $sudoku0->[77] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[78] ne
                                                                    0 &&
                                                                    $sudoku0->[78] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[79] ne
                                                                    0 &&
                                                                    $sudoku0->[79] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[1]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[2]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[2]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[9]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[9]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[9]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[10]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[10]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[10]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[10]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[11]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[11]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[11]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[11]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[11]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[18]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[18]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[18]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[18]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[18]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[18]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[19]) || ($sudoku0->[0] ne
                                                                    0 &&
                                                                    $sudoku0->[0] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[1] ne
                                                                    0 &&
                                                                    $sudoku0->[1] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[2] ne
                                                                    0 &&
                                                                    $sudoku0->[2] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[9] ne
                                                                    0 &&
                                                                    $sudoku0->[9] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[10] ne
                                                                    0 &&
                                                                    $sudoku0->[10] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[11] ne
                                                                    0 &&
                                                                    $sudoku0->[11] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[18] ne
                                                                    0 &&
                                                                    $sudoku0->[18] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[19] ne
                                                                    0 &&
                                                                    $sudoku0->[19] eq
                                                                    $sudoku0->[20]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[28]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[29]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[29]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[36]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[36]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[36]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[37]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[37]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[37]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[37]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[38]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[45]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[46]) || ($sudoku0->[27] ne
                                                                    0 &&
                                                                    $sudoku0->[27] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[28] ne
                                                                    0 &&
                                                                    $sudoku0->[28] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[29] ne
                                                                    0 &&
                                                                    $sudoku0->[29] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[36] ne
                                                                    0 &&
                                                                    $sudoku0->[36] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[37] ne
                                                                    0 &&
                                                                    $sudoku0->[37] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[38] ne
                                                                    0 &&
                                                                    $sudoku0->[38] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[45] ne
                                                                    0 &&
                                                                    $sudoku0->[45] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[46] ne
                                                                    0 &&
                                                                    $sudoku0->[46] eq
                                                                    $sudoku0->[47]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[55]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[56]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[63]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[64]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[65]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[72]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[73]) || ($sudoku0->[54] ne
                                                                    0 &&
                                                                    $sudoku0->[54] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[55] ne
                                                                    0 &&
                                                                    $sudoku0->[55] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[56] ne
                                                                    0 &&
                                                                    $sudoku0->[56] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[63] ne
                                                                    0 &&
                                                                    $sudoku0->[63] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[64] ne
                                                                    0 &&
                                                                    $sudoku0->[64] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[65] ne
                                                                    0 &&
                                                                    $sudoku0->[65] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[72] ne
                                                                    0 &&
                                                                    $sudoku0->[72] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[73] ne
                                                                    0 &&
                                                                    $sudoku0->[73] eq
                                                                    $sudoku0->[74]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[4]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[5]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[5]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[12]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[12]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[12]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[13]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[13]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[13]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[13]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[14]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[21]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[22]) || ($sudoku0->[3] ne
                                                                    0 &&
                                                                    $sudoku0->[3] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[4] ne
                                                                    0 &&
                                                                    $sudoku0->[4] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[5] ne
                                                                    0 &&
                                                                    $sudoku0->[5] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[12] ne
                                                                    0 &&
                                                                    $sudoku0->[12] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[13] ne
                                                                    0 &&
                                                                    $sudoku0->[13] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[14] ne
                                                                    0 &&
                                                                    $sudoku0->[14] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[21] ne
                                                                    0 &&
                                                                    $sudoku0->[21] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[22] ne
                                                                    0 &&
                                                                    $sudoku0->[22] eq
                                                                    $sudoku0->[23]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[31]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[32]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[39]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[40]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[41]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[48]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[49]) || ($sudoku0->[30] ne
                                                                    0 &&
                                                                    $sudoku0->[30] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[31] ne
                                                                    0 &&
                                                                    $sudoku0->[31] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[32] ne
                                                                    0 &&
                                                                    $sudoku0->[32] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[39] ne
                                                                    0 &&
                                                                    $sudoku0->[39] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[40] ne
                                                                    0 &&
                                                                    $sudoku0->[40] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[41] ne
                                                                    0 &&
                                                                    $sudoku0->[41] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[48] ne
                                                                    0 &&
                                                                    $sudoku0->[48] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[49] ne
                                                                    0 &&
                                                                    $sudoku0->[49] eq
                                                                    $sudoku0->[50]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[58]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[59]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[66]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[67]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[67] ne
                                                                    0 &&
                                                                    $sudoku0->[67] eq
                                                                    $sudoku0->[68]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[67] ne
                                                                    0 &&
                                                                    $sudoku0->[67] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[68] ne
                                                                    0 &&
                                                                    $sudoku0->[68] eq
                                                                    $sudoku0->[75]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[67] ne
                                                                    0 &&
                                                                    $sudoku0->[67] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[68] ne
                                                                    0 &&
                                                                    $sudoku0->[68] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[75] ne
                                                                    0 &&
                                                                    $sudoku0->[75] eq
                                                                    $sudoku0->[76]) || ($sudoku0->[57] ne
                                                                    0 &&
                                                                    $sudoku0->[57] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[58] ne
                                                                    0 &&
                                                                    $sudoku0->[58] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[59] ne
                                                                    0 &&
                                                                    $sudoku0->[59] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[66] ne
                                                                    0 &&
                                                                    $sudoku0->[66] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[67] ne
                                                                    0 &&
                                                                    $sudoku0->[67] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[68] ne
                                                                    0 &&
                                                                    $sudoku0->[68] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[75] ne
                                                                    0 &&
                                                                    $sudoku0->[75] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[76] ne
                                                                    0 &&
                                                                    $sudoku0->[76] eq
                                                                    $sudoku0->[77]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[7]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[8]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[15]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[16]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[17]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[24]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[25]) || ($sudoku0->[6] ne
                                                                    0 &&
                                                                    $sudoku0->[6] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[7] ne
                                                                    0 &&
                                                                    $sudoku0->[7] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[8] ne
                                                                    0 &&
                                                                    $sudoku0->[8] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[15] ne
                                                                    0 &&
                                                                    $sudoku0->[15] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[16] ne
                                                                    0 &&
                                                                    $sudoku0->[16] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[17] ne
                                                                    0 &&
                                                                    $sudoku0->[17] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[24] ne
                                                                    0 &&
                                                                    $sudoku0->[24] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[25] ne
                                                                    0 &&
                                                                    $sudoku0->[25] eq
                                                                    $sudoku0->[26]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[34]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[35]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[42]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[43]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[43] ne
                                                                    0 &&
                                                                    $sudoku0->[43] eq
                                                                    $sudoku0->[44]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[43] ne
                                                                    0 &&
                                                                    $sudoku0->[43] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[44] ne
                                                                    0 &&
                                                                    $sudoku0->[44] eq
                                                                    $sudoku0->[51]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[43] ne
                                                                    0 &&
                                                                    $sudoku0->[43] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[44] ne
                                                                    0 &&
                                                                    $sudoku0->[44] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[51] ne
                                                                    0 &&
                                                                    $sudoku0->[51] eq
                                                                    $sudoku0->[52]) || ($sudoku0->[33] ne
                                                                    0 &&
                                                                    $sudoku0->[33] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[34] ne
                                                                    0 &&
                                                                    $sudoku0->[34] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[35] ne
                                                                    0 &&
                                                                    $sudoku0->[35] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[42] ne
                                                                    0 &&
                                                                    $sudoku0->[42] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[43] ne
                                                                    0 &&
                                                                    $sudoku0->[43] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[44] ne
                                                                    0 &&
                                                                    $sudoku0->[44] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[51] ne
                                                                    0 &&
                                                                    $sudoku0->[51] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[52] ne
                                                                    0 &&
                                                                    $sudoku0->[52] eq
                                                                    $sudoku0->[53]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[61]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[62]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[62] ne
                                                                    0 &&
                                                                    $sudoku0->[62] eq
                                                                    $sudoku0->[69]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[62] ne
                                                                    0 &&
                                                                    $sudoku0->[62] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[69] ne
                                                                    0 &&
                                                                    $sudoku0->[69] eq
                                                                    $sudoku0->[70]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[62] ne
                                                                    0 &&
                                                                    $sudoku0->[62] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[69] ne
                                                                    0 &&
                                                                    $sudoku0->[69] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[70] ne
                                                                    0 &&
                                                                    $sudoku0->[70] eq
                                                                    $sudoku0->[71]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[62] ne
                                                                    0 &&
                                                                    $sudoku0->[62] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[69] ne
                                                                    0 &&
                                                                    $sudoku0->[69] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[70] ne
                                                                    0 &&
                                                                    $sudoku0->[70] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[71] ne
                                                                    0 &&
                                                                    $sudoku0->[71] eq
                                                                    $sudoku0->[78]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[62] ne
                                                                    0 &&
                                                                    $sudoku0->[62] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[69] ne
                                                                    0 &&
                                                                    $sudoku0->[69] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[70] ne
                                                                    0 &&
                                                                    $sudoku0->[70] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[71] ne
                                                                    0 &&
                                                                    $sudoku0->[71] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[78] ne
                                                                    0 &&
                                                                    $sudoku0->[78] eq
                                                                    $sudoku0->[79]) || ($sudoku0->[60] ne
                                                                    0 &&
                                                                    $sudoku0->[60] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[61] ne
                                                                    0 &&
                                                                    $sudoku0->[61] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[62] ne
                                                                    0 &&
                                                                    $sudoku0->[62] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[69] ne
                                                                    0 &&
                                                                    $sudoku0->[69] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[70] ne
                                                                    0 &&
                                                                    $sudoku0->[70] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[71] ne
                                                                    0 &&
                                                                    $sudoku0->[71] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[78] ne
                                                                    0 &&
                                                                    $sudoku0->[78] eq
                                                                    $sudoku0->[80]) || ($sudoku0->[79] ne
                                                                    0 &&
                                                                    $sudoku0->[79] eq
                                                                    $sudoku0->[80])) {
    return 0;
  }
  if (sudoku_done($sudoku0)) {
    return 1;
  }
  foreach my $i (0 .. 80) {
    if ($sudoku0->[$i] eq 0) {
      foreach my $p (1 .. 9) {
        $sudoku0->[$i] = $p;
        if (solve($sudoku0)) {
          return 1;
        }
      }
      $sudoku0->[$i] = 0;
      return 0;
    }
  }
  return 0;
}

my $sudoku0 = read_sudoku();
print_sudoku($sudoku0);
if (solve($sudoku0)) {
  print_sudoku($sudoku0);
}else{
  print("no solution\n");
}



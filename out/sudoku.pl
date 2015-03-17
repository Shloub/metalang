#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readint {
  nextchar() if (!defined $currentchar);
  my $o = 0, $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar;
  }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar;
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
        print " ";
      }
    }
    print "\n";
    if ((remainder($y, 3)) eq 2) {
      print "\n";
    }
  }
  print "\n";
}

# dit si les variables sont toutes différentes 

# dit si les variables sont toutes différentes 

# dit si le sudoku est terminé de remplir 

sub sudoku_done{
  my($s) = @_;
  foreach my $i (0 .. 80) {
    if ($s->[$i] eq 0) {
      return ();
    }
  }
  return 1;
}

# dit si il y a une erreur dans le sudoku 

sub sudoku_error{
  my($s) = @_;
  my $out1 = ();
  foreach my $x (0 .. 8) {
    $out1 = $out1 || ($s->[$x] ne 0 && $s->[$x] eq $s->[$x + 9]) ||
    ($s->[$x] ne 0 && $s->[$x] eq $s->[$x + 9 * 2]) ||
    ($s->[$x + 9] ne 0 && $s->[$x + 9] eq $s->[$x + 9 * 2]) ||
    ($s->[$x] ne 0 && $s->[$x] eq $s->[$x + 9 * 3]) ||
    ($s->[$x + 9] ne 0 && $s->[$x + 9] eq $s->[$x + 9 * 3]) ||
    ($s->[$x + 9 * 2] ne 0 && $s->[$x + 9 * 2] eq $s->[$x + 9 * 3]) ||
    ($s->[$x] ne 0 && $s->[$x] eq $s->[$x + 9 * 4]) ||
    ($s->[$x + 9] ne 0 && $s->[$x + 9] eq $s->[$x + 9 * 4]) ||
    ($s->[$x + 9 * 2] ne 0 && $s->[$x + 9 * 2] eq $s->[$x + 9 * 4]) ||
    ($s->[$x + 9 * 3] ne 0 && $s->[$x + 9 * 3] eq $s->[$x + 9 * 4]) ||
    ($s->[$x] ne 0 && $s->[$x] eq $s->[$x + 9 * 5]) ||
    ($s->[$x + 9] ne 0 && $s->[$x + 9] eq $s->[$x + 9 * 5]) ||
    ($s->[$x + 9 * 2] ne 0 && $s->[$x + 9 * 2] eq $s->[$x + 9 * 5]) ||
    ($s->[$x + 9 * 3] ne 0 && $s->[$x + 9 * 3] eq $s->[$x + 9 * 5]) ||
    ($s->[$x + 9 * 4] ne 0 && $s->[$x + 9 * 4] eq $s->[$x + 9 * 5]) ||
    ($s->[$x] ne 0 && $s->[$x] eq $s->[$x + 9 * 6]) ||
    ($s->[$x + 9] ne 0 && $s->[$x + 9] eq $s->[$x + 9 * 6]) ||
    ($s->[$x + 9 * 2] ne 0 && $s->[$x + 9 * 2] eq $s->[$x + 9 * 6]) ||
    ($s->[$x + 9 * 3] ne 0 && $s->[$x + 9 * 3] eq $s->[$x + 9 * 6]) ||
    ($s->[$x + 9 * 4] ne 0 && $s->[$x + 9 * 4] eq $s->[$x + 9 * 6]) ||
    ($s->[$x + 9 * 5] ne 0 && $s->[$x + 9 * 5] eq $s->[$x + 9 * 6]) ||
    ($s->[$x] ne 0 && $s->[$x] eq $s->[$x + 9 * 7]) ||
    ($s->[$x + 9] ne 0 && $s->[$x + 9] eq $s->[$x + 9 * 7]) ||
    ($s->[$x + 9 * 2] ne 0 && $s->[$x + 9 * 2] eq $s->[$x + 9 * 7]) ||
    ($s->[$x + 9 * 3] ne 0 && $s->[$x + 9 * 3] eq $s->[$x + 9 * 7]) ||
    ($s->[$x + 9 * 4] ne 0 && $s->[$x + 9 * 4] eq $s->[$x + 9 * 7]) ||
    ($s->[$x + 9 * 5] ne 0 && $s->[$x + 9 * 5] eq $s->[$x + 9 * 7]) ||
    ($s->[$x + 9 * 6] ne 0 && $s->[$x + 9 * 6] eq $s->[$x + 9 * 7]) ||
    ($s->[$x] ne 0 && $s->[$x] eq $s->[$x + 9 * 8]) ||
    ($s->[$x + 9] ne 0 && $s->[$x + 9] eq $s->[$x + 9 * 8]) ||
    ($s->[$x + 9 * 2] ne 0 && $s->[$x + 9 * 2] eq $s->[$x + 9 * 8]) ||
    ($s->[$x + 9 * 3] ne 0 && $s->[$x + 9 * 3] eq $s->[$x + 9 * 8]) ||
    ($s->[$x + 9 * 4] ne 0 && $s->[$x + 9 * 4] eq $s->[$x + 9 * 8]) ||
    ($s->[$x + 9 * 5] ne 0 && $s->[$x + 9 * 5] eq $s->[$x + 9 * 8]) ||
    ($s->[$x + 9 * 6] ne 0 && $s->[$x + 9 * 6] eq $s->[$x + 9 * 8]) ||
    ($s->[$x + 9 * 7] ne 0 && $s->[$x + 9 * 7] eq $s->[$x + 9 * 8]);
  }
  my $out2 = ();
  foreach my $x (0 .. 8) {
    $out2 = $out2 || ($s->[$x * 9] ne 0 && $s->[$x * 9] eq $s->[$x * 9 + 1]) ||
    ($s->[$x * 9] ne 0 && $s->[$x * 9] eq $s->[$x * 9 + 2]) ||
    ($s->[$x * 9 + 1] ne 0 && $s->[$x * 9 + 1] eq $s->[$x * 9 + 2]) ||
    ($s->[$x * 9] ne 0 && $s->[$x * 9] eq $s->[$x * 9 + 3]) ||
    ($s->[$x * 9 + 1] ne 0 && $s->[$x * 9 + 1] eq $s->[$x * 9 + 3]) ||
    ($s->[$x * 9 + 2] ne 0 && $s->[$x * 9 + 2] eq $s->[$x * 9 + 3]) ||
    ($s->[$x * 9] ne 0 && $s->[$x * 9] eq $s->[$x * 9 + 4]) ||
    ($s->[$x * 9 + 1] ne 0 && $s->[$x * 9 + 1] eq $s->[$x * 9 + 4]) ||
    ($s->[$x * 9 + 2] ne 0 && $s->[$x * 9 + 2] eq $s->[$x * 9 + 4]) ||
    ($s->[$x * 9 + 3] ne 0 && $s->[$x * 9 + 3] eq $s->[$x * 9 + 4]) ||
    ($s->[$x * 9] ne 0 && $s->[$x * 9] eq $s->[$x * 9 + 5]) ||
    ($s->[$x * 9 + 1] ne 0 && $s->[$x * 9 + 1] eq $s->[$x * 9 + 5]) ||
    ($s->[$x * 9 + 2] ne 0 && $s->[$x * 9 + 2] eq $s->[$x * 9 + 5]) ||
    ($s->[$x * 9 + 3] ne 0 && $s->[$x * 9 + 3] eq $s->[$x * 9 + 5]) ||
    ($s->[$x * 9 + 4] ne 0 && $s->[$x * 9 + 4] eq $s->[$x * 9 + 5]) ||
    ($s->[$x * 9] ne 0 && $s->[$x * 9] eq $s->[$x * 9 + 6]) ||
    ($s->[$x * 9 + 1] ne 0 && $s->[$x * 9 + 1] eq $s->[$x * 9 + 6]) ||
    ($s->[$x * 9 + 2] ne 0 && $s->[$x * 9 + 2] eq $s->[$x * 9 + 6]) ||
    ($s->[$x * 9 + 3] ne 0 && $s->[$x * 9 + 3] eq $s->[$x * 9 + 6]) ||
    ($s->[$x * 9 + 4] ne 0 && $s->[$x * 9 + 4] eq $s->[$x * 9 + 6]) ||
    ($s->[$x * 9 + 5] ne 0 && $s->[$x * 9 + 5] eq $s->[$x * 9 + 6]) ||
    ($s->[$x * 9] ne 0 && $s->[$x * 9] eq $s->[$x * 9 + 7]) ||
    ($s->[$x * 9 + 1] ne 0 && $s->[$x * 9 + 1] eq $s->[$x * 9 + 7]) ||
    ($s->[$x * 9 + 2] ne 0 && $s->[$x * 9 + 2] eq $s->[$x * 9 + 7]) ||
    ($s->[$x * 9 + 3] ne 0 && $s->[$x * 9 + 3] eq $s->[$x * 9 + 7]) ||
    ($s->[$x * 9 + 4] ne 0 && $s->[$x * 9 + 4] eq $s->[$x * 9 + 7]) ||
    ($s->[$x * 9 + 5] ne 0 && $s->[$x * 9 + 5] eq $s->[$x * 9 + 7]) ||
    ($s->[$x * 9 + 6] ne 0 && $s->[$x * 9 + 6] eq $s->[$x * 9 + 7]) ||
    ($s->[$x * 9] ne 0 && $s->[$x * 9] eq $s->[$x * 9 + 8]) ||
    ($s->[$x * 9 + 1] ne 0 && $s->[$x * 9 + 1] eq $s->[$x * 9 + 8]) ||
    ($s->[$x * 9 + 2] ne 0 && $s->[$x * 9 + 2] eq $s->[$x * 9 + 8]) ||
    ($s->[$x * 9 + 3] ne 0 && $s->[$x * 9 + 3] eq $s->[$x * 9 + 8]) ||
    ($s->[$x * 9 + 4] ne 0 && $s->[$x * 9 + 4] eq $s->[$x * 9 + 8]) ||
    ($s->[$x * 9 + 5] ne 0 && $s->[$x * 9 + 5] eq $s->[$x * 9 + 8]) ||
    ($s->[$x * 9 + 6] ne 0 && $s->[$x * 9 + 6] eq $s->[$x * 9 + 8]) ||
    ($s->[$x * 9 + 7] ne 0 && $s->[$x * 9 + 7] eq $s->[$x * 9 + 8]);
  }
  my $out3 = ();
  foreach my $x (0 .. 8) {
    $out3 = $out3 ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] eq
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] eq
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 1]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] ne 0 &&
      $s->[(remainder($x, 3)) * 3 * 9 + (int(($x) / (3))) * 3 + 2] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 1) * 9 + (int(($x) / (3))) * 3 + 2] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 2]) ||
    ($s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 1] ne 0 &&
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 1] eq
      $s->[((remainder($x, 3)) * 3 + 2) * 9 + (int(($x) / (3))) * 3 + 2]);
  }
  return $out1 || $out2 || $out3;
}

# résout le sudoku

sub solve{
  my($sudoku0) = @_;
  if (sudoku_error($sudoku0)) {
    return ();
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
      return ();
    }
  }
  return ();
}

my $sudoku0 = read_sudoku();
print_sudoku($sudoku0);
if (solve($sudoku0)) {
  print_sudoku($sudoku0);
}else{
  print "no solution\n";
}



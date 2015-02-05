#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readint {
  nextchar() if (!defined $currentchar);
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

#
#Tictactoe : un tictactoe avec une IA
#

# La structure de donnée 


# Un Mouvement 


# On affiche l'état 

sub print_state{
  my($g) = @_;
  print("\n|");
  foreach my $y (0 .. 2) {
    foreach my $x (0 .. 2) {
      if ($g->{"cases"}->[$x]->[$y] eq 0) {
        print(" ");
      }elsif ($g->{"cases"}->[$x]->[$y] eq 1) {
        print("O");
      }else{
        print("X");
      }
      print("|");
    }
    if ($y ne 2) {
      print("\n|-|-|-|\n|");
    }
  }
  print("\n");
}

# On dit qui gagne (info stoquées dans g.ended et g.note ) 

sub eval0{
  my($g) = @_;
  my $win = 0;
  my $freecase = 0;
  foreach my $y (0 .. 2) {
    my $col = -1;
    my $lin = -1;
    foreach my $x (0 .. 2) {
      if ($g->{"cases"}->[$x]->[$y] eq 0) {
        $freecase = $freecase + 1;
      }
      my $colv = $g->{"cases"}->[$x]->[$y];
      my $linv = $g->{"cases"}->[$y]->[$x];
      if ($col eq -1 && $colv ne 0) {
        $col = $colv;
      }elsif ($colv ne $col) {
        $col = -2;
      }
      if ($lin eq -1 && $linv ne 0) {
        $lin = $linv;
      }elsif ($linv ne $lin) {
        $lin = -2;
      }
    }
    if ($col >= 0) {
      $win = $col;
    }elsif ($lin >= 0) {
      $win = $lin;
    }
  }
  foreach my $x (1 .. 2) {
    if ($g->{"cases"}->[0]->[0] eq $x && $g->{"cases"}->[1]->[1] eq $x && $g->{"cases"}->[2]->[2] eq $x) {
      $win = $x;
    }
    if ($g->{"cases"}->[0]->[2] eq $x && $g->{"cases"}->[1]->[1] eq $x && $g->{"cases"}->[2]->[0] eq $x) {
      $win = $x;
    }
  }
  $g->{"ended"} = $win ne 0 || $freecase eq 0;
  if ($win eq 1) {
    $g->{"note"} = 1000;
  }elsif ($win eq 2) {
    $g->{"note"} = -1000;
  }else{
    $g->{"note"} = 0;
  }
}

# On applique un mouvement 

sub apply_move_xy{
  my($x, $y, $g) = @_;
  my $player = 2;
  if ($g->{"firstToPlay"}) {
    $player = 1;
  }
  $g->{"cases"}->[$x]->[$y] = $player;
  $g->{"firstToPlay"} = !$g->{"firstToPlay"};
}

sub apply_move{
  my($m, $g) = @_;
  apply_move_xy($m->{"x"}, $m->{"y"}, $g);
}

sub cancel_move_xy{
  my($x, $y, $g) = @_;
  $g->{"cases"}->[$x]->[$y] = 0;
  $g->{"firstToPlay"} = !$g->{"firstToPlay"};
  $g->{"ended"} = 0;
}

sub cancel_move{
  my($m, $g) = @_;
  cancel_move_xy($m->{"x"}, $m->{"y"}, $g);
}

sub can_move_xy{
  my($x, $y, $g) = @_;
  return $g->{"cases"}->[$x]->[$y] eq 0;
}

sub can_move{
  my($m, $g) = @_;
  return can_move_xy($m->{"x"}, $m->{"y"}, $g);
}

#
#Un minimax classique, renvoie la note du plateau
#

sub minmax{
  my($g) = @_;
  eval0($g);
  if ($g->{"ended"}) {
    return $g->{"note"};
  }
  my $maxNote = -10000;
  if (!$g->{"firstToPlay"}) {
    $maxNote = 10000;
  }
  foreach my $x (0 .. 2) {
    foreach my $y (0 .. 2) {
      if (can_move_xy($x, $y, $g)) {
        apply_move_xy($x, $y, $g);
        my $currentNote = minmax($g);
        cancel_move_xy($x, $y, $g);
        # Minimum ou Maximum selon le coté ou l'on joue
        
        if (($currentNote > $maxNote) eq $g->{"firstToPlay"}) {
          $maxNote = $currentNote;
        }
      }
    }
  }
  return $maxNote;
}

#
#Renvoie le coup de l'IA
#

sub play{
  my($g) = @_;
  my $minMove = {"x" => 0,
                 "y" => 0};
  my $minNote = 10000;
  foreach my $x (0 .. 2) {
    foreach my $y (0 .. 2) {
      if (can_move_xy($x, $y, $g)) {
        apply_move_xy($x, $y, $g);
        my $currentNote = minmax($g);
        print($x, ", ", $y, ", ", $currentNote, "\n");
        cancel_move_xy($x, $y, $g);
        if ($currentNote < $minNote) {
          $minNote = $currentNote;
          $minMove->{"x"} = $x;
          $minMove->{"y"} = $y;
        }
      }
    }
  }
  print($minMove->{"x"}, $minMove->{"y"}, "\n");
  return $minMove;
}

sub init0{
  my $cases = [];
  foreach my $i (0 .. 3 - 1) {
    my $tab = [];
    foreach my $j (0 .. 3 - 1) {
      $tab->[$j] = 0;
    }
    $cases->[$i] = $tab;
  }
  return {"cases" => $cases,
          "firstToPlay" => 1,
          "note" => 0,
          "ended" => 0};
}

sub read_move{
  my $x = readint();
  readspaces();
  my $y = readint();
  readspaces();
  return {"x" => $x,
          "y" => $y};
}

foreach my $i (0 .. 1) {
  my $state = init0();
  apply_move({"x" => 1,
              "y" => 1}, $state);
  apply_move({"x" => 0,
              "y" => 0}, $state);
  while (!$state->{"ended"})
  {
    print_state($state);
    apply_move(play($state), $state);
    eval0($state);
    print_state($state);
    if (!$state->{"ended"}) {
      apply_move(play($state), $state);
      eval0($state);
    }
  }
  print_state($state);
  print($state->{"note"}, "\n");
}



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
      }else{
      if ($g->{"cases"}->[$x]->[$y] eq 1) {
      print("O");
      }else{
      print("X");
      }
      }
      print("|");
      }
    if ($y ne 2) {
    print("\n|-|-|-|\n|");
    }else{
    
    }
    }
  print("\n");
}

# On dit qui gagne (info stoquées dans g.ended et g.note ) 

sub eval_{
  my($g) = @_;
  my $win = 0;
  my $freecase = 0;
  foreach my $y (0 .. 2) {
    my $col = -1;
    my $lin = -1;
    foreach my $x (0 .. 2) {
      if ($g->{"cases"}->[$x]->[$y] eq 0) {
      $freecase = $freecase + 1;
      }else{
      
      }
      my $colv = $g->{"cases"}->[$x]->[$y];
      my $linv = $g->{"cases"}->[$y]->[$x];
      if ($col eq -1 && $colv ne 0) {
      $col = $colv;
      }else{
      if ($colv ne $col) {
      $col = -2;
      }else{
      
      }
      }
      if ($lin eq -1 && $linv ne 0) {
      $lin = $linv;
      }else{
      if ($linv ne $lin) {
      $lin = -2;
      }else{
      
      }
      }
      }
    if ($col >= 0) {
    $win = $col;
    }else{
    if ($lin >= 0) {
    $win = $lin;
    }else{
    
    }
    }
    }
  foreach my $x (1 .. 2) {
    if ($g->{"cases"}->[0]->[0] eq $x && $g->{"cases"}->[1]->[1] eq $x && $g->{"cases"}->[2]->[2] eq $x) {
    $win = $x;
    }else{
    
    }
    if ($g->{"cases"}->[0]->[2] eq $x && $g->{"cases"}->[1]->[1] eq $x && $g->{"cases"}->[2]->[0] eq $x) {
    $win = $x;
    }else{
    
    }
    }
  $g->{"ended"} = $win ne 0 || $freecase eq 0;
  if ($win eq 1) {
  $g->{"note"} = 1000;
  }else{
  if ($win eq 2) {
  $g->{"note"} = -1000;
  }else{
  $g->{"note"} = 0;
  }
  }
}

# On applique un mouvement 

sub apply_move_xy{
  my($x,
  $y,
  $g) = @_;
  my $player = 2;
  if ($g->{"firstToPlay"}) {
  $player = 1;
  }else{
  
  }
  $g->{"cases"}->[$x]->[$y] = $player;
  $g->{"firstToPlay"} = !$g->{"firstToPlay"};
}

sub apply_move{
  my($m,
  $g) = @_;
  apply_move_xy($m->{"x"}, $m->{"y"}, $g);
}

sub cancel_move_xy{
  my($x,
  $y,
  $g) = @_;
  $g->{"cases"}->[$x]->[$y] = 0;
  $g->{"firstToPlay"} = !$g->{"firstToPlay"};
  $g->{"ended"} = 0;
}

sub cancel_move{
  my($m,
  $g) = @_;
  cancel_move_xy($m->{"x"}, $m->{"y"}, $g);
}

sub can_move_xy{
  my($x,
  $y,
  $g) = @_;
  return $g->{"cases"}->[$x]->[$y] eq 0;
}

sub can_move{
  my($m,
  $g) = @_;
  return can_move_xy($m->{"x"}, $m->{"y"}, $g);
}

#
#Un minimax classique, renvoie la note du plateau
#

sub minmax{
  my($g) = @_;
  eval_($g);
  if ($g->{"ended"}) {
  return $g->{"note"};
  }else{
  
  }
  my $maxNote = -10000;
  if (!$g->{"firstToPlay"}) {
  $maxNote = 10000;
  }else{
  
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
      }else{
      
      }
      }else{
      
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
  my $minMove = {"x"=>0,
                 "y"=>0};
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
      }else{
      
      }
      }else{
      
      }
      }
    }
  print($minMove->{"x"}, $minMove->{"y"}, "\n");
  return $minMove;
}

sub init_{
  my $b = 3;
  my $cases = [];
  foreach my $i (0 .. $b - 1) {
    my $a = 3;
    my $tab = [];
    foreach my $j (0 .. $a - 1) {
      $tab->[$j] = 0;
      }
    $cases->[$i] = $tab;
    }
  my $c = {"cases"=>$cases,
           "firstToPlay"=>1,
           "note"=>0,
           "ended"=>0};
  return $c;
}

sub read_move{
  my $x = 0;
  $x = readint();
  readspaces();
  my $y = 0;
  $y = readint();
  readspaces();
  my $d = {"x"=>$x,
           "y"=>$y};
  return $d;
}

foreach my $i (0 .. 1) {
  my $state = init_();
  my $e = {"x"=>1,
           "y"=>1};
  apply_move($e, $state);
  my $f = {"x"=>0,
           "y"=>0};
  apply_move($f, $state);
  while (!$state->{"ended"})
  {
    print_state($state);
    apply_move(play($state), $state);
    eval_($state);
    print_state($state);
    if (!$state->{"ended"}) {
    apply_move(play($state), $state);
    eval_($state);
    }else{
    
    }
  }
  print_state($state);
  print($state->{"note"}, "\n");
  }



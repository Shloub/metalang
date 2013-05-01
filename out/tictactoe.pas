program tictactoe;

{
Tictactoe : un tictactoe avec une IA
}
{ La structure de donnée }
type
    gamestate=^gamestate_r;
    gamestate_r = record
      cases : array of array of integer;
      firstToPlay : boolean;
      note : integer;
      ended : boolean;
    end;

{ Un Mouvement }
type
    move=^move_r;
    move_r = record
      x : integer;
      y : integer;
    end;

{ On affiche l'état }
procedure print_state(g : gamestate);
var
  x : integer;
  y : integer;
begin
  write(''#10'|');
  for y := 0 to  2 do
  begin
    for x := 0 to  2 do
    begin
      if g^.cases[x][y] = 0 then
        begin
          write(' ');
        end
      else if g^.cases[x][y] = 1
      then
        begin
          write('O');
        end
      else
        begin
          write('X');
        end;;
      write('|');
    end;
    if y <> 2
    then
      begin
        write(''#10'|-|-|-|'#10'|');
      end;
  end;
  write(''#10'');
end;

{ On dit qui gagne (info stoquées dans g.ended et g.note ) }
procedure eval_(g : gamestate);
var
  col : integer;
  colv : integer;
  freecase : integer;
  lin : integer;
  linv : integer;
  win : integer;
  x : integer;
  y : integer;
begin
  win := 0;
  freecase := 0;
  for y := 0 to  2 do
  begin
    col := -1;
    lin := -1;
    for x := 0 to  2 do
    begin
      if g^.cases[x][y] = 0
      then
        begin
          freecase := freecase + 1;
        end;
      colv := g^.cases[x][y];
      linv := g^.cases[y][x];
      if (col = -1) and (colv <> 0) then
        begin
          col := colv;
        end
      else if colv <> col
      then
        begin
          col := -2;
        end;;
      if (lin = -1) and (linv <> 0) then
        begin
          lin := linv;
        end
      else if linv <> lin
      then
        begin
          lin := -2;
        end;;
    end;
    if col >= 0 then
      begin
        win := col;
      end
    else if lin >= 0
    then
      begin
        win := lin;
      end;;
  end;
  for x := 1 to  2 do
  begin
    if (g^.cases[0][0] = x) and (g^.cases[1][1] = x) and (g^.cases[2][2] = x)
    then
      begin
        win := x;
      end;
    if (g^.cases[0][2] = x) and (g^.cases[1][1] = x) and (g^.cases[2][0] = x)
    then
      begin
        win := x;
      end;
  end;
  g^.ended := (win <> 0) or (freecase = 0);
  if win = 1 then
    begin
      g^.note := 1000;
    end
  else if win = 2
  then
    begin
      g^.note := -1000;
    end
  else
    begin
      g^.note := 0;
    end;;
end;

{ On applique un mouvement }
procedure apply_move_xy(x : integer; y : integer; g : gamestate);
var
  player : integer;
begin
  player := 2;
  if g^.firstToPlay
  then
    begin
      player := 1;
    end;
  g^.cases[x][y] := player;
  g^.firstToPlay := not g^.firstToPlay;
end;

procedure apply_move(m : move; g : gamestate);
begin
  apply_move_xy(m^.x, m^.y, g);
end;

procedure cancel_move_xy(x : integer; y : integer; g : gamestate);
begin
  g^.cases[x][y] := 0;
  g^.firstToPlay := not g^.firstToPlay;
  g^.ended := false;
end;

function can_move_xy(x : integer; y : integer; g : gamestate) : boolean;
begin
  exit(g^.cases[x][y] = 0);
end;

function minmax(g : gamestate) : integer;
var
  currentNote : integer;
  maxNote : integer;
  x : integer;
  y : integer;
begin
  eval_(g);
  if g^.ended
  then
    begin
      exit(g^.note);
    end;
  maxNote := -10000;
  if not g^.firstToPlay
  then
    begin
      maxNote := 10000;
    end;
  for x := 0 to  2 do
  begin
    for y := 0 to  2 do
    begin
      if can_move_xy(x, y, g)
      then
        begin
          apply_move_xy(x, y, g);
          currentNote := minmax(g);
          cancel_move_xy(x, y, g);
          if (currentNote > maxNote) = g^.firstToPlay
          then
            begin
              maxNote := currentNote;
            end;
        end;
    end;
  end;
  exit(maxNote);
end;

function play(g : gamestate) : move;
var
  currentNote : integer;
  f : integer;
  h : integer;
  minMove : move;
  minNote : integer;
  x : integer;
  y : integer;
begin
  new(minMove);
  minMove^.x := 0;
  minMove^.y := 0;
  minNote := 10000;
  for x := 0 to  2 do
  begin
    for y := 0 to  2 do
    begin
      if can_move_xy(x, y, g)
      then
        begin
          apply_move_xy(x, y, g);
          currentNote := minmax(g);
          write(x);
          write(', ');
          write(y);
          write(', ');
          write(currentNote);
          write(''#10'');
          cancel_move_xy(x, y, g);
          if currentNote < minNote
          then
            begin
              minNote := currentNote;
              minMove^.x := x;
              minMove^.y := y;
            end;
        end;
    end;
  end;
  f := minMove^.x;
  write(f);
  h := minMove^.y;
  write(h);
  write(''#10'');
  exit(minMove);
end;

type o = array of integer;
function init() : gamestate;
var
  cases : array of o;
  i : integer;
  j : integer;
  k : integer;
  l : integer;
  out_ : gamestate;
  tab : o;
begin
  l := 3;
  SetLength(cases, l);
  for i := 0 to  l - 1 do
  begin
    k := 3;
    SetLength(tab, k);
    for j := 0 to  k - 1 do
    begin
      tab[j] := 0;
    end;
    cases[i] := tab;
  end;
  new(out_);
  out_^.cases := cases;
  out_^.firstToPlay := true;
  out_^.note := 0;
  out_^.ended := false;
  exit(out_);
end;


var
  i : integer;
  n : integer;
  state : gamestate;
begin
  for i := 0 to  1 do
  begin
    state := init();
    while not state^.ended do
    begin
      print_state(state);
      apply_move(play(state), state);
      eval_(state);
      print_state(state);
      if not state^.ended
      then
        begin
          apply_move(play(state), state);
          eval_(state);
        end;
    end;
    print_state(state);
    n := state^.note;
    write(n);
    write(''#10'');
  end;
end.



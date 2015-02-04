require "scanf.rb"

=begin

Tictactoe : un tictactoe avec une IA

=end


=begin
 La structure de donnée 
=end



=begin
 Un Mouvement 
=end



=begin
 On affiche l'état 
=end

def print_state( g )
    print "\n|";
    for y in (0 ..  2) do
      for x in (0 ..  2) do
        if g["cases"][x][y] == 0 then
          print " ";
        elsif g["cases"][x][y] == 1 then
          print "O";
        else
          print "X";
        end
        print "|";
      end
      if y != 2 then
        print "\n|-|-|-|\n|";
      end
    end
    print "\n";
end


=begin
 On dit qui gagne (info stoquées dans g.ended et g.note ) 
=end

def eval0( g )
    win = 0
    freecase = 0
    for y in (0 ..  2) do
      col = -1
      lin = -1
      for x in (0 ..  2) do
        if g["cases"][x][y] == 0 then
          freecase += 1
        end
        colv = g["cases"][x][y]
        linv = g["cases"][y][x]
        if col == -1 && colv != 0 then
          col = colv
        elsif colv != col then
          col = -2
        end
        if lin == -1 && linv != 0 then
          lin = linv
        elsif linv != lin then
          lin = -2
        end
      end
      if col >= 0 then
        win = col
      elsif lin >= 0 then
        win = lin
      end
    end
    for x in (1 ..  2) do
      if g["cases"][0][0] == x && g["cases"][1][1] == x && g["cases"][2][2] == x then
        win = x
      end
      if g["cases"][0][2] == x && g["cases"][1][1] == x && g["cases"][2][0] == x then
        win = x
      end
    end
    g["ended"] = win != 0 || freecase == 0
    if win == 1 then
      g["note"] = 1000
    elsif win == 2 then
      g["note"] = -1000
    else
      g["note"] = 0
    end
end


=begin
 On applique un mouvement 
=end

def apply_move_xy( x, y, g )
    player = 2
    if g["firstToPlay"] then
      player = 1
    end
    g["cases"][x][y] = player
    g["firstToPlay"] = not(g["firstToPlay"])
end

def apply_move( m, g )
    apply_move_xy(m["x"], m["y"], g)
end

def cancel_move_xy( x, y, g )
    g["cases"][x][y] = 0
    g["firstToPlay"] = not(g["firstToPlay"])
    g["ended"] = false
end

def cancel_move( m, g )
    cancel_move_xy(m["x"], m["y"], g)
end

def can_move_xy( x, y, g )
    return (g["cases"][x][y] == 0);
end

def can_move( m, g )
    return (can_move_xy(m["x"], m["y"], g));
end


=begin

Un minimax classique, renvoie la note du plateau

=end

def minmax( g )
    eval0(g)
    if g["ended"] then
      return (g["note"]);
    end
    maxNote = -10000
    if not(g["firstToPlay"]) then
      maxNote = 10000
    end
    for x in (0 ..  2) do
      for y in (0 ..  2) do
        if can_move_xy(x, y, g) then
          apply_move_xy(x, y, g)
          currentNote = minmax(g)
          cancel_move_xy(x, y, g)
          
=begin
 Minimum ou Maximum selon le coté ou l'on joue
=end

          if (currentNote > maxNote) == g["firstToPlay"] then
            maxNote = currentNote
          end
        end
      end
    end
    return (maxNote);
end


=begin

Renvoie le coup de l'IA

=end

def play( g )
    minMove = {
      "x" => 0,
      "y" => 0}
    minNote = 10000
    for x in (0 ..  2) do
      for y in (0 ..  2) do
        if can_move_xy(x, y, g) then
          apply_move_xy(x, y, g)
          currentNote = minmax(g)
          printf "%d, %d, %d\n", x, y, currentNote
          cancel_move_xy(x, y, g)
          if currentNote < minNote then
            minNote = currentNote
            minMove["x"] = x
            minMove["y"] = y
          end
        end
      end
    end
    printf "%d%d\n", minMove["x"], minMove["y"]
    return (minMove);
end

def init0(  )
    cases = [];
    for i in (0 ..  3 - 1) do
      tab = [];
      for j in (0 ..  3 - 1) do
        tab[j] = 0
      end
      cases[i] = tab
    end
    return ({
      "cases" => cases,
      "firstToPlay" => true,
      "note" => 0,
      "ended" => false});
end

def read_move(  )
    x=scanf("%d")[0];
    scanf("%*\n");
    y=scanf("%d")[0];
    scanf("%*\n");
    return ({
      "x" => x,
      "y" => y});
end

for i in (0 ..  1) do
  state = init0()
  apply_move({
    "x" => 1,
    "y" => 1}, state)
  apply_move({
    "x" => 0,
    "y" => 0}, state)
  while not(state["ended"]) do
    print_state(state)
    apply_move(play(state), state)
    eval0(state)
    print_state(state)
    if not(state["ended"]) then
      apply_move(play(state), state)
      eval0(state)
    end
  end
  print_state(state)
  printf "%d\n", state["note"]
end


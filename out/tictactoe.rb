
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
    printf "%s", "\n|"
    for y in (0 ..  2) do
      for x in (0 ..  2) do
        if g["cases"][x][y] == 0 then
          printf "%s", " "
        elsif g["cases"][x][y] == 1 then
          printf "%s", "O"
        else
          printf "%s", "X"
        end
        printf "%s", "|"
      end
      if y != 2 then
        printf "%s", "\n|-|-|-|\n|"
      end
    end
    printf "%s", "\n"
end


=begin
 On dit qui gagne (info stoquées dans g.ended et g.note ) 
=end

def eval_( g )
    win = 0
    freecase = 0
    for y in (0 ..  2) do
      col = -1
      lin = -1
      for x in (0 ..  2) do
        if g["cases"][x][y] == 0 then
          freecase = freecase + 1;
        end
        colv = g["cases"][x][y]
        linv = g["cases"][y][x]
        if col == -1 && colv != 0 then
          col = colv;
        elsif colv != col then
          col = -2;
        end
        if lin == -1 && linv != 0 then
          lin = linv;
        elsif linv != lin then
          lin = -2;
        end
      end
      if col >= 0 then
        win = col;
      elsif lin >= 0 then
        win = lin;
      end
    end
    for x in (1 ..  2) do
      if g["cases"][0][0] == x && g["cases"][1][1] == x && g["cases"][2][2] == x then
        win = x;
      end
      if g["cases"][0][2] == x && g["cases"][1][1] == x && g["cases"][2][0] == x then
        win = x;
      end
    end
    g["ended"] = win != 0 || freecase == 0;
    if win == 1 then
      g["note"] = 1000;
    elsif win == 2 then
      g["note"] = -1000;
    else
      g["note"] = 0;
    end
end


=begin
 On applique un mouvement 
=end

def apply_move_xy( x, y, g )
    player = 2
    if g["firstToPlay"] then
      player = 1;
    end
    g["cases"][x][y] = player;
    g["firstToPlay"] = not(g["firstToPlay"]);
end

def apply_move( m, g )
    apply_move_xy(m["x"], m["y"], g);
end

def cancel_move_xy( x, y, g )
    g["cases"][x][y] = 0;
    g["firstToPlay"] = not(g["firstToPlay"]);
    g["ended"] = false;
end

def can_move_xy( x, y, g )
    return (g["cases"][x][y] == 0);
end

def minmax( g )
    eval_(g);
    if g["ended"] then
      return (g["note"]);
    end
    maxNote = -10000
    if not(g["firstToPlay"]) then
      maxNote = 10000;
    end
    for x in (0 ..  2) do
      for y in (0 ..  2) do
        if can_move_xy(x, y, g) then
          apply_move_xy(x, y, g);
          currentNote = minmax(g)
          cancel_move_xy(x, y, g);
          if (currentNote > maxNote) == g["firstToPlay"] then
            maxNote = currentNote;
          end
        end
      end
    end
    return (maxNote);
end

def play( g )
    minMove = {"x" => 0,
               "y" => 0};
    minNote = 10000
    for x in (0 ..  2) do
      for y in (0 ..  2) do
        if can_move_xy(x, y, g) then
          apply_move_xy(x, y, g);
          currentNote = minmax(g)
          printf "%d", x
          printf "%s", ", "
          printf "%d", y
          printf "%s", ", "
          printf "%d", currentNote
          printf "%s", "\n"
          cancel_move_xy(x, y, g);
          if currentNote < minNote then
            minNote = currentNote;
            minMove["x"] = x;
            minMove["y"] = y;
          end
        end
      end
    end
    bv = minMove["x"]
    printf "%d", bv
    bw = minMove["y"]
    printf "%d", bw
    printf "%s", "\n"
    return (minMove);
end

def init(  )
    by = 3
    cases = [];
    for i in (0 ..  by - 1) do
      bx = 3
      tab = [];
      for j in (0 ..  bx - 1) do
        tab[j] = 0;
      end
      cases[i] = tab;
    end
    out_ = {"cases" => cases,
            "firstToPlay" => true,
            "note" => 0,
            "ended" => false};
    return (out_);
end

for i in (0 ..  1) do
  state = init()
  while not(state["ended"]) do
    print_state(state);
    apply_move(play(state), state);
    eval_(state);
    print_state(state);
    if not(state["ended"]) then
      apply_move(play(state), state);
      eval_(state);
    end
  end
  print_state(state);
  bz = state["note"]
  printf "%d", bz
  printf "%s", "\n"
end


import sys
char=None
def readchar_():
  global char
  if char == None:
    char = sys.stdin.read(1)
  return char

def skipchar():
  global char
  char = None
  return
def stdinsep():
  while True:
    c = readchar_()
    if c == '\n' or c == '\t' or c == '\r' or c == ' ':
      skipchar()
    else:
      return
def readint():
  c = readchar_()
  if c == '-':
    sign = -1
    skipchar()
  else:
    sign = 1
  out = 0
  while True:
    c = readchar_()
    if c <= '9' and c >= '0' :
      out = out * 10 + int(c)
      skipchar()
    else:
      return out * sign
"""
Tictactoe : un tictactoe avec une IA
"""
""" La structure de donnée """

""" Un Mouvement """

""" On affiche l'état """
def print_state( g ):
    print( "\n|", end='')
    for y in range(0, 1 + 2):
      for x in range(0, 1 + 2):
        if g["cases"][x][y] == 0:
          print( " ", end='')
        elif g["cases"][x][y] == 1:
          print( "O", end='')
        else:
          print( "X", end='')
        print( "|", end='')
      if y != 2:
        print( "\n|-|-|-|\n|", end='')
    print("")

""" On dit qui gagne (info stoquées dans g.ended et g.note ) """
def eval_( g ):
    win = 0;
    freecase = 0;
    for y in range(0, 1 + 2):
      col = -(1);
      lin = -(1);
      for x in range(0, 1 + 2):
        if g["cases"][x][y] == 0:
          freecase += 1
        colv = g["cases"][x][y];
        linv = g["cases"][y][x];
        if col == -(1) and colv != 0:
          col = colv;
        elif colv != col:
          col = -(2);
        if lin == -(1) and linv != 0:
          lin = linv;
        elif linv != lin:
          lin = -(2);
      if col >= 0:
        win = col;
      elif lin >= 0:
        win = lin;
    for x in range(1, 1 + 2):
      if g["cases"][0][0] == x and g["cases"][1][1] == x and g["cases"][2][2] == x:
        win = x;
      if g["cases"][0][2] == x and g["cases"][1][1] == x and g["cases"][2][0] == x:
        win = x;
    g["ended"] = win != 0 or freecase == 0;
    if win == 1:
      g["note"] = 1000;
    elif win == 2:
      g["note"] = -(1000);
    else:
      g["note"] = 0;

""" On applique un mouvement """
def apply_move_xy( x, y, g ):
    player = 2;
    if g["firstToPlay"]:
      player = 1;
    g["cases"][x][y] = player;
    g["firstToPlay"] = not (g["firstToPlay"]);

def apply_move( m, g ):
    apply_move_xy(m["x"], m["y"], g);

def cancel_move_xy( x, y, g ):
    g["cases"][x][y] = 0;
    g["firstToPlay"] = not (g["firstToPlay"]);
    g["ended"] = False;

def cancel_move( m, g ):
    cancel_move_xy(m["x"], m["y"], g);

def can_move_xy( x, y, g ):
    return g["cases"][x][y] == 0;

def can_move( m, g ):
    return can_move_xy(m["x"], m["y"], g);

"""
Un minimax classique, renvoie la note du plateau
"""
def minmax( g ):
    eval_(g);
    if g["ended"]:
      return g["note"];
    maxNote = -(10000);
    if not (g["firstToPlay"]):
      maxNote = 10000;
    for x in range(0, 1 + 2):
      for y in range(0, 1 + 2):
        if can_move_xy(x, y, g):
          apply_move_xy(x, y, g);
          currentNote = minmax(g);
          cancel_move_xy(x, y, g);
          """ Minimum ou Maximum selon le coté ou l'on joue"""
          if (currentNote > maxNote) == g["firstToPlay"]:
            maxNote = currentNote;
    return maxNote;

"""
Renvoie le coup de l'IA
"""
def play( g ):
    minMove = {
      "x":0,
      "y":0};
    minNote = 10000;
    for x in range(0, 1 + 2):
      for y in range(0, 1 + 2):
        if can_move_xy(x, y, g):
          apply_move_xy(x, y, g);
          currentNote = minmax(g);
          print("%d, %d, %d\n" % ( x, y, currentNote ), end='')
          cancel_move_xy(x, y, g);
          if currentNote < minNote:
            minNote = currentNote;
            minMove["x"] = x;
            minMove["y"] = y;
    print("%d%d\n" % ( minMove["x"], minMove["y"] ), end='')
    return minMove;

def init_(  ):
    cases = [None] * 3
    for i in range(0, 3):
      tab = [None] * 3
      for j in range(0, 3):
        tab[j] = 0;
      cases[i] = tab;
    return {
      "cases":cases,
      "firstToPlay":True,
      "note":0,
      "ended":False};

def read_move(  ):
    x = 0;
    x=readint()
    stdinsep()
    y = 0;
    y=readint()
    stdinsep()
    return {
      "x":x,
      "y":y};

for i in range(0, 1 + 1):
  state = init_();
  apply_move({
    "x":1,
    "y":1}, state);
  apply_move({
    "x":0,
    "y":0}, state);
  while (not (state["ended"])):
    print_state(state);
    apply_move(play(state), state);
    eval_(state);
    print_state(state);
    if not (state["ended"]):
      apply_move(play(state), state);
      eval_(state);
  print_state(state);
  print("%d\n" % ( state["note"] ), end='')


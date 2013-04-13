
import sys

char=None

def readchar_():
  global char;
  if char == None:
    char = sys.stdin.read(1);
  return char;

def skipchar():
  global char;
  char = None;
  return;

def readchar():
  out = readchar_();
  skipchar();
  return out;

def stdinsep():
  while True:
    c = readchar_();
    if c == '\n' or c == '\t' or c == '\r' or c == ' ':
      skipchar();
    else:
      return;

def readint():
  c = readchar_();
  if c == '-':
    sign = -1;
    skipchar();
  else:
    sign = 1;
  out = 0;
  while True:
    c = readchar_();
    if c <= '9' and c >= '0' :
      out = out * 10 + int(c);
      skipchar();
    else:
      return out * sign;
"""
Tictactoe : un tictactoe avec une IA
"""
""" La structure de donnée """

""" Un Mouvement """

""" On affiche l'état """
def print_state( g ):
    print("%s" % "\n|", end='');
    for y in range(0, 1 + 2):
      for x in range(0, 1 + 2):
        if g["cases"][x][y] == 0:
          print("%s" % " ", end='');
        elif g["cases"][x][y] == 1:
          print("%s" % "O", end='');
        else:
          print("%s" % "X", end='');
        print("%s" % "|", end='');
      if y != 2:
        print("%s" % "\n|-|-|-|\n|", end='');
    print("%s" % "\n", end='');

""" On dit qui gagne (info stoquées dans g.ended et g.note ) """
def eval_( g ):
    win = 0;
    freecase = 0;
    for y in range(0, 1 + 2):
      col = -(1);
      lin = -(1);
      for x in range(0, 1 + 2):
        if g["cases"][x][y] == 0:
          freecase = freecase + 1;
        colv = g["cases"][x][y];
        linv = g["cases"][y][x];
        if (col == -(1)) and (colv != 0):
          col = colv;
        elif colv != col:
          col = -(2);
        if (lin == -(1)) and (linv != 0):
          lin = linv;
        elif linv != lin:
          lin = -(2);
      if col >= 0:
        win = col;
      elif lin >= 0:
        win = lin;
    for x in range(1, 1 + 2):
      if ((g["cases"][0][0] == x) and (g["cases"][1][1] == x)) and (g["cases"][2][2] == x):
        win = x;
      if ((g["cases"][0][2] == x) and (g["cases"][1][1] == x)) and (g["cases"][2][0] == x):
        win = x;
    g["ended"] = (win != 0) or (freecase == 0);
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

def can_move_xy( x, y, g ):
    return g["cases"][x][y] == 0;

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
          if (currentNote > maxNote) == g["firstToPlay"]:
            maxNote = currentNote;
    return maxNote;

def play( g ):
    minMove = {"x":0, "y":0};
    minNote = 10000;
    for x in range(0, 1 + 2):
      for y in range(0, 1 + 2):
        if can_move_xy(x, y, g):
          apply_move_xy(x, y, g);
          currentNote = minmax(g);
          print("%d" % x, end='');
          print("%s" % ", ", end='');
          print("%d" % y, end='');
          print("%s" % ", ", end='');
          print("%d" % currentNote, end='');
          print("%s" % "\n", end='');
          cancel_move_xy(x, y, g);
          if currentNote < minNote:
            minNote = currentNote;
            minMove["x"] = x;
            minMove["y"] = y;
    ca = minMove["x"];
    print("%d" % ca, end='');
    cb = minMove["y"];
    print("%d" % cb, end='');
    print("%s" % "\n", end='');
    return minMove;

def init(  ):
    cd = 3;
    cases = [None] * cd;
    for i in range(0, cd):
      cc = 3;
      tab = [None] * cc;
      for j in range(0, cc):
        tab[j] = 0;
      cases[i] = tab;
    out_ = {"cases":cases, "firstToPlay":True, "note":0, "ended":False};
    return out_;

for i in range(0, 1 + 1):
  state = init();
  while (not (state["ended"])):
    print_state(state);
    apply_move(play(state), state);
    eval_(state);
    print_state(state);
    if not (state["ended"]):
      apply_move(play(state), state);
      eval_(state);
  print_state(state);
  ce = state["note"];
  print("%d" % ce, end='');
  print("%s" % "\n", end='');


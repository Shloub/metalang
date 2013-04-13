
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



def can_open_right( state, x, y ):
    return (x < (state["sizeX"] - 1)) and state["cases"][x + 1][y]["free"];

def can_open_left( state, x, y ):
    return (x > 0) and state["cases"][x - 1][y]["free"];

def can_open_bottom( state, x, y ):
    return (y < (state["sizeY"] - 1)) and state["cases"][x][y + 1]["free"];

def can_open_top( state, x, y ):
    return (y > 0) and state["cases"][x][y - 1]["free"];

def open_left( state, x, y ):
    state["cases"][x - 1][y]["right"] = False;
    state["cases"][x][y]["left"] = False;
    state["cases"][x - 1][y]["free"] = False;
    state["cases"][x][y]["free"] = False;

def open_right( state, x, y ):
    state["cases"][x][y]["right"] = False;
    state["cases"][x + 1][y]["left"] = False;
    state["cases"][x][y]["free"] = False;
    state["cases"][x + 1][y]["free"] = False;

def open_top( state, x, y ):
    state["cases"][x][y - 1]["bottom"] = False;
    state["cases"][x][y]["top"] = False;
    state["cases"][x][y - 1]["free"] = False;
    state["cases"][x][y]["free"] = False;

def open_bottom( state, x, y ):
    state["cases"][x][y + 1]["top"] = False;
    state["cases"][x][y]["bottom"] = False;
    state["cases"][x][y + 1]["free"] = False;
    state["cases"][x][y]["free"] = False;

def init( x, y ):
    cases = [None] * (x);
    for i in range(0, 1 + x - 1):
      cases_x = [None] * (y);
      for j in range(0, 1 + y - 1):
        reco = {"left":True, "right":True, "top":True, "bottom":True, 
        "free":True};
        
        cases_x[j] = reco;
      cases[i] = cases_x;
    out_ = {"sizeX":x, "sizeY":y, "cases":cases};
    
    return out_;

def print_lab( l ):
    for x in range(0, 1 + l["sizeX"] - 1):
      print("%s" % "__", end='');
    print("%s" % "\n", end='');
    for y in range(0, 1 + l["sizeY"] - 1):
      for x in range(0, 1 + l["sizeX"] - 1):
        if l["cases"][x][y]["left"]:
          if l["cases"][x][y]["bottom"]:
            print("%s" % "|_", end='');
          else:
            print("%s" % "| ", end='');
        elif l["cases"][x][y]["bottom"]:
          print("%s" % "__", end='');
        else:
          print("%s" % "  ", end='');
      print("%s" % "|\n", end='');
    print("%s" % "\n", end='');

def gen( lab, x, y ):
    o = 4;
    order = [None] * (o);
    for i in range(0, 1 + o - 1):
      order[i] = i;
    for i in range(0, 1 + 2):
      j = 4 -
i;
      k = order[i];
      order[i] = order[j];
      order[j] = k;
    for i in range(0, 1 + 3):
      if (0 == order[i]) and can_open_left(lab, x, y):
        open_left(lab, x, y);
        gen(lab, x - 1, y);
      if (1 == order[i]) and can_open_right(lab, x, y):
        open_right(lab, x, y);
        gen(lab, x + 1, y);
      if (2 == order[i]) and can_open_top(lab, x, y):
        open_top(lab, x, y);
        gen(lab, x, y - 1);
      if (3 == order[i]) and can_open_bottom(lab, x, y):
        open_bottom(lab, x, y);
        gen(lab, x, y + 1);

lab = init(10, 10);
gen(lab, 0, 0);
print_lab(lab);


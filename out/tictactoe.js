
var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char = function(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
var stdinsep = function(){
    if (current_char == null) current_char = read_char0();
    while (current_char == '\n' || current_char == ' ' || current_char == '\t')
        current_char = read_char0();
}
var read_int = function(){
    if (current_char == null) current_char = read_char0();
    var sign = 1;
    if (current_char == '-'){
        current_char = read_char0();
        sign = -1;
    }
    var out = 0;
    while (true){
        if (current_char.charCodeAt(0) >= '0'.charCodeAt(0) && current_char.charCodeAt(0) <= '9'.charCodeAt(0)){
            out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
            current_char = read_char0();
        }else{
            return out * sign;
        }
    }
}


/*
Tictactoe : un tictactoe avec une IA
*/
/* La structure de donnée */

/* Un Mouvement */

/* On affiche l'état */
function print_state(g){
  util.print("\n|");
  for (var y = 0 ; y <= 2; y++)
  {
    for (var x = 0 ; x <= 2; x++)
    {
      if (g.cases[x][y] == 0)
      {
        util.print(" ");
      }
      else if (g.cases[x][y] == 1)
      {
        util.print("O");
      }
      else
      {
        util.print("X");
      }
      util.print("|");
    }
    if (y != 2)
    {
      util.print("\n|-|-|-|\n|");
    }
  }
  util.print("\n");
}

/* On dit qui gagne (info stoquées dans g.ended et g.note ) */
function eval_(g){
  var win = 0;
  var freecase = 0;
  for (var y = 0 ; y <= 2; y++)
  {
    var col = -1;
    var lin = -1;
    for (var x = 0 ; x <= 2; x++)
    {
      if (g.cases[x][y] == 0)
      {
        freecase = freecase + 1;
      }
      var colv = g.cases[x][y];
      var linv = g.cases[y][x];
      if ((col == -1) && (colv != 0))
      {
        col = colv;
      }
      else if (colv != col)
      {
        col = -2;
      }
      if ((lin == -1) && (linv != 0))
      {
        lin = linv;
      }
      else if (linv != lin)
      {
        lin = -2;
      }
    }
    if (col >= 0)
    {
      win = col;
    }
    else if (lin >= 0)
    {
      win = lin;
    }
  }
  for (var x = 1 ; x <= 2; x++)
  {
    if (((g.cases[0][0] == x) && (g.cases[1][1] == x)) && (g.cases[2][2] == x))
    {
      win = x;
    }
    if (((g.cases[0][2] == x) && (g.cases[1][1] == x)) && (g.cases[2][0] == x))
    {
      win = x;
    }
  }
  g.ended = (win != 0) || (freecase == 0);
  if (win == 1)
  {
    g.note = 1000;
  }
  else if (win == 2)
  {
    g.note = -1000;
  }
  else
  {
    g.note = 0;
  }
}

/* On applique un mouvement */
function apply_move_xy(x, y, g){
  var player = 2;
  if (g.firstToPlay)
  {
    player = 1;
  }
  g.cases[x][y] = player;
  g.firstToPlay = !g.firstToPlay;
}

function apply_move(m, g){
  apply_move_xy(m.x, m.y, g);
}

function cancel_move_xy(x, y, g){
  g.cases[x][y] = 0;
  g.firstToPlay = !g.firstToPlay;
  g.ended = 0;
}

function can_move_xy(x, y, g){
  return g.cases[x][y] == 0;
}

function minmax(g){
  eval_(g);
  if (g.ended)
  {
    return g.note;
  }
  var maxNote = -10000;
  if (!g.firstToPlay)
  {
    maxNote = 10000;
  }
  for (var x = 0 ; x <= 2; x++)
  {
    for (var y = 0 ; y <= 2; y++)
    {
      if (can_move_xy(x, y, g))
      {
        apply_move_xy(x, y, g);
        var currentNote = minmax(g);
        cancel_move_xy(x, y, g);
        if ((currentNote > maxNote) == g.firstToPlay)
        {
          maxNote = currentNote;
        }
      }
    }
  }
  return maxNote;
}

function play(g){
  var minMove = {
                   x : 0,
                   y : 0
  };
  var minNote = 10000;
  for (var x = 0 ; x <= 2; x++)
  {
    for (var y = 0 ; y <= 2; y++)
    {
      if (can_move_xy(x, y, g))
      {
        apply_move_xy(x, y, g);
        var currentNote = minmax(g);
        util.print(x);
        util.print(", ");
        util.print(y);
        util.print(", ");
        util.print(currentNote);
        util.print("\n");
        cancel_move_xy(x, y, g);
        if (currentNote < minNote)
        {
          minNote = currentNote;
          minMove.x = x;
          minMove.y = y;
        }
      }
    }
  }
  var bg = minMove.x;
  util.print(bg);
  var bh = minMove.y;
  util.print(bh);
  util.print("\n");
  return minMove;
}

function init(){
  var bj = 3;
  var cases = new Array(bj);
  for (var i = 0 ; i <= bj - 1; i++)
  {
    var bi = 3;
    var tab = new Array(bi);
    for (var j = 0 ; j <= bi - 1; j++)
    {
      tab[j] = 0;
    }
    cases[i] = tab;
  }
  var out_ = {
                cases : cases,
                firstToPlay : 1,
                note : 0,
                ended : 0
  };
  return out_;
}

for (var i = 0 ; i <= 1; i++)
{
  var state = init();
  while (!state.ended)
  {
    print_state(state);
    apply_move(play(state), state);
    eval_(state);
    print_state(state);
    if (!state.ended)
    {
      apply_move(play(state), state);
      eval_(state);
    }
  }
  print_state(state);
  var bk = state.note;
  util.print(bk);
  util.print("\n");
}



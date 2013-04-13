
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





function can_open_right(state, x, y){
  return (x < (state.sizeX - 1)) && state.cases[x + 1][y].free;
}

function can_open_left(state, x, y){
  return (x > 0) && state.cases[x - 1][y].free;
}

function can_open_bottom(state, x, y){
  return (y < (state.sizeY - 1)) && state.cases[x][y + 1].free;
}

function can_open_top(state, x, y){
  return (y > 0) && state.cases[x][y - 1].free;
}

function open_left(state, x, y){
  state.cases[x - 1][y].right = 0;
  state.cases[x][y].left = 0;
  state.cases[x - 1][y].free = 0;
  state.cases[x][y].free = 0;
}

function open_right(state, x, y){
  state.cases[x][y].right = 0;
  state.cases[x + 1][y].left = 0;
  state.cases[x][y].free = 0;
  state.cases[x + 1][y].free = 0;
}

function open_top(state, x, y){
  state.cases[x][y - 1].bottom = 0;
  state.cases[x][y].top = 0;
  state.cases[x][y - 1].free = 0;
  state.cases[x][y].free = 0;
}

function open_bottom(state, x, y){
  state.cases[x][y + 1].top = 0;
  state.cases[x][y].bottom = 0;
  state.cases[x][y + 1].free = 0;
  state.cases[x][y].free = 0;
}

function init(x, y){
  var cases = new Array(x);
  for (var i = 0 ; i <= x - 1; i++)
  {
    var cases_x = new Array(y);
    for (var j = 0 ; j <= y - 1; j++)
    {
      var reco = {
                    left : 1,
                    right : 1,
                    top : 1,
                    bottom : 1,
                    free : 1
      };
      cases_x[j] = reco;
    }
    cases[i] = cases_x;
  }
  var out_ = {
                sizeX : x,
                sizeY : y,
                cases : cases
  };
  return out_;
}

function print_lab(l){
  for (var x = 0 ; x <= l.sizeX - 1; x++)
  {
    util.print("__");
  }
  util.print("\n");
  for (var y = 0 ; y <= l.sizeY - 1; y++)
  {
    for (var x = 0 ; x <= l.sizeX - 1; x++)
    {
      if (l.cases[x][y].left)
      {
        if (l.cases[x][y].bottom)
        {
          util.print("|_");
        }
        else
        {
          util.print("| ");
        }
      }
      else if (l.cases[x][y].bottom)
      {
        util.print("__");
      }
      else
      {
        util.print("  ");
      }
    }
    util.print("|\n");
  }
  util.print("\n");
}

function gen(lab, x, y){
  var g = 4;
  var order = new Array(g);
  for (var i = 0 ; i <= g - 1; i++)
  {
    order[i] = i;
  }
  for (var i = 0 ; i <= 2; i++)
  {
    var j = (Math.floor(Math.random() * (4 -
i)));
    var k = order[i];
    order[i] = order[j];
    order[j] = k;
  }
  for (var i = 0 ; i <= 3; i++)
  {
    if ((0 == order[i]) && can_open_left(lab, x, y))
    {
      open_left(lab, x, y);
      gen(lab, x - 1, y);
    }
    if ((1 == order[i]) && can_open_right(lab, x, y))
    {
      open_right(lab, x, y);
      gen(lab, x + 1, y);
    }
    if ((2 == order[i]) && can_open_top(lab, x, y))
    {
      open_top(lab, x, y);
      gen(lab, x, y - 1);
    }
    if ((3 == order[i]) && can_open_bottom(lab, x, y))
    {
      open_bottom(lab, x, y);
      gen(lab, x, y + 1);
    }
  }
}

var lab = init(10, 10);
gen(lab, 0, 0);
print_lab(lab);



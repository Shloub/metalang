
var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char_ = function(){
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
var read_int_ = function(){
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


function min2(a, b){
  if (a < b)
    return a;
  return b;
}

function min3(a, b, c){
  return min2(min2(a, b), c);
}

function min4(a, b, c, d){
  return min3(min2(a, b), c, d);
}

function read_int(){
  var out_ = 0;
  out_=read_int_();
  stdinsep();
  return out_;
}

function read_char_line(n){
  var tab = new Array(n);
  for (var i = 0 ; i <= n - 1; i++)
  {
    var t = '_';
    t=read_char_();
    tab[i] = t;
  }
  stdinsep();
  return tab;
}

function read_char_matrix(x, y){
  var tab = new Array(y);
  for (var z = 0 ; z <= y - 1; z++)
    tab[z] = read_char_line(x);
  return tab;
}

function pathfind_aux(cache, tab, x, y, posX, posY){
  if (posX == x - 1 && posY == y - 1)
    return 0;
  else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
    return x * y * 10;
  else if (tab[posY][posX] == '#')
    return x * y * 10;
  else if (cache[posY][posX] != -1)
    return cache[posY][posX];
  else
  {
    cache[posY][posX] = x * y * 10;
    var val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
    var val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
    var val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
    var val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
    var out_ = 1 + min4(val1, val2, val3, val4);
    cache[posY][posX] = out_;
    return out_;
  }
}

function pathfind(tab, x, y){
  var cache = new Array(y);
  for (var i = 0 ; i <= y - 1; i++)
  {
    var tmp = new Array(x);
    for (var j = 0 ; j <= x - 1; j++)
    {
      var e = tab[i][j];
      util.print(e);
      tmp[j] = -1;
    }
    util.print("\n");
    cache[i] = tmp;
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}

var x = read_int();
var y = read_int();
util.print(x, " ", y, "\n");
var tab = read_char_matrix(x, y);
var result = pathfind(tab, x, y);
util.print(result);


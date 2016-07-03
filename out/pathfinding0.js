var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
function read_char_(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
function stdinsep(){
    if (current_char == null) current_char = read_char0();
    while (current_char.match(/[\n\t\s]/g))
        current_char = read_char0();
}
function read_int_(){
  if (current_char == null) current_char = read_char0();
  var sign = 1;
  if (current_char == '-'){
     current_char = read_char0();
     sign = -1;
  }
  var out = 0;
  while (true){
    if (current_char.match(/[0-9]/g)){
      out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
      current_char = read_char0();
    }else{
      return out * sign;
    }
  }
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
        var out0 = 1 + Math.min(val1, val2, val3, val4);
        cache[posY][posX] = out0;
        return out0;
    }
}

function pathfind(tab, x, y){
    var cache = new Array(y);
    for (var i = 0; i < y; i++)
    {
        var tmp = new Array(x);
        for (var j = 0; j < x; j++)
        {
            util.print(tab[i][j]);
            tmp[j] = -1;
        }
        util.print("\n");
        cache[i] = tmp;
    }
    return pathfind_aux(cache, tab, x, y, 0, 0);
}

var x = read_int_();
stdinsep();
var y = read_int_();
stdinsep();
util.print(x, " ", y, "\n");
var e = new Array(y);
for (var f = 0; f < y; f++)
{
    var g = new Array(x);
    for (var h = 0; h < x; h++)
    {
        g[h] = read_char_();
    }
    stdinsep();
    e[f] = g;
}
var tab = e;
var result = pathfind(tab, x, y);
util.print(result);


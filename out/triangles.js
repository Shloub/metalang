
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


/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
*/
function find0(len, tab, cache, x, y){
  /*
	Cette fonction est récursive
	*/
  if (y == len - 1)
    return tab[y][x];
  else if (x > y)
    return 100000;
  else if (cache[y][x] != 0)
    return cache[y][x];
  var result = 0;
  var out0 = find0(len, tab, cache, x, y + 1);
  var out1 = find0(len, tab, cache, x + 1, y + 1);
  if (out0 < out1)
    result = out0 + tab[y][x];
  else
    result = out1 + tab[y][x];
  cache[y][y] = result;
  return result;
}

function find(len, tab){
  var tab2 = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
  {
    var a = i + 1;
    var tab3 = new Array(a);
    for (var j = 0 ; j <= a - 1; j++)
      tab3[j] = 0;
    tab2[i] = tab3;
  }
  return find0(len, tab, tab2, 0, 0);
}

var len = 0;
len=read_int();
stdinsep();
var tab = new Array(len);
for (var i = 0 ; i <= len - 1; i++)
{
  var b = i + 1;
  var tab2 = new Array(b);
  for (var j = 0 ; j <= b - 1; j++)
  {
    var tmp = 0;
    tmp=read_int();
    stdinsep();
    tab2[j] = tmp;
  }
  tab[i] = tab2;
}
var c = find(len, tab);
util.print(c);
for (var k = 0 ; k <= len - 1; k++)
{
  for (var l = 0 ; l <= k; l++)
  {
    var d = tab[k][l];
    util.print(d);
  }
  util.print("\n");
}



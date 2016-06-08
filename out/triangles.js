var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
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
/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
*/

function find0(len, tab, cache, x, y) {
    /*
	Cette fonction est récursive
	*/
    if (y == len - 1)
        return tab[y][x];
    else
        if (x > y)
            return -10000;
        else
            if (cache[y][x] != 0)
                return cache[y][x];
    var result = 0;
    var out0 = find0(len, tab, cache, x, y + 1);
    var out1 = find0(len, tab, cache, x + 1, y + 1);
    if (out0 > out1)
        result = out0 + tab[y][x];
    else
        result = out1 + tab[y][x];
    cache[y][x] = result;
    return result;
}


function find(len, tab) {
    var tab2 = new Array(len);
    for (var i = 0; i < len; i += 1)
    {
        var tab3 = new Array(i + 1);
        for (var j = 0; j <= i; j += 1)
            tab3[j] = 0;
        tab2[i] = tab3;
    }
    return find0(len, tab, tab2, 0, 0);
}

var len = 0;
len = read_int_();
stdinsep();
var tab = new Array(len);
for (var i = 0; i < len; i += 1)
{
    var tab2 = new Array(i + 1);
    for (var j = 0; j <= i; j += 1)
    {
        var tmp = 0;
        tmp = read_int_();
        stdinsep();
        tab2[j] = tmp;
    }
    tab[i] = tab2;
}
util.print(find(len, tab), "\n");
for (var k = 0; k < len; k += 1)
{
    for (var l = 0; l <= k; l += 1)
        util.print(tab[k][l], " ");
    util.print("\n");
}


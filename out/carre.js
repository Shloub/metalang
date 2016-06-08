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

var x = read_int_();
stdinsep();
var y = read_int_();
stdinsep();
var tab = new Array(y);
for (var d = 0; d < y; d += 1)
{
    var e = new Array(x);
    for (var f = 0; f < x; f += 1)
    {
        e[f] = read_int_();
        stdinsep();
    }
    tab[d] = e;
}
for (var ix = 1; ix < x; ix += 1)
    for (var iy = 1; iy < y; iy += 1)
        if (tab[iy][ix] == 1)
            tab[iy][ix] = Math.min(tab[iy][ix - 1], tab[iy - 1][ix], tab[iy - 1][ix - 1]) + 1;
for (var jy = 0; jy < y; jy += 1)
{
    for (var jx = 0; jx < x; jx += 1)
        util.print(tab[jy][jx], " ");
    util.print("\n");
}


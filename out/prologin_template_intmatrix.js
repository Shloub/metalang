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
function programme_candidat(tableau, x, y){
  var out0 = 0;
  for (var i = 0 ; i <= y - 1; i++)
    for (var j = 0 ; j <= x - 1; j++)
      out0 += tableau[i][j] * (i * 2 + j);
  return out0;
}

f=read_int_();
stdinsep();
var taille_x = f;
h=read_int_();
stdinsep();
var taille_y = h;
var l = new Array(taille_y);
for (var m = 0 ; m <= taille_y - 1; m++)
{
  var o = new Array(taille_x);
  for (var p = 0 ; p <= taille_x - 1; p++)
  {
    q=read_int_();
    stdinsep();
    o[p] = q;
  }
  l[m] = o;
}
var tableau = l;
util.print(programme_candidat(tableau, taille_x, taille_y), "\n");


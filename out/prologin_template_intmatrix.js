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
function read_int_matrix(x, y){
  var tab = new Array(y);
  for (var z = 0 ; z <= y - 1; z++)
  {
    var b = new Array(x);
    for (var c = 0 ; c <= x - 1; c++)
    {
      d=read_int_();
      stdinsep();
      b[c] = d;
    }
    tab[z] = b;
  }
  return tab;
}

function programme_candidat(tableau, x, y){
  var out_ = 0;
  for (var i = 0 ; i <= y - 1; i++)
    for (var j = 0 ; j <= x - 1; j++)
      out_ += tableau[i][j] * (i * 2 + j);
  return out_;
}

f=read_int_();
stdinsep();
var taille_x = f;
h=read_int_();
stdinsep();
var taille_y = h;
var tableau = read_int_matrix(taille_x, taille_y);
util.print(programme_candidat(tableau, taille_x, taille_y), "\n");


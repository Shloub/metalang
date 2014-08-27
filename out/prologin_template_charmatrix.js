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
function read_char_matrix(x, y){
  var tab = new Array(y);
  for (var z = 0 ; z <= y - 1; z++)
  {
    var b = new Array(x);
    for (var c = 0 ; c <= x - 1; c++)
    {
      d=read_char_();
      b[c] = d;
    }
    stdinsep();
    var a = b;
    tab[z] = a;
  }
  return tab;
}

function programme_candidat(tableau, taille_x, taille_y){
  var out_ = 0;
  for (var i = 0 ; i <= taille_y - 1; i++)
  {
    for (var j = 0 ; j <= taille_x - 1; j++)
    {
      out_ += tableau[i][j].charCodeAt(0) * (i + j * 2);
      util.print(tableau[i][j]);
    }
    util.print("--\n");
  }
  return out_;
}

f=read_int_();
stdinsep();
var taille_x = f;
h=read_int_();
stdinsep();
var taille_y = h;
var tableau = read_char_matrix(taille_x, taille_y);
util.print(programme_candidat(tableau, taille_x, taille_y), "\n");


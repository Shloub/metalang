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
function programme_candidat(tableau, taille){
  var out_ = 0;
  for (var i = 0 ; i <= taille - 1; i++)
  {
    out_ += tableau[i].charCodeAt(0) * i;
    util.print(tableau[i]);
  }
  util.print("--\n");
  return out_;
}

b=read_int_();
stdinsep();
var taille = b;
var d = new Array(taille);
for (var e = 0 ; e <= taille - 1; e++)
  d[e]=read_char_();
stdinsep();
var tableau = d;
util.print(programme_candidat(tableau, taille), "\n");


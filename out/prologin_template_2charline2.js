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
function programme_candidat(tableau1, taille1, tableau2, taille2){
  var out_ = 0;
  for (var i = 0 ; i <= taille1 - 1; i++)
  {
    out_ += tableau1[i].charCodeAt(0) * i;
    util.print(tableau1[i]);
  }
  util.print("--\n");
  for (var j = 0 ; j <= taille2 - 1; j++)
  {
    out_ += tableau2[j].charCodeAt(0) * j * 100;
    util.print(tableau2[j]);
  }
  util.print("--\n");
  return out_;
}

var b = 0;
b=read_int_();
stdinsep();
var a = b;
var taille1 = a;
var d = 0;
d=read_int_();
stdinsep();
var c = d;
var taille2 = c;
var f = new Array(taille1);
for (var g = 0 ; g <= taille1 - 1; g++)
{
  var h = '_';
  h=read_char_();
  f[g] = h;
}
stdinsep();
var e = f;
var tableau1 = e;
var l = new Array(taille2);
for (var m = 0 ; m <= taille2 - 1; m++)
{
  var o = '_';
  o=read_char_();
  l[m] = o;
}
stdinsep();
var k = l;
var tableau2 = k;
util.print(programme_candidat(tableau1, taille1, tableau2, taille2), "\n");


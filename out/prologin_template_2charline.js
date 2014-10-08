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
function programme_candidat(tableau1, taille1, tableau2, taille2){
  var out0 = 0;
  for (var i = 0 ; i <= taille1 - 1; i++)
  {
    out0 += tableau1[i].charCodeAt(0) * i;
    util.print(tableau1[i]);
  }
  util.print("--\n");
  for (var j = 0 ; j <= taille2 - 1; j++)
  {
    out0 += tableau2[j].charCodeAt(0) * j * 100;
    util.print(tableau2[j]);
  }
  util.print("--\n");
  return out0;
}

b=read_int_();
stdinsep();
var taille1 = b;
var d = new Array(taille1);
for (var e = 0 ; e <= taille1 - 1; e++)
  d[e]=read_char_();
stdinsep();
var tableau1 = d;
h=read_int_();
stdinsep();
var taille2 = h;
var l = new Array(taille2);
for (var m = 0 ; m <= taille2 - 1; m++)
  l[m]=read_char_();
stdinsep();
var tableau2 = l;
util.print(programme_candidat(tableau1, taille1, tableau2, taille2), "\n");


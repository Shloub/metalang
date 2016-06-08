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

function programme_candidat(tableau1, taille1, tableau2, taille2) {
    var out0 = 0;
    for (var i = 0; i < taille1; i += 1)
    {
        out0 += tableau1[i].charCodeAt(0) * i;
        util.print(tableau1[i]);
    }
    util.print("--\n");
    for (var j = 0; j < taille2; j += 1)
    {
        out0 += tableau2[j].charCodeAt(0) * j * 100;
        util.print(tableau2[j]);
    }
    util.print("--\n");
    return out0;
}

var taille1 = read_int_();
stdinsep();
var taille2 = read_int_();
stdinsep();
var tableau1 = new Array(taille1);
for (var a = 0; a < taille1; a += 1)
{
    tableau1[a] = read_char_();
}
stdinsep();
var tableau2 = new Array(taille2);
for (var b = 0; b < taille2; b += 1)
{
    tableau2[b] = read_char_();
}
stdinsep();
util.print(programme_candidat(tableau1, taille1, tableau2, taille2), "\n");


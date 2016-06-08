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

function devine0(nombre, tab, len) {
    var min0 = tab[0];
    var max0 = tab[1];
    for (var i = 2; i < len; i += 1)
    {
        if (tab[i] > max0 || tab[i] < min0)
            return false;
        if (tab[i] < nombre)
            min0 = tab[i];
        if (tab[i] > nombre)
            max0 = tab[i];
        if (tab[i] == nombre && len != i + 1)
            return false;
    }
    return true;
}

var nombre = read_int_();
stdinsep();
var len = read_int_();
stdinsep();
var tab = new Array(len);
for (var i = 0; i < len; i += 1)
{
    var tmp = read_int_();
    stdinsep();
    tab[i] = tmp;
}
if (devine0(nombre, tab, len))
    util.print("True");
else
    util.print("False");


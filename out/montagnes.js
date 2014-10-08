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
function montagnes0(tab, len){
  var max0 = 1;
  var j = 1;
  var i = len - 2;
  while (i >= 0)
  {
    var x = tab[i];
    while (j >= 0 && x > tab[len - j])
      j --;
    j ++;
    tab[len - j] = x;
    if (j > max0)
      max0 = j;
    i --;
  }
  return max0;
}

var len = 0;
len=read_int_();
stdinsep();
var tab = new Array(len);
for (var i = 0 ; i <= len - 1; i++)
{
  var x = 0;
  x=read_int_();
  stdinsep();
  tab[i] = x;
}
util.print(montagnes0(tab, len));


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

function nth(tab, tofind, len){
    var out0 = 0;
    for (var i = 0; i < len; i++)
        if (tab[i] == tofind)
            out0++;
    return out0;
}
var len = 0;
len = read_int_();
stdinsep();
var tofind = '\x00';
tofind = read_char_();
stdinsep();
var tab = new Array(len);
for (var i = 0; i < len; i++)
{
    var tmp = '\x00';
    tmp = read_char_();
    tab[i] = tmp;
}
var result = nth(tab, tofind, len);
util.print(result);


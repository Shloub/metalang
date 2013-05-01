
var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char = function(){
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
var read_int = function(){
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


function montagnes_(tab, len){
  var max_ = 1;
  var j = 1;
  var i = len - 2;
  while (i >= 0)
  {
    var x = tab[i];
    while (j >= 0 && x > tab[len - j])
      j = j - 1;
    j = j + 1;
    tab[len - j] = x;
    if (j > max_)
      max_ = j;
    i = i - 1;
  }
  return max_;
}

var len = 0;
len=read_int();
stdinsep();
var tab = new Array(len);
for (var i = 0 ; i <= len - 1; i++)
{
  var x = 0;
  x=read_int();
  stdinsep();
  tab[i] = x;
}
var g = montagnes_(tab, len);
util.print(g);



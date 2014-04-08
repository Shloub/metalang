
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


function periode(restes, len, a, b){
  while (a != 0)
  {
    var chiffre = ~~(a / b);
    var reste = ~~(a % b);
    for (var i = 0 ; i <= len - 1; i++)
      if (restes[i] == reste)
      return len - i;
    restes[len] = reste;
    len ++;
    a = reste * 10;
  }
  return 0;
}

var c = 1000;
var t = new Array(c);
for (var j = 0 ; j <= c - 1; j++)
  t[j] = 0;
var m = 0;
var mi = 0;
for (var i = 1 ; i <= 1000; i++)
{
  var p = periode(t, 0, 1, i);
  if (p > m)
  {
    mi = i;
    m = p;
  }
}
util.print(mi, "\n", m, "\n");



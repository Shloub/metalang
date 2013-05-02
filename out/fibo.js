
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


/*
La suite de fibonaci
*/
function fibo_(a, b, i){
  var out_ = 0;
  var a2 = a;
  var b2 = b;
  for (var j = 0 ; j <= i + 1; j++)
  {
    out_ += a2;
    var tmp = b2;
    b2 += a2;
    a2 = tmp;
  }
  return out_;
}

var a = 0;
var b = 0;
var i = 0;
a=read_int();
stdinsep();
b=read_int();
stdinsep();
i=read_int();
var h = fibo_(a, b, i);
util.print(h);



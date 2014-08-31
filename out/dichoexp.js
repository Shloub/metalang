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
function exp_(a, b){
  if (b == 0)
    return 1;
  if ((~~(b % 2)) == 0)
  {
    var o = exp_(a, ~~(b / 2));
    return o * o;
  }
  else
    return a * exp_(a, b - 1);
}

var a = 0;
var b = 0;
a=read_int_();
stdinsep();
b=read_int_();
util.print(exp_(a, b));


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

bar_=read_int_();
stdinsep();
f=read_int_();
stdinsep();
g=read_int_();
stdinsep();
var i = {
  tuple_int_int_field_0 : f,
  tuple_int_int_field_1 : g
};
var t = {
  foo : i,
  bar : bar_
};
var h = t.foo;
var a = h.tuple_int_int_field_0;
var b = h.tuple_int_int_field_1;
util.print(a, " ", b, " ", t.bar, "\n");


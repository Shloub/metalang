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

var bar_ = read_int_();
stdinsep();
var c = read_int_();
stdinsep();
var d = read_int_();
stdinsep();
var e = {
    "tuple_int_int_field_0":c,
    "tuple_int_int_field_1":d};
var t = {
    "foo":e,
    "bar":bar_};
var f = t["foo"];
var a = f["tuple_int_int_field_0"];
var b = f["tuple_int_int_field_1"];
util.print(a, " ", b, " ", t["bar"], "\n");


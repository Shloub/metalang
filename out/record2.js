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

function mktoto(v1) {
    var t = {
      foo : v1,
      bar : 0,
      blah : 0
    };
    return t;
}


function result(t) {
    t.blah++;
    return t.foo + t.blah * t.bar + t.bar * t.foo;
}

var t = mktoto(4);
t.bar=read_int_();
stdinsep();
t.blah=read_int_();
util.print(result(t));


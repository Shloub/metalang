
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



function mktoto(v1){
  var t = {
             foo : v1,
             bar : v1,
             blah : v1
  };
  return t;
}

function result(t_, t2_){
  var t = t_;
  var t2 = t2_;
  var t3 = {
              foo : 0,
              bar : 0,
              blah : 0
  };
  t3 = t2;
  t = t2;
  t2 = t3;
  t.blah = t.blah + 1;
  var len = 1;
  var cache0 = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
    cache0[i] = -i;
  var cache1 = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
    cache1[i] = i;
  var cache2 = cache0;
  cache0 = cache1;
  cache2 = cache0;
  return t.foo + t.blah * t.bar + t.bar * t.foo;
}

var t = mktoto(4);
var t2 = mktoto(5);
t.bar=read_int();
stdinsep();
t.blah=read_int();
stdinsep();
t2.bar=read_int();
stdinsep();
t.blah=read_int();
var m = result(t, t2);
util.print(m);
var n = t.blah;
util.print(n);



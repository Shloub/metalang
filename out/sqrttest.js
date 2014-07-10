
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


function isqrt(c){
  return Math.floor(Math.sqrt(c));
}

var b = 4;
var a = Math.floor(Math.sqrt(b));
util.print(a, " ");
var e = 16;
var d = Math.floor(Math.sqrt(e));
util.print(d, " ");
var g = 20;
var f = Math.floor(Math.sqrt(g));
util.print(f, " ");
var i = 1000;
var h = Math.floor(Math.sqrt(i));
util.print(h, " ");
var k = 500;
var j = Math.floor(Math.sqrt(k));
util.print(j, " ");
var m = 10;
var l = Math.floor(Math.sqrt(m));
util.print(l, " ");




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


function min3_(a, b, c){
  return Math.min(a, b, c);
}

var e = 2;
var f = 3;
var g = 4;
var d = Math.min(e, f, g);
util.print(d, " ");
var i = 2;
var j = 4;
var k = 3;
var h = Math.min(i, j, k);
util.print(h, " ");
var m = 3;
var n = 2;
var o = 4;
var l = Math.min(m, n, o);
util.print(l, " ");
var q = 3;
var r = 4;
var s = 2;
var p = Math.min(q, r, s);
util.print(p, " ");
var u = 4;
var v = 2;
var w = 3;
var t = Math.min(u, v, w);
util.print(t, " ");
var y = 4;
var z = 3;
var ba = 2;
var x = Math.min(y, z, ba);
util.print(x, "\n");



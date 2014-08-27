var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
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
}/*
  Ce test a été généré par Metalang.
*/
function result(len, tab){
  var tab2 = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
    tab2[i] = 0;
  for (var i1 = 0 ; i1 <= len - 1; i1++)
    tab2[tab[i1]] = 1;
  for (var i2 = 0 ; i2 <= len - 1; i2++)
    if (!tab2[i2])
    return i2;
  return -1;
}

b=read_int_();
stdinsep();
var len = b;
util.print(len, "\n");
var d = new Array(len);
for (var e = 0 ; e <= len - 1; e++)
{
  d[e]=read_int_();
  stdinsep();
}
var tab = d;
util.print(result(len, tab));


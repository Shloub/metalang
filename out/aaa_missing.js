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
}
function read_int(){
  var out_ = 0;
  out_=read_int_();
  stdinsep();
  return out_;
}

function read_int_line(n){
  var tab = new Array(n);
  for (var i = 0 ; i <= n - 1; i++)
  {
    var t = 0;
    t=read_int_();
    stdinsep();
    tab[i] = t;
  }
  return tab;
}

/*
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

var len = read_int();
util.print(len, "\n");
var tab = read_int_line(len);
util.print(result(len, tab));


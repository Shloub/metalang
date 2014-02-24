
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


function read_int_line(n){
  var tab = new Array(n);
  for (var i = 0 ; i <= n - 1; i++)
  {
    var t = 0;
    t=read_int();
    stdinsep();
    tab[i] = t;
  }
  return tab;
}

function read_int_matrix(x, y){
  var tab = new Array(y);
  for (var z = 0 ; z <= y - 1; z++)
  {
    var out_ = read_int_line(x);
    stdinsep();
    tab[z] = out_;
  }
  return tab;
}

var l0 = read_int_line(1);
var len = l0[0];
util.print(len, "=len\n");
var tab1 = read_int_line(len);
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(i, "=>");
  var a = tab1[i];
  util.print(a, "\n");
}
l0 = read_int_line(1);
len = l0[0];
var tab2 = read_int_matrix(len, len - 1);
for (var i = 0 ; i <= len - 2; i++)
{
  for (var j = 0 ; j <= len - 1; j++)
  {
    var b = tab2[i][j];
    util.print(b, " ");
  }
  util.print("\n");
}



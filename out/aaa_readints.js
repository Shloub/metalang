
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

function read_int_matrix(x, y){
  var tab = new Array(y);
  for (var z = 0 ; z <= y - 1; z++)
  {
    var b = x;
    var c = new Array(b);
    for (var d = 0 ; d <= b - 1; d++)
    {
      var e = 0;
      e=read_int_();
      stdinsep();
      c[d] = e;
    }
    var a = c;
    tab[z] = a;
  }
  return tab;
}

var g = 0;
g=read_int_();
stdinsep();
var f = g;
var len = f;
util.print(len, "=len\n");
var k = len;
var l = new Array(k);
for (var m = 0 ; m <= k - 1; m++)
{
  var o = 0;
  o=read_int_();
  stdinsep();
  l[m] = o;
}
var h = l;
var tab1 = h;
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(i, "=>", tab1[i], "\n");
}
var q = 0;
q=read_int_();
stdinsep();
var p = q;
len = p;
var tab2 = read_int_matrix(len, len - 1);
for (var i = 0 ; i <= len - 2; i++)
{
  for (var j = 0 ; j <= len - 1; j++)
  {
    util.print(tab2[i][j], " ");
  }
  util.print("\n");
}



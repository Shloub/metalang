
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

function read_char_line(n){
  var tab = new Array(n);
  for (var i = 0 ; i <= n - 1; i++)
  {
    var t = '_';
    t=read_char_();
    tab[i] = t;
  }
  stdinsep();
  return tab;
}

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
var b = 0;
b=read_int_();
stdinsep();
var a = b;
var len = a;
util.print(len, "=len\n");
var e = len;
var f = new Array(e);
for (var g = 0 ; g <= e - 1; g++)
{
  var h = 0;
  h=read_int_();
  stdinsep();
  f[g] = h;
}
var d = f;
var tab = d;
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(i, "=>", tab[i], " ");
}
util.print("\n");
var l = len;
var m = new Array(l);
for (var o = 0 ; o <= l - 1; o++)
{
  var p = 0;
  p=read_int_();
  stdinsep();
  m[o] = p;
}
var k = m;
var tab2 = k;
for (var i_ = 0 ; i_ <= len - 1; i_++)
{
  util.print(i_, "==>", tab2[i_], " ");
}
var r = 0;
r=read_int_();
stdinsep();
var q = r;
var strlen = q;
util.print(strlen, "=strlen\n");
var u = strlen;
var v = new Array(u);
for (var w = 0 ; w <= u - 1; w++)
{
  var x = '_';
  x=read_char_();
  v[w] = x;
}
stdinsep();
var s = v;
var tab4 = s;
for (var i3 = 0 ; i3 <= strlen - 1; i3++)
{
  var tmpc = tab4[i3];
  var c = tmpc.charCodeAt(0);
  util.print(tmpc, ":", c, " ");
  if (tmpc != ' ')
    c = ~~(((c - 'a'.charCodeAt(0)) + 13) % 26) + 'a'.charCodeAt(0);
  tab4[i3] = String.fromCharCode(c);
}
for (var j = 0 ; j <= strlen - 1; j++)
  util.print(tab4[j]);



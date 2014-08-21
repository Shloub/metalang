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
}/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
var b = 0;
b=read_int_();
stdinsep();
var a = b;
var len = a;
util.print(len, "=len\n");
var e = new Array(len);
for (var f = 0 ; f <= len - 1; f++)
{
  var g = 0;
  g=read_int_();
  stdinsep();
  e[f] = g;
}
var d = e;
var tab = d;
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(i, "=>", tab[i], " ");
}
util.print("\n");
var k = new Array(len);
for (var l = 0 ; l <= len - 1; l++)
{
  var m = 0;
  m=read_int_();
  stdinsep();
  k[l] = m;
}
var h = k;
var tab2 = h;
for (var i_ = 0 ; i_ <= len - 1; i_++)
{
  util.print(i_, "==>", tab2[i_], " ");
}
var p = 0;
p=read_int_();
stdinsep();
var o = p;
var strlen = o;
util.print(strlen, "=strlen\n");
var r = new Array(strlen);
for (var s = 0 ; s <= strlen - 1; s++)
{
  var u = '_';
  u=read_char_();
  r[s] = u;
}
stdinsep();
var q = r;
var tab4 = q;
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


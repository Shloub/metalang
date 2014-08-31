var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
function read_char_(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
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
}/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
b=read_int_();
stdinsep();
var len = b;
util.print(len, "=len\n");
var e = new Array(len);
for (var f = 0 ; f <= len - 1; f++)
{
  e[f]=read_int_();
  stdinsep();
}
var tab = e;
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(i, "=>", tab[i], " ");
}
util.print("\n");
var k = new Array(len);
for (var l = 0 ; l <= len - 1; l++)
{
  k[l]=read_int_();
  stdinsep();
}
var tab2 = k;
for (var i_ = 0 ; i_ <= len - 1; i_++)
{
  util.print(i_, "==>", tab2[i_], " ");
}
p=read_int_();
stdinsep();
var strlen = p;
util.print(strlen, "=strlen\n");
var r = new Array(strlen);
for (var s = 0 ; s <= strlen - 1; s++)
  r[s]=read_char_();
stdinsep();
var tab4 = r;
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


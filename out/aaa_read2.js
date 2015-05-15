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
len=read_int_();
stdinsep();
util.print(len, "=len\n");
var tab = new Array(len);
for (var a = 0 ; a <= len - 1; a++)
{
  tab[a]=read_int_();
  stdinsep();
}
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(i, "=>", tab[i], " ");
}
util.print("\n");
var tab2 = new Array(len);
for (var b = 0 ; b <= len - 1; b++)
{
  tab2[b]=read_int_();
  stdinsep();
}
for (var i_ = 0 ; i_ <= len - 1; i_++)
{
  util.print(i_, "==>", tab2[i_], " ");
}
strlen=read_int_();
stdinsep();
util.print(strlen, "=strlen\n");
var tab4 = new Array(strlen);
for (var d = 0 ; d <= strlen - 1; d++)
  tab4[d]=read_char_();
stdinsep();
for (var i3 = 0 ; i3 <= strlen - 1; i3++)
{
  var tmpc = tab4[i3];
  var c = tmpc.charCodeAt(0);
  util.print(tmpc, ":", c, " ");
  if (tmpc != ' ')
    c = ~~((c - 'a'.charCodeAt(0) + 13) % 26) + 'a'.charCodeAt(0);
  tab4[i3] = String.fromCharCode(c);
}
for (var j = 0 ; j <= strlen - 1; j++)
  util.print(tab4[j]);


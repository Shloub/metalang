
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




/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
var len = 0;
len=read_int();
stdinsep();
util.print(len, "=len\n");
var tab = new Array(len);
for (var i = 0 ; i <= len - 1; i++)
{
  var tmpi1 = 0;
  tmpi1=read_int();
  stdinsep();
  util.print(i, "=>", tmpi1, " ");
  tab[i] = tmpi1;
}
util.print("\n");
var tab2 = new Array(len);
for (var i_ = 0 ; i_ <= len - 1; i_++)
{
  var tmpi2 = 0;
  tmpi2=read_int();
  stdinsep();
  util.print(i_, "==>", tmpi2, " ");
  tab2[i_] = tmpi2;
}
var strlen = 0;
strlen=read_int();
stdinsep();
util.print(strlen, "=strlen\n");
var tab4 = new Array(strlen);
for (var toto = 0 ; toto <= strlen - 1; toto++)
{
  var tmpc = '_';
  tmpc=read_char();
  var c = tmpc.charCodeAt(0);
  util.print(tmpc, ":", c, " ");
  if (tmpc != ' ')
    c = ((c - 'a'.charCodeAt(0)) + 13) % 26 + 'a'.charCodeAt(0);
  tab4[toto] = String.fromCharCode(c);
}
for (var j = 0 ; j <= strlen - 1; j++)
{
  var a = tab4[j];
  util.print(a);
}




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
    var t_ = 0;
    t_=read_int_();
    stdinsep();
    tab[i] = t_;
  }
  return tab;
}

function read_char_line(n){
  var tab = new Array(n);
  for (var i = 0 ; i <= n - 1; i++)
  {
    var t_ = '_';
    t_=read_char_();
    tab[i] = t_;
  }
  stdinsep();
  return tab;
}

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
var len = read_int();
util.print(len, "=len\n");
var tab = read_int_line(len);
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(i, "=>");
  var a = tab[i];
  util.print(a, " ");
}
util.print("\n");
var tab2 = read_int_line(len);
for (var i_ = 0 ; i_ <= len - 1; i_++)
{
  util.print(i_, "==>");
  var b = tab2[i_];
  util.print(b, " ");
}
var strlen = read_int();
util.print(strlen, "=strlen\n");
var tab4 = read_char_line(strlen);
for (var i3 = 0 ; i3 <= strlen - 1; i3++)
{
  var tmpc = tab4[i3];
  var c = tmpc.charCodeAt(0);
  util.print(tmpc, ":", c, " ");
  if (tmpc != ' ')
    c = ((c - 'a'.charCodeAt(0)) + 13) % 26 + 'a'.charCodeAt(0);
  tab4[i3] = String.fromCharCode(c);
}
for (var j = 0 ; j <= strlen - 1; j++)
{
  var d = tab4[j];
  util.print(d);
}



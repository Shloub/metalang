
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


/*
Ce test effectue un rot13 sur une chaine lue en entrée
*/
var strlen = 0;
strlen=read_int_();
stdinsep();
var tab4 = new Array(strlen);
for (var toto = 0 ; toto <= strlen - 1; toto++)
{
  var tmpc = '_';
  tmpc=read_char_();
  var c = tmpc.charCodeAt(0);
  if (tmpc != ' ')
    c = ~~(((c - 'a'.charCodeAt(0)) + 13) % 26) + 'a'.charCodeAt(0);
  tab4[toto] = String.fromCharCode(c);
}
for (var j = 0 ; j <= strlen - 1; j++)
  util.print(tab4[j]);



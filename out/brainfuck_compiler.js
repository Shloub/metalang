
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
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
var input = ' ';
var current_pos = 500;
var a = 1000;
var mem = new Array(a);
for (var i = 0 ; i <= a - 1; i++)
  mem[i] = 0;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
current_pos ++;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
while (mem[current_pos] != 0)
{
  mem[current_pos] = mem[current_pos] - 1;
  current_pos --;
  mem[current_pos] = mem[current_pos] + 1;
  util.print(String.fromCharCode(mem[current_pos]));
  current_pos ++;
}



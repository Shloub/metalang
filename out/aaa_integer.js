
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


var i = 0;
i --;
util.print(i, "\n");
i += 55;
util.print(i, "\n");
i *= 13;
util.print(i, "\n");
i = ~~(i / 2);
util.print(i, "\n");
i ++;
util.print(i, "\n");
i = ~~(i / 3);
util.print(i, "\n");
i --;
util.print(i, "\n");
/*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
util.print(~~(117 / 17), "\n", ~~(117 / -17), "\n", ~~(-117 / 17), "\n", ~~(-117 / -17), "\n", ~~(117 % 17), "\n", ~~(117 % -17), "\n", ~~(-117 % 17), "\n", ~~(-117 % -17), "\n");



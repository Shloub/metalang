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
var str = new Array(12);
for (var a = 0 ; a <= 12 - 1; a++)
{
  str[a]=read_char_();
}
stdinsep();
for (var i = 0 ; i <= 11; i++)
  util.print(str[i]);


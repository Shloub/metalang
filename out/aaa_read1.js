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
var c = new Array(12);
for (var d = 0 ; d <= 12 - 1; d++)
  c[d]=read_char_();
stdinsep();
var str = c;
for (var i = 0 ; i <= 11; i++)
  util.print(str[i]);


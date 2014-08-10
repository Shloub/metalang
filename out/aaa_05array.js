
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


function id(b){
  return b;
}

function g(t, index){
  t[index] = 0;
}

var c = 5;
var a = new Array(c);
for (var i = 0 ; i <= c - 1; i++)
{
  util.print(i);
  a[i] = (~~(i % 2)) == 0;
}
var d = a[0];
if (d)
  util.print("True");
else
  util.print("False");
util.print("\n");
g(id(a), 0);
var e = a[0];
if (e)
  util.print("True");
else
  util.print("False");
util.print("\n");



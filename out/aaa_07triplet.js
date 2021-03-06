var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    var buf = Buffer.alloc(1);
    fs.readSync(process.stdin.fd, buf, 0, 1)[0];
    return buf.toString();
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
}

for (var i = 1; i < 4; i++)
{
    var a = read_int_();
    stdinsep();
    var b = read_int_();
    stdinsep();
    var c = read_int_();
    stdinsep();
    util.print("a = ", a, " b = ", b, "c =", c, "\n");
}
var l = new Array(10);
for (var d = 0; d < 10; d++)
{
    l[d] = read_int_();
    stdinsep();
}
for (var j = 0; j < 10; j++)
    util.print(l[j], "\n");


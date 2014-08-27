var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
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
function read_int_matrix(x, y){
  var tab = new Array(y);
  for (var z = 0 ; z <= y - 1; z++)
  {
    var b = new Array(x);
    for (var c = 0 ; c <= x - 1; c++)
    {
      d=read_int_();
      stdinsep();
      b[c] = d;
    }
    var a = b;
    tab[z] = a;
  }
  return tab;
}

f=read_int_();
stdinsep();
var len = f;
util.print(len, "=len\n");
var h = new Array(len);
for (var k = 0 ; k <= len - 1; k++)
{
  l=read_int_();
  stdinsep();
  h[k] = l;
}
var tab1 = h;
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(i, "=>", tab1[i], "\n");
}
o=read_int_();
stdinsep();
len = o;
var tab2 = read_int_matrix(len, len - 1);
for (var i = 0 ; i <= len - 2; i++)
{
  for (var j = 0 ; j <= len - 1; j++)
  {
    util.print(tab2[i][j], " ");
  }
  util.print("\n");
}


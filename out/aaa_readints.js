var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
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
f=read_int_();
stdinsep();
var len = f;
util.print(len, "=len\n");
var h = new Array(len);
for (var k = 0 ; k <= len - 1; k++)
{
  h[k]=read_int_();
  stdinsep();
}
var tab1 = h;
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(i, "=>", tab1[i], "\n");
}
len=read_int_();
stdinsep();
var r = new Array(len - 1);
for (var s = 0 ; s <= len - 1 - 1; s++)
{
  var u = new Array(len);
  for (var v = 0 ; v <= len - 1; v++)
  {
    w=read_int_();
    stdinsep();
    u[v] = w;
  }
  r[s] = u;
}
var tab2 = r;
for (var i = 0 ; i <= len - 2; i++)
{
  for (var j = 0 ; j <= len - 1; j++)
  {
    util.print(tab2[i][j], " ");
  }
  util.print("\n");
}


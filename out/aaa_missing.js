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
}/*
  Ce test a été généré par Metalang.
*/
function result(len, tab){
  var tab2 = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
    tab2[i] = 0;
  for (var i1 = 0 ; i1 <= len - 1; i1++)
  {
    util.print(tab[i1], " ");
    tab2[tab[i1]] = 1;
  }
  util.print("\n");
  for (var i2 = 0 ; i2 <= len - 1; i2++)
    if (!tab2[i2])
    return i2;
  return -1;
}

len=read_int_();
stdinsep();
util.print(len, "\n");
var tab = new Array(len);
for (var e = 0 ; e <= len - 1; e++)
{
  tab[e]=read_int_();
  stdinsep();
}
util.print(result(len, tab), "\n");


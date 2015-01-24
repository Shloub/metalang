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
function find(n, m, x, y, dx, dy){
  if (x < 0 || x == 20 || y < 0 || y == 20)
    return -1;
  else if (n == 0)
    return 1;
  else
    return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);
}


var directions = new Array(8);
for (var i = 0 ; i <= 8 - 1; i++)
  if (i == 0)
{
  var bh = {
    tuple_int_int_field_0 : 0,
    tuple_int_int_field_1 : 1
  };
  directions[i] = bh;
}
else if (i == 1)
{
  var bg = {
    tuple_int_int_field_0 : 1,
    tuple_int_int_field_1 : 0
  };
  directions[i] = bg;
}
else if (i == 2)
{
  var bf = {
    tuple_int_int_field_0 : 0,
    tuple_int_int_field_1 : -1
  };
  directions[i] = bf;
}
else if (i == 3)
{
  var be = {
    tuple_int_int_field_0 : -1,
    tuple_int_int_field_1 : 0
  };
  directions[i] = be;
}
else if (i == 4)
{
  var bd = {
    tuple_int_int_field_0 : 1,
    tuple_int_int_field_1 : 1
  };
  directions[i] = bd;
}
else if (i == 5)
{
  var bc = {
    tuple_int_int_field_0 : 1,
    tuple_int_int_field_1 : -1
  };
  directions[i] = bc;
}
else if (i == 6)
{
  var bb = {
    tuple_int_int_field_0 : -1,
    tuple_int_int_field_1 : 1
  };
  directions[i] = bb;
}
else
{
  var ba = {
    tuple_int_int_field_0 : -1,
    tuple_int_int_field_1 : -1
  };
  directions[i] = ba;
}
var max0 = 0;
var h = 20;
var m = new Array(20);
for (var o = 0 ; o <= 20 - 1; o++)
{
  var s = new Array(h);
  for (var q = 0 ; q <= h - 1; q++)
  {
    r=read_int_();
    stdinsep();
    s[q] = r;
  }
  m[o] = s;
}
for (var j = 0 ; j <= 7; j++)
{
  var w = directions[j];
  var dx = w.tuple_int_int_field_0;
  var dy = w.tuple_int_int_field_1;
  for (var x = 0 ; x <= 19; x++)
    for (var y = 0 ; y <= 19; y++)
    {
      var v = find(4, m, x, y, dx, dy);
      var u = Math.max(max0, v);
      max0 = u;
  }
}
util.print(max0, "\n");


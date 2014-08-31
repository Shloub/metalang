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
function read_int_matrix(x, y){
  var tab = new Array(y);
  for (var z = 0 ; z <= y - 1; z++)
  {
    var d = new Array(x);
    for (var e = 0 ; e <= x - 1; e++)
    {
      f=read_int_();
      stdinsep();
      d[e] = f;
    }
    tab[z] = d;
  }
  return tab;
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
  var v = {
    tuple_int_int_field_0 : 0,
    tuple_int_int_field_1 : 1
  };
  directions[i] = v;
}
else if (i == 1)
{
  var u = {
    tuple_int_int_field_0 : 1,
    tuple_int_int_field_1 : 0
  };
  directions[i] = u;
}
else if (i == 2)
{
  var s = {
    tuple_int_int_field_0 : 0,
    tuple_int_int_field_1 : -1
  };
  directions[i] = s;
}
else if (i == 3)
{
  var r = {
    tuple_int_int_field_0 : -1,
    tuple_int_int_field_1 : 0
  };
  directions[i] = r;
}
else if (i == 4)
{
  var q = {
    tuple_int_int_field_0 : 1,
    tuple_int_int_field_1 : 1
  };
  directions[i] = q;
}
else if (i == 5)
{
  var p = {
    tuple_int_int_field_0 : 1,
    tuple_int_int_field_1 : -1
  };
  directions[i] = p;
}
else if (i == 6)
{
  var o = {
    tuple_int_int_field_0 : -1,
    tuple_int_int_field_1 : 1
  };
  directions[i] = o;
}
else
{
  var l = {
    tuple_int_int_field_0 : -1,
    tuple_int_int_field_1 : -1
  };
  directions[i] = l;
}
var max_ = 0;
var m = read_int_matrix(20, 20);
for (var j = 0 ; j <= 7; j++)
{
  var k = directions[j];
  var dx = k.tuple_int_int_field_0;
  var dy = k.tuple_int_int_field_1;
  for (var x = 0 ; x <= 19; x++)
    for (var y = 0 ; y <= 19; y++)
    {
      var h = find(4, m, x, y, dx, dy);
      var g = Math.max(max_, h);
      max_ = g;
  }
}
util.print(max_, "\n");


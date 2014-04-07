
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


function max2(a, b){
  if (a > b)
    return a;
  return b;
}

function read_int_line(n){
  var tab = new Array(n);
  for (var i = 0 ; i <= n - 1; i++)
  {
    var t = 0;
    t=read_int_();
    stdinsep();
    tab[i] = t;
  }
  return tab;
}

function read_int_matrix(x, y){
  var tab = new Array(y);
  for (var z = 0 ; z <= y - 1; z++)
  {
    stdinsep();
    tab[z] = read_int_line(x);
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


var c = 8;
var directions = new Array(c);
for (var i = 0 ; i <= c - 1; i++)
  if (i == 0)
{
  var p = {
             tuple_int_int_field_0 : 0,
             tuple_int_int_field_1 : 1
  };
  directions[i] = p;
}
else if (i == 1)
{
  var o = {
             tuple_int_int_field_0 : 1,
             tuple_int_int_field_1 : 0
  };
  directions[i] = o;
}
else if (i == 2)
{
  var l = {
             tuple_int_int_field_0 : 0,
             tuple_int_int_field_1 : -1
  };
  directions[i] = l;
}
else if (i == 3)
{
  var k = {
             tuple_int_int_field_0 : -1,
             tuple_int_int_field_1 : 0
  };
  directions[i] = k;
}
else if (i == 4)
{
  var h = {
             tuple_int_int_field_0 : 1,
             tuple_int_int_field_1 : 1
  };
  directions[i] = h;
}
else if (i == 5)
{
  var g = {
             tuple_int_int_field_0 : 1,
             tuple_int_int_field_1 : -1
  };
  directions[i] = g;
}
else if (i == 6)
{
  var f = {
             tuple_int_int_field_0 : -1,
             tuple_int_int_field_1 : 1
  };
  directions[i] = f;
}
else
{
  var e = {
             tuple_int_int_field_0 : -1,
             tuple_int_int_field_1 : -1
  };
  directions[i] = e;
}
var max_ = 0;
var m = read_int_matrix(20, 20);
for (var j = 0 ; j <= 7; j++)
{
  var d = directions[j];
  var dx = d.tuple_int_int_field_0;
  var dy = d.tuple_int_int_field_1;
  for (var x = 0 ; x <= 19; x++)
    for (var y = 0 ; y <= 19; y++)
      max_ = max2(max_, find(4, m, x, y, dx, dy));
}
util.print(max_, "\n");



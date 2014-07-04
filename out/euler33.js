
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
  return Math.max(a, b);
}

function min2(a, b){
  return Math.min(a, b);
}

function pgcd(a, b){
  var c = min2(a, b);
  var d = max2(a, b);
  var reste = ~~(d % c);
  if (reste == 0)
    return c;
  else
    return pgcd(c, reste);
}

var top = 1;
var bottom = 1;
for (var i = 1 ; i <= 9; i++)
  for (var j = 1 ; j <= 9; j++)
    for (var k = 1 ; k <= 9; k++)
      if (i != j && j != k)
{
  var a = i * 10 + j;
  var b = j * 10 + k;
  if (a * k == i * b)
  {
    util.print(a, "/", b, "\n");
    top *= a;
    bottom *= b;
  }
}
util.print(top, "/", bottom, "\n");
var p = pgcd(top, bottom);
util.print("pgcd=", p, "\n");
var e = ~~(bottom / p);
util.print(e, "\n");



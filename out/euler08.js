
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

var i = 1;
var g = 5;
var last = new Array(g);
for (var j = 0 ; j <= g - 1; j++)
{
  var c = '_';
  c=read_char_();
  var d = c.charCodeAt(0) - '0'.charCodeAt(0);
  i *= d;
  last[j] = d;
}
var max_ = i;
var index = 0;
var nskipdiv = 0;
for (var k = 1 ; k <= 995; k++)
{
  var e = '_';
  e=read_char_();
  var f = e.charCodeAt(0) - '0'.charCodeAt(0);
  if (f == 0)
  {
    i = 1;
    nskipdiv = 4;
  }
  else
  {
    i *= f;
    if (nskipdiv < 0)
      i = ~~(i / last[index]);
    nskipdiv --;
  }
  last[index] = f;
  index = ~~((index + 1) % 5);
  max_ = max2(max_, i);
}
util.print(max_, "\n");



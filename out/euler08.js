var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
function read_char_(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
var i = 1;
var last = new Array(5);
for (var j = 0 ; j <= 5 - 1; j++)
{
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
  max_ = Math.max(max_, i);
}
util.print(max_, "\n");


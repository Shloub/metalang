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

function dichofind(len, tab, tofind, a, b){
    if (a >= b - 1)
        return a;
    else
    {
        var c = ~~((a + b) / 2);
        if (tab[c] < tofind)
            return dichofind(len, tab, tofind, c, b);
        else
            return dichofind(len, tab, tofind, a, c);
    }
}
function process0(len, tab){
    var size = new Array(len);
    for (var j = 0; j < len; j++)
        if (j == 0)
            size[j] = 0;
        else
            size[j] = len * 2;
    for (var i = 0; i < len; i++)
    {
        var k = dichofind(len, size, tab[i], 0, len - 1);
        if (size[k + 1] > tab[i])
            size[k + 1] = tab[i];
    }
    for (var l = 0; l < len; l++)
        util.print(size[l], " ");
    for (var m = 0; m < len; m++)
    {
        var k = len - 1 - m;
        if (size[k] != len * 2)
            return k;
    }
    return 0;
}
var n = read_int_();
stdinsep();
for (var i = 1; i <= n; i++)
{
    var len = read_int_();
    stdinsep();
    var d = new Array(len);
    for (var e = 0; e < len; e++)
    {
        d[e] = read_int_();
        stdinsep();
    }
    util.print(process0(len, d), "\n");
}


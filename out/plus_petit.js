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
function go0(tab, a, b) {
    var m = ~~((a + b) / 2);
    if (a == m)
    {
        if (tab[a] == m)
          return b;
        else
          return a;
    }
    var i = a;
    var j = b;
    while (i < j)
    {
        var e = tab[i];
        if (e < m)
          i++;
        else
        {
            j --;
            tab[i] = tab[j];
            tab[j] = e;
        }
    }
    if (i < m)
      return go0(tab, a, m);
    else
      return go0(tab, m, b);
}


function plus_petit0(tab, len) {
    return go0(tab, 0, len);
}

var len = 0;
len=read_int_();
stdinsep();
var tab = new Array(len);
for (var i = 0 ; i < len; i++)
{
    var tmp = 0;
    tmp=read_int_();
    stdinsep();
    tab[i] = tmp;
}
util.print(plus_petit0(tab, len));


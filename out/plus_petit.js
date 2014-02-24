
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


function go(tab, a, b){
  var m = Math.floor((a + b) / 2);
  if (a == m)
    if (tab[a] == m)
    return b;
  else
    return a;
  var i = a;
  var j = b;
  while (i < j)
  {
    var e = tab[i];
    if (e < m)
      i ++;
    else
    {
      j --;
      tab[i] = tab[j];
      tab[j] = e;
    }
  }
  if (i < m)
    return go(tab, a, m);
  else
    return go(tab, m, b);
}

function plus_petit_(tab, len){
  return go(tab, 0, len);
}

var len = 0;
len=read_int_();
stdinsep();
var tab = new Array(len);
for (var i = 0 ; i <= len - 1; i++)
{
  var tmp = 0;
  tmp=read_int_();
  stdinsep();
  tab[i] = tmp;
}
var c = plus_petit_(tab, len);
util.print(c);



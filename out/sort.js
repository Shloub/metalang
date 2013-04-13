
var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char = function(){
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
var read_int = function(){
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


function sort_(tab, len){
  for (var i = 0 ; i <= len - 1; i++)
  {
    for (var j = i + 1 ; j <= len - 1; j++)
    {
      if (tab[i] > tab[j])
      {
        var tmp = tab[i];
        tab[i] = tab[j];
        tab[j] = tmp;
      }
    }
  }
}

var len = 2;
len=read_int();
stdinsep();
var tab = new Array(len);
for (var i = 0 ; i <= len - 1; i++)
{
  var tmp = 0;
  tmp=read_int();
  stdinsep();
  tab[i] = tmp;
}
sort_(tab, len);
for (var n = 0 ; n <= (tab.length) - 1; n++)
{
  util.print(tab[n]);
}



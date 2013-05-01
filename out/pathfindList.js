
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


function pathfind_aux(cache, tab, len, pos){
  if (pos >= len - 1)
  {
    return 0;
  }
  else if (cache[pos] != -1)
  {
    return cache[pos];
  }
  else
  {
    cache[pos] = len * 2;
    var posval = pathfind_aux(cache, tab, len, tab[pos]);
    var oneval = pathfind_aux(cache, tab, len, pos + 1);
    var out_ = 0;
    if (posval < oneval)
    {
      out_ = 1 + posval;
    }
    else
    {
      out_ = 1 + oneval;
    }
    cache[pos] = out_;
    return out_;
  }
}

function pathfind(tab, len){
  var cache = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
  {
    cache[i] = -1;
  }
  return pathfind_aux(cache, tab, len, 0);
}

var len = 0;
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
var result = pathfind(tab, len);
util.print(result);



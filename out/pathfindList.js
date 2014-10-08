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
function pathfind_aux(cache, tab, len, pos){
  if (pos >= len - 1)
    return 0;
  else if (cache[pos] != -1)
    return cache[pos];
  else
  {
    cache[pos] = len * 2;
    var posval = pathfind_aux(cache, tab, len, tab[pos]);
    var oneval = pathfind_aux(cache, tab, len, pos + 1);
    var out0 = 0;
    if (posval < oneval)
      out0 = 1 + posval;
    else
      out0 = 1 + oneval;
    cache[pos] = out0;
    return out0;
  }
}

function pathfind(tab, len){
  var cache = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
    cache[i] = -1;
  return pathfind_aux(cache, tab, len, 0);
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
var result = pathfind(tab, len);
util.print(result);


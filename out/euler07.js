
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


function divisible(n, t, size){
  for (var i = 0 ; i <= size - 1; i++)
    if ((~~(n % t[i])) == 0)
    return 1;
  return 0;
}

function find(n, t, used, nth){
  while (used != nth)
    if (divisible(n, t, used))
    n ++;
  else
  {
    t[used] = n;
    n ++;
    used ++;
  }
  return t[used - 1];
}

var n = 10001;
var t = new Array(n);
for (var i = 0 ; i <= n - 1; i++)
  t[i] = 2;
util.print(find(3, t, 1, n), "\n");



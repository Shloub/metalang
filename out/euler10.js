
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


function eratostene(t, max_){
  var sum = 0;
  for (var i = 2 ; i <= max_ - 1; i++)
    if (t[i] == i)
  {
    sum += i;
    var j = i * i;
    /*
			detect overflow
			*/
    if (~~(j / i) == i)
      while (j < max_ && j > 0)
    {
      t[j] = 0;
      j += i;
    }
  }
  return sum;
}

var n = 100000;
/* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
var t = new Array(n);
for (var i = 0 ; i <= n - 1; i++)
  t[i] = i;
t[1] = 0;
util.print(eratostene(t, n), "\n");



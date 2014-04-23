
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


function fact(n){
  var prod = 1;
  for (var i = 2 ; i <= n; i++)
    prod *= i;
  return prod;
}

function show(lim, nth){
  var t = new Array(lim);
  for (var i = 0 ; i <= lim - 1; i++)
    t[i] = i;
  var pris = new Array(lim);
  for (var j = 0 ; j <= lim - 1; j++)
    pris[j] = 0;
  for (var k = 1 ; k <= lim - 1; k++)
  {
    var n = fact(lim - k);
    var nchiffre = ~~(nth / n);
    nth %= n;
    for (var l = 0 ; l <= lim - 1; l++)
      if (!pris[l])
    {
      if (nchiffre == 0)
      {
        util.print(l);
        pris[l] = 1;
      }
      nchiffre --;
    }
  }
  for (var m = 0 ; m <= lim - 1; m++)
    if (!pris[m])
    util.print(m);
  util.print("\n");
}

show(10, 999999);




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


function max2(a, b){
  if (a > b)
    return a;
  return b;
}

function primesfactors(n){
  var c = n + 1;
  var tab = new Array(c);
  for (var i = 0 ; i <= c - 1; i++)
    tab[i] = 0;
  var d = 2;
  while (n != 1 && d * d <= n)
    if ((~~(n % d)) == 0)
  {
    tab[d] = tab[d] + 1;
    n = ~~(n / d);
  }
  else
    d ++;
  tab[n] = tab[n] + 1;
  return tab;
}

var lim = 20;
var e = lim + 1;
var o = new Array(e);
for (var m = 0 ; m <= e - 1; m++)
  o[m] = 0;
for (var i = 1 ; i <= lim; i++)
{
  var t = primesfactors(i);
  for (var j = 1 ; j <= i; j++)
    o[j] = max2(o[j], t[j]);
}
var product = 1;
for (var k = 1 ; k <= lim; k++)
  for (var l = 1 ; l <= o[k]; l++)
    product *= k;
util.print(product, "\n");



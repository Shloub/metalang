
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
  var n = 0;
  for (var i = 2 ; i <= max_ - 1; i++)
    if (t[i] == i)
  {
    n ++;
    var j = i * i;
    if (~~(j / i) == i)
    {
      /* overflow test */
      while (j < max_ && j > 0)
      {
        t[j] = 0;
        j += i;
      }
    }
  }
  return n;
}

var maximumprimes = 6000;
var era = new Array(maximumprimes);
for (var j_ = 0 ; j_ <= maximumprimes - 1; j_++)
  era[j_] = j_;
var nprimes = eratostene(era, maximumprimes);
var primes = new Array(nprimes);
for (var o = 0 ; o <= nprimes - 1; o++)
  primes[o] = 0;
var l = 0;
for (var k = 2 ; k <= maximumprimes - 1; k++)
  if (era[k] == k)
{
  primes[l] = k;
  l ++;
}
util.print(l, " == ", nprimes, "\n");
var canbe = new Array(maximumprimes);
for (var i_ = 0 ; i_ <= maximumprimes - 1; i_++)
  canbe[i_] = 0;
for (var i = 0 ; i <= nprimes - 1; i++)
  for (var j = 0 ; j <= maximumprimes - 1; j++)
  {
    var n = primes[i] + 2 * j * j;
    if (n < maximumprimes)
      canbe[n] = 1;
}
for (var m = 1 ; m <= maximumprimes; m++)
{
  var m2 = m * 2 + 1;
  if (m2 < maximumprimes && !canbe[m2])
  {
    util.print(m2, "\n");
  }
}




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


function min2(a, b){
  if (a < b)
    return a;
  return b;
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

var maximumprimes = 1000001;
var era = new Array(maximumprimes);
for (var j = 0 ; j <= maximumprimes - 1; j++)
  era[j] = j;
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
var sum = new Array(nprimes);
for (var i_ = 0 ; i_ <= nprimes - 1; i_++)
  sum[i_] = primes[i_];
var maxl = 0;
var process = 1;
var stop = maximumprimes - 1;
var len = 1;
var resp = 1;
while (process)
{
  process = 0;
  for (var i = 0 ; i <= stop; i++)
    if (i + len < nprimes)
  {
    sum[i] = sum[i] + primes[i + len];
    if (maximumprimes > sum[i])
    {
      process = 1;
      if (era[sum[i]] == sum[i])
      {
        maxl = len;
        resp = sum[i];
      }
    }
    else
      stop = min2(stop, i);
  }
  len ++;
}
util.print(resp, "\n", maxl, "\n");




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
    while (j < max_ && j > 0)
    {
      t[j] = 0;
      j += i;
    }
  }
  return n;
}

function fillPrimesFactors(t, n, primes, nprimes){
  for (var i = 0 ; i <= nprimes - 1; i++)
  {
    var d = primes[i];
    while ((~~(n % d)) == 0)
    {
      t[d] = t[d] + 1;
      n = ~~(n / d);
    }
    if (n == 1)
      return primes[i];
  }
  return n;
}

function sumdivaux2(t, n, i){
  while (i < n && t[i] == 0)
    i ++;
  return i;
}

function sumdivaux(t, n, i){
  if (i > n)
    return 1;
  else if (t[i] == 0)
    return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
  else
  {
    var o = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    var out_ = 0;
    var p = i;
    for (var j = 1 ; j <= t[i]; j++)
    {
      out_ += p;
      p *= i;
    }
    return (out_ + 1) * o;
  }
}

function sumdiv(nprimes, primes, n){
  var a = n + 1;
  var t = new Array(a);
  for (var i = 0 ; i <= a - 1; i++)
    t[i] = 0;
  var max_ = fillPrimesFactors(t, n, primes, nprimes);
  return sumdivaux(t, max_, 0);
}

var maximumprimes = 1001;
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
var sum = 0;
for (var n = 2 ; n <= 1000; n++)
{
  var other = sumdiv(nprimes, primes, n) - n;
  if (other > n)
  {
    var othersum = sumdiv(nprimes, primes, other) - other;
    if (othersum == n)
    {
      util.print(other, " & ", n, "\n");
      sum += other + n;
    }
  }
}
util.print("\n", sum, "\n");



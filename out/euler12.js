
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

function eratostene(t, max_){
  var n = 0;
  for (var i = 2 ; i <= max_ - 1; i++)
    if (t[i] == i)
  {
    var j = i * i;
    n ++;
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

function find(ndiv2){
  var maximumprimes = 10000;
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
  for (var n = 1 ; n <= 1000000; n++)
  {
    var c = n + 2;
    var primesFactors = new Array(c);
    for (var m = 0 ; m <= c - 1; m++)
      primesFactors[m] = 0;
    var max_ = max2(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
    primesFactors[2] --;
    var ndivs = 1;
    for (var i = 0 ; i <= max_; i++)
      if (primesFactors[i] != 0)
      ndivs *= 1 + primesFactors[i];
    if (ndivs > ndiv2)
      return ~~((n * (n + 1)) / 2);
    /* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" */
  }
  return 0;
}

var e = find(500);
util.print(e, "\n");



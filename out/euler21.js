var util = require("util");
function eratostene(t, max0){
  var n = 0;
  for (var i = 2 ; i < max0; i++)
    if (t[i] == i)
  {
    n ++;
    var j = i * i;
    while (j < max0 && j > 0)
    {
      t[j] = 0;
      j += i;
    }
  }
  return n;
}

function fillPrimesFactors(t, n, primes, nprimes){
  for (var i = 0 ; i < nprimes; i++)
  {
    var d = primes[i];
    while (~~(n % d) == 0)
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
    var out0 = 0;
    var p = i;
    for (var j = 1 ; j <= t[i]; j++)
    {
      out0 += p;
      p *= i;
    }
    return (out0 + 1) * o;
  }
}

function sumdiv(nprimes, primes, n){
  var t = new Array(n + 1);
  for (var i = 0 ; i < n + 1; i++)
    t[i] = 0;
  var max0 = fillPrimesFactors(t, n, primes, nprimes);
  return sumdivaux(t, max0, 0);
}

var maximumprimes = 1001;
var era = new Array(maximumprimes);
for (var j = 0 ; j < maximumprimes; j++)
  era[j] = j;
var nprimes = eratostene(era, maximumprimes);
var primes = new Array(nprimes);
for (var o = 0 ; o < nprimes; o++)
  primes[o] = 0;
var l = 0;
for (var k = 2 ; k < maximumprimes; k++)
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


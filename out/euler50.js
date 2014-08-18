function min2(a, b){
  return Math.min(a, b);
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


var util = require("util");
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


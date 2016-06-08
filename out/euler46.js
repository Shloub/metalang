var util = require("util");

function eratostene(t, max0) {
    var n = 0;
    for (var i = 2; i < max0; i += 1)
        if (t[i] == i)
        {
            n += 1;
            if (~~(max0 / i) > i)
            {
                var j = i * i;
                while (j < max0 && j > 0)
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
for (var j_ = 0; j_ < maximumprimes; j_ += 1)
    era[j_] = j_;
var nprimes = eratostene(era, maximumprimes);
var primes = new Array(nprimes);
for (var o = 0; o < nprimes; o += 1)
    primes[o] = 0;
var l = 0;
for (var k = 2; k < maximumprimes; k += 1)
    if (era[k] == k)
    {
        primes[l] = k;
        l += 1;
    }
util.print(l, " == ", nprimes, "\n");
var canbe = new Array(maximumprimes);
for (var i_ = 0; i_ < maximumprimes; i_ += 1)
    canbe[i_] = false;
for (var i = 0; i < nprimes; i += 1)
    for (var j = 0; j < maximumprimes; j += 1)
    {
        var n = primes[i] + 2 * j * j;
        if (n < maximumprimes)
            canbe[n] = true;
    }
for (var m = 1; m <= maximumprimes; m += 1)
{
    var m2 = m * 2 + 1;
    if (m2 < maximumprimes && !canbe[m2])
        util.print(m2, "\n");
}


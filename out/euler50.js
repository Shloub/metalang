var util = require("util");
function eratostene(t, max0){
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

var maximumprimes = 1000001;
var era = new Array(maximumprimes);
for (var j = 0; j < maximumprimes; j += 1)
    era[j] = j;
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
var sum = new Array(nprimes);
for (var i_ = 0; i_ < nprimes; i_ += 1)
    sum[i_] = primes[i_];
var maxl = 0;
var process = true;
var stop = maximumprimes - 1;
var len = 1;
var resp = 1;
while (process)
{
    process = false;
    for (var i = 0; i <= stop; i += 1)
        if (i + len < nprimes)
        {
            sum[i] += primes[i + len];
            if (maximumprimes > sum[i])
            {
                process = true;
                if (era[sum[i]] == sum[i])
                {
                    maxl = len;
                    resp = sum[i];
                }
            }
            else
                stop = Math.min(stop, i);
        }
    len += 1;
}
util.print(resp, "\n", maxl, "\n");


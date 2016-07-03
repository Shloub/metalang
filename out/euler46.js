var util = require("util");
function eratostene(t, max0){
    var n = 0;
    for (var i = 2; i < max0; i++)
        if (t[i] == i)
        {
            n++;
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
for (var j_ = 0; j_ < maximumprimes; j_++)
    era[j_] = j_;
var nprimes = eratostene(era, maximumprimes);
var primes = new Array(nprimes);
for (var o = 0; o < nprimes; o++)
    primes[o] = 0;
var l = 0;
for (var k = 2; k < maximumprimes; k++)
    if (era[k] == k)
    {
        primes[l] = k;
        l++;
    }
util.print(l, " == ", nprimes, "\n");
var canbe = new Array(maximumprimes);
for (var i_ = 0; i_ < maximumprimes; i_++)
    canbe[i_] = false;
for (var i = 0; i < nprimes; i++)
    for (var j = 0; j < maximumprimes; j++)
    {
        var n = primes[i] + 2 * j * j;
        if (n < maximumprimes)
            canbe[n] = true;
    }
for (var m = 1; m <= maximumprimes; m++)
{
    var m2 = m * 2 + 1;
    if (m2 < maximumprimes && !canbe[m2])
        util.print(m2, "\n");
}


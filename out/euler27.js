var util = require("util");
function eratostene(t, max0){
    var n = 0;
    for (var i = 2; i < max0; i++)
        if (t[i] == i)
        {
            n++;
            var j = i * i;
            while (j < max0 && j > 0)
            {
                t[j] = 0;
                j += i;
            }
        }
    return n;
}
function isPrime(n, primes, len){
    var i = 0;
    if (n < 0)
        n = -n;
    while (primes[i] * primes[i] < n)
    {
        if (~~(n % primes[i]) == 0)
            return false;
        i++;
    }
    return true;
}
function test(a, b, primes, len){
    for (var n = 0; n < 201; n++)
    {
        var j = n * n + a * n + b;
        if (!isPrime(j, primes, len))
            return n;
    }
    return 200;
}
var maximumprimes = 1000;
var era = new Array(maximumprimes);
for (var j = 0; j < maximumprimes; j++)
    era[j] = j;
var result = 0;
var max0 = 0;
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
var ma = 0;
var mb = 0;
for (var b = 3; b < 1000; b++)
    if (era[b] == b)
        for (var a = -999; a < 1000; a++)
        {
            var n1 = test(a, b, primes, nprimes);
            var n2 = test(a, -b, primes, nprimes);
            if (n1 > max0)
            {
                max0 = n1;
                result = a * b;
                ma = a;
                mb = b;
            }
            if (n2 > max0)
            {
                max0 = n2;
                result = -a * b;
                ma = a;
                mb = -b;
            }
        }
util.print(ma, " ", mb, "\n", max0, "\n", result, "\n");


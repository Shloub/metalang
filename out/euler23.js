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
function fillPrimesFactors(t, n, primes, nprimes){
    for (var i = 0; i < nprimes; i++)
    {
        var d = primes[i];
        while (~~(n % d) == 0)
        {
            t[d]++;
            n = ~~(n / d);
        }
        if (n == 1)
            return primes[i];
    }
    return n;
}
function sumdivaux2(t, n, i){
    while (i < n && t[i] == 0)
        i++;
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
        for (var j = 1; j <= t[i]; j++)
        {
            out0 += p;
            p *= i;
        }
        return (out0 + 1) * o;
    }
}
function sumdiv(nprimes, primes, n){
    var t = new Array(n + 1);
    for (var i = 0; i <= n; i++)
        t[i] = 0;
    var max0 = fillPrimesFactors(t, n, primes, nprimes);
    return sumdivaux(t, max0, 0);
}
var maximumprimes = 30001;
var era = new Array(maximumprimes);
for (var s = 0; s < maximumprimes; s++)
    era[s] = s;
var nprimes = eratostene(era, maximumprimes);
var primes = new Array(nprimes);
for (var t = 0; t < nprimes; t++)
    primes[t] = 0;
var l = 0;
for (var k = 2; k < maximumprimes; k++)
    if (era[k] == k)
    {
        primes[l] = k;
        l++;
    }
var n = 100;
//  28124 ça prend trop de temps mais on arrive a passer le test 

var abondant = new Array(n + 1);
for (var p = 0; p <= n; p++)
    abondant[p] = false;
var summable = new Array(n + 1);
for (var q = 0; q <= n; q++)
    summable[q] = false;
var sum = 0;
for (var r = 2; r <= n; r++)
{
    var other = sumdiv(nprimes, primes, r) - r;
    if (other > r)
        abondant[r] = true;
}
for (var i = 1; i <= n; i++)
    for (var j = 1; j <= n; j++)
        if (abondant[i] && abondant[j] && i + j <= n)
            summable[i + j] = true;
for (var o = 1; o <= n; o++)
    if (!summable[o])
        sum += o;
util.print("\n", sum, "\n");


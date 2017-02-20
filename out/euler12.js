var util = require("util");
function eratostene(t, max0){
    var n = 0;
    for (var i = 2; i < max0; i++)
        if (t[i] == i)
        {
            var j = i * i;
            n++;
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
function find(ndiv2){
    var maximumprimes = 110;
    var era = new Array(maximumprimes);
    for (var j = 0; j < maximumprimes; j++)
        era[j] = j;
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
    for (var n = 1; n < 10001; n++)
    {
        var primesFactors = new Array(n + 2);
        for (var m = 0; m <= n + 1; m++)
            primesFactors[m] = 0;
        var max0 = Math.max(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
        primesFactors[2]--;
        var ndivs = 1;
        for (var i = 0; i <= max0; i++)
            if (primesFactors[i] != 0)
                ndivs *= 1 + primesFactors[i];
        if (ndivs > ndiv2)
            return ~~(n * (n + 1) / 2);
        //  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" 
        
    }
    return 0;
}
util.print(find(500), "\n");


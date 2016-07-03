#include <iostream>
#include <vector>
#include <algorithm>

int eratostene(std::vector<int>& t, int max0) {
    int n = 0;
    for (int i = 2; i < max0; i += 1)
        if (t[i] == i)
        {
            int j = i * i;
            n += 1;
            while (j < max0 && j > 0)
            {
                t[j] = 0;
                j += i;
            }
        }
    return n;
}


int fillPrimesFactors(std::vector<int>& t, int n, std::vector<int>& primes, int nprimes) {
    for (int i = 0; i < nprimes; i += 1)
    {
        int d = primes[i];
        while (n % d == 0)
        {
            t[d] += 1;
            n /= d;
        }
        if (n == 1)
            return primes[i];
    }
    return n;
}


int find(int ndiv2) {
    int maximumprimes = 110;
    std::vector<int> era( maximumprimes );
    for (int j = 0; j < maximumprimes; j += 1)
        era[j] = j;
    int nprimes = eratostene(era, maximumprimes);
    std::vector<int> primes( nprimes, 0 );
    int l = 0;
    for (int k = 2; k < maximumprimes; k += 1)
        if (era[k] == k)
        {
            primes[l] = k;
            l += 1;
        }
    for (int n = 1; n <= 10000; n += 1)
    {
        std::vector<int> primesFactors( n + 2, 0 );
        int max0 = std::max(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
        primesFactors[2] -= 1;
        int ndivs = 1;
        for (int i = 0; i <= max0; i += 1)
            if (primesFactors[i] != 0)
                ndivs *= 1 + primesFactors[i];
        if (ndivs > ndiv2)
            return n * (n + 1) / 2;
        /* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" */
    }
    return 0;
}


int main() {
    std::cout << find(500) << "\n";
}


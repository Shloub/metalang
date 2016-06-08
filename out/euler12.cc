#include <iostream>
#include <vector>
#include <algorithm>

int eratostene(std::vector<int> * t, int max0) {
    int n = 0;
    for (int i = 2; i < max0; i++)
      if (t->at(i) == i)
    {
        int j = i * i;
        n++;
        while (j < max0 && j > 0)
        {
            t->at(j) = 0;
            j += i;
        }
    }
    return n;
}


int fillPrimesFactors(std::vector<int> * t, int n, std::vector<int> * primes, int nprimes) {
    for (int i = 0; i < nprimes; i++)
    {
        int d = primes->at(i);
        while (n % d == 0)
        {
            t->at(d)++;
            n /= d;
        }
        if (n == 1)
          return primes->at(i);
    }
    return n;
}


int find(int ndiv2) {
    int maximumprimes = 110;
    std::vector<int> *era = new std::vector<int>( maximumprimes );
    for (int j = 0; j < maximumprimes; j++)
      era->at(j) = j;
    int nprimes = eratostene(era, maximumprimes);
    std::vector<int> *primes = new std::vector<int>( nprimes );
    std::fill(primes->begin(), primes->end(), 0);
    int l = 0;
    for (int k = 2; k < maximumprimes; k++)
      if (era->at(k) == k)
    {
        primes->at(l) = k;
        l++;
    }
    for (int n = 1; n <= 10000; n ++)
    {
        std::vector<int> *primesFactors = new std::vector<int>( n + 2 );
        std::fill(primesFactors->begin(), primesFactors->end(), 0);
        int max0 = std::max(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
        primesFactors->at(2) --;
        int ndivs = 1;
        for (int i = 0; i <= max0; i ++)
          if (primesFactors->at(i) != 0)
          ndivs *= 1 + primesFactors->at(i);
        if (ndivs > ndiv2)
          return n * (n + 1) / 2;
        /* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" */
    }
    return 0;
}


int main() {
    std::cout << find(500) << "\n";
}


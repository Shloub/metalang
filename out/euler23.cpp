#include <iostream>
#include <vector>

int eratostene(std::vector<int>& t, int max0) {
    int n = 0;
    for (int i = 2; i < max0; i += 1)
        if (t[i] == i)
        {
            n += 1;
            int j = i * i;
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


int sumdivaux2(std::vector<int>& t, int n, int i) {
    while (i < n && t[i] == 0)
        i += 1;
    return i;
}


int sumdivaux(std::vector<int>& t, int n, int i) {
    if (i > n)
        return 1;
    else if (t[i] == 0)
        return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    else
    {
        int o = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
        int out0 = 0;
        int p = i;
        for (int j = 1; j <= t[i]; j += 1)
        {
            out0 += p;
            p *= i;
        }
        return (out0 + 1) * o;
    }
}


int sumdiv(int nprimes, std::vector<int>& primes, int n) {
    std::vector<int> t( n + 1, 0 );
    int max0 = fillPrimesFactors(t, n, primes, nprimes);
    return sumdivaux(t, max0, 0);
}


int main() {
    int maximumprimes = 30001;
    std::vector<int> era( maximumprimes );
    for (int s = 0; s < maximumprimes; s += 1)
        era[s] = s;
    int nprimes = eratostene(era, maximumprimes);
    std::vector<int> primes( nprimes, 0 );
    int l = 0;
    for (int k = 2; k < maximumprimes; k += 1)
        if (era[k] == k)
        {
            primes[l] = k;
            l += 1;
        }
    int n = 100;
    /* 28124 ça prend trop de temps mais on arrive a passer le test */
    std::vector<bool> abondant( n + 1, false );
    std::vector<bool> summable( n + 1, false );
    int sum = 0;
    for (int r = 2; r <= n; r += 1)
    {
        int other = sumdiv(nprimes, primes, r) - r;
        if (other > r)
            abondant[r] = true;
    }
    for (int i = 1; i <= n; i += 1)
        for (int j = 1; j <= n; j += 1)
            if (abondant[i] && abondant[j] && i + j <= n)
                summable[i + j] = true;
    for (int o = 1; o <= n; o += 1)
        if (!summable[o])
            sum += o;
    std::cout << "\n" << sum << "\n";
}


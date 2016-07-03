#include <iostream>
#include <vector>
#include <algorithm>

int eratostene(std::vector<int>& t, int max0) {
    int n = 0;
    for (int i = 2; i < max0; i += 1)
        if (t[i] == i)
        {
            n += 1;
            if (max0 / i > i)
            {
                int j = i * i;
                while (j < max0 && j > 0)
                {
                    t[j] = 0;
                    j += i;
                }
            }
        }
    return n;
}


int main() {
    int maximumprimes = 1000001;
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
    std::cout << l << " == " << nprimes << "\n";
    std::vector<int> sum( nprimes );
    for (int i_ = 0; i_ < nprimes; i_ += 1)
        sum[i_] = primes[i_];
    int maxl = 0;
    bool process = true;
    int stop = maximumprimes - 1;
    int len = 1;
    int resp = 1;
    while (process)
    {
        process = false;
        for (int i = 0; i <= stop; i += 1)
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
                    stop = std::min(stop, i);
            }
        len += 1;
    }
    std::cout << resp << "\n" << maxl << "\n";
}


#include <iostream>
#include <vector>

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
    int maximumprimes = 6000;
    std::vector<int> era( maximumprimes );
    for (int j_ = 0; j_ < maximumprimes; j_ += 1)
        era[j_] = j_;
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
    std::vector<bool> canbe( maximumprimes, false );
    for (int i = 0; i < nprimes; i += 1)
        for (int j = 0; j < maximumprimes; j += 1)
        {
            int n = primes[i] + 2 * j * j;
            if (n < maximumprimes)
                canbe[n] = true;
        }
    for (int m = 1; m <= maximumprimes; m += 1)
    {
        int m2 = m * 2 + 1;
        if (m2 < maximumprimes && !canbe[m2])
            std::cout << m2 << "\n";
    }
}


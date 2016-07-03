#include <iostream>
#include <vector>
#include <algorithm>

std::vector<int> primesfactors(int n) {
    std::vector<int> tab( n + 1, 0 );
    int d = 2;
    while (n != 1 && d * d <= n)
        if (n % d == 0)
        {
            tab[d] += 1;
            n /= d;
        }
        else
            d += 1;
    tab[n] += 1;
    return tab;
}


int main() {
    int lim = 20;
    std::vector<int> o( lim + 1, 0 );
    for (int i = 1; i <= lim; i += 1)
    {
        std::vector<int> t = primesfactors(i);
        for (int j = 1; j <= i; j += 1)
            o[j] = std::max(o[j], t[j]);
    }
    int product = 1;
    for (int k = 1; k <= lim; k += 1)
        for (int l = 1; l <= o[k]; l += 1)
            product *= k;
    std::cout << product << "\n";
}


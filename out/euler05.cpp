#include <iostream>
#include <vector>
#include <algorithm>


std::vector<int> primesfactors(int n) {
    std::vector<int> tab( n + 1, 0 );
    int d = 2;
    while (n != 1 && d * d <= n)
        if (n % d == 0)
        {
            tab[d]++;
            n /= d;
        }
        else
            d++;
    tab[n]++;
    return tab;
}

int main() {
    int lim = 20;
    std::vector<int> o( lim + 1, 0 );
    for (int i = 1; i <= lim; i++)
    {
        std::vector<int> t = primesfactors(i);
        for (int j = 1; j <= i; j++)
            o[j] = std::max(o[j], t[j]);
    }
    int product = 1;
    for (int k = 1; k <= lim; k++)
        for (int l = 1; l <= o[k]; l++)
            product *= k;
    std::cout << product << "\n";
}


#include <iostream>
#include <vector>

int main() {
    int n = 10;
    /* normalement on doit mettre 20 mais là on se tape un overflow */
    n += 1;
    std::vector<std::vector<int>> tab( n );
    for (int i = 0; i < n; i += 1)
    {
        std::vector<int> tab2( n, 0 );
        tab[i] = tab2;
    }
    for (int l = 0; l < n; l += 1)
    {
        tab[n - 1][l] = 1;
        tab[l][n - 1] = 1;
    }
    for (int o = 2; o <= n; o += 1)
    {
        int r = n - o;
        for (int p = 2; p <= n; p += 1)
        {
            int q = n - p;
            tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
        }
    }
    for (int m = 0; m < n; m += 1)
    {
        for (int k = 0; k < n; k += 1)
            std::cout << tab[m][k] << " ";
        std::cout << "\n";
    }
    std::cout << tab[0][0] << "\n";
}


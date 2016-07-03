#include <iostream>
#include <vector>

int main() {
    int n = 10;
    /* normalement on doit mettre 20 mais là on se tape un overflow */
    n += 1;
    std::vector<std::vector<int> *> *tab = new std::vector<std::vector<int> *>( n );
    for (int i = 0; i < n; i += 1)
    {
        std::vector<int> *tab2 = new std::vector<int>( n );
        std::fill(tab2->begin(), tab2->end(), 0);
        tab->at(i) = tab2;
    }
    for (int l = 0; l < n; l += 1)
    {
        tab->at(n - 1)->at(l) = 1;
        tab->at(l)->at(n - 1) = 1;
    }
    for (int o = 2; o <= n; o += 1)
    {
        int r = n - o;
        for (int p = 2; p <= n; p += 1)
        {
            int q = n - p;
            tab->at(r)->at(q) = tab->at(r + 1)->at(q) + tab->at(r)->at(q + 1);
        }
    }
    for (int m = 0; m < n; m += 1)
    {
        for (int k = 0; k < n; k += 1)
            std::cout << tab->at(m)->at(k) << " ";
        std::cout << "\n";
    }
    std::cout << tab->at(0)->at(0) << "\n";
}


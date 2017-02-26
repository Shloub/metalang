#include <iostream>
#include <vector>

int next0(int n) {
    if (n % 2 == 0)
        return n / 2;
    else
        return 3 * n + 1;
}


int find(int n, std::vector<int> * m) {
    if (n == 1)
        return 1;
    else if (n >= 1000000)
        return 1 + find(next0(n), m);
    else if (m->at(n) != 0)
        return m->at(n);
    else
    {
        m->at(n) = 1 + find(next0(n), m);
        return m->at(n);
    }
}

int main() {
    std::vector<int> *m = new std::vector<int>( 1000000 );
    std::fill(m->begin(), m->end(), 0);
    int max0 = 0;
    int maxi = 0;
    for (int i = 1; i < 1000; i++)
    {
        //  normalement on met 999999 mais ça dépasse les int32... 
        int n2 = find(i, m);
        if (n2 > max0)
        {
            max0 = n2;
            maxi = i;
        }
    }
    std::cout << max0 << "\n" << maxi << "\n";
}


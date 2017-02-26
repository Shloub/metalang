#include <iostream>
#include <vector>

int go0(std::vector<int>& tab, int a, int b) {
    int m = (a + b) / 2;
    if (a == m)
        if (tab[a] == m)
            return b;
        else
            return a;
    int i = a;
    int j = b;
    while (i < j)
    {
        int e = tab[i];
        if (e < m)
            i++;
        else
        {
            j--;
            tab[i] = tab[j];
            tab[j] = e;
        }
    }
    if (i < m)
        return go0(tab, a, m);
    else
        return go0(tab, m, b);
}


int plus_petit0(std::vector<int>& tab, int len) {
    return go0(tab, 0, len);
}

int main() {
    int len = 0;
    std::cin >> len;
    std::vector<int> tab( len );
    for (int i = 0; i < len; i++)
    {
        int tmp = 0;
        std::cin >> tmp;
        tab[i] = tmp;
    }
    std::cout << plus_petit0(tab, len);
}


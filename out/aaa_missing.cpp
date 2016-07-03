#include <iostream>
#include <vector>
/*
  Ce test a été généré par Metalang.
*/

int result(int len, std::vector<int>& tab) {
    std::vector<bool> tab2( len, false );
    for (int i1 = 0; i1 < len; i1 += 1)
    {
        std::cout << tab[i1] << " ";
        tab2[tab[i1]] = true;
    }
    std::cout << "\n";
    for (int i2 = 0; i2 < len; i2 += 1)
        if (!tab2[i2])
            return i2;
    return -1;
}


int main() {
    int len;
    std::cin >> len;
    std::cout << len << "\n";
    std::vector<int> tab( len );
    for (int a = 0; a < len; a += 1)
    {
        std::cin >> tab[a];
    }
    std::cout << result(len, tab) << "\n";
}


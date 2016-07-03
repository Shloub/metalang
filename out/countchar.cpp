#include <iostream>
#include <vector>

int nth(std::vector<char>& tab, char tofind, int len) {
    int out0 = 0;
    for (int i = 0; i < len; i += 1)
        if (tab[i] == tofind)
            out0 += 1;
    return out0;
}


int main(void) {
    int len = 0;
    std::cin >> len;
    char tofind = '\u0000';
    std::cin >> tofind;
    std::vector<char> tab( len );
    for (int i = 0; i < len; i += 1)
    {
        char tmp = '\u0000';
        std::cin >> tmp >> std::noskipws;
        tab[i] = tmp;
    }
    int result = nth(tab, tofind, len);
    std::cout << result;
    return 0;
}


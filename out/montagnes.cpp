#include <iostream>
#include <vector>

int montagnes0(std::vector<int>& tab, int len) {
    int max0 = 1;
    int j = 1;
    int i = len - 2;
    while (i >= 0)
    {
        int x = tab[i];
        while (j >= 0 && x > tab[len - j])
            j -= 1;
        j += 1;
        tab[len - j] = x;
        if (j > max0)
            max0 = j;
        i -= 1;
    }
    return max0;
}


int main(void) {
    int len = 0;
    std::cin >> len;
    std::vector<int> tab( len );
    for (int i = 0; i < len; i += 1)
    {
        int x = 0;
        std::cin >> x;
        tab[i] = x;
    }
    std::cout << montagnes0(tab, len);
    return 0;
}


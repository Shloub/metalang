#include <iostream>
#include <vector>

int summax(std::vector<int> * lst, int len) {
    int current = 0;
    int max0 = 0;
    for (int i = 0; i < len; i++)
    {
        current += lst->at(i);
        if (current < 0)
          current = 0;
        if (max0 < current)
          max0 = current;
    }
    return max0;
}


int main() {
    int len = 0;
    std::cin >> len;
    std::vector<int> *tab = new std::vector<int>( len );
    for (int i = 0; i < len; i++)
    {
        int tmp = 0;
        std::cin >> tmp;
        tab->at(i) = tmp;
    }
    int result = summax(tab, len);
    std::cout << result;
}


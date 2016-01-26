#include <iostream>
#include <vector>

void test(std::vector<int>& tab, int len) {
    for (int i = 0; i < len; i++)
      std::cout << tab[i] << " ";
    std::cout << "\n";
}


int main() {
    std::vector<int> t(5, 1);
    test(t, 5);
}


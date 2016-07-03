#include <iostream>
#include <vector>

void test(std::vector<int> * tab, int len) {
    for (int i = 0; i < len; i += 1)
        std::cout << tab->at(i) << " ";
    std::cout << "\n";
}


int main() {
    std::vector<int> *t = new std::vector<int>( 5 );
    std::fill(t->begin(), t->end(), 1);
    test(t, 5);
}


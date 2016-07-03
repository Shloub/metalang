#include <iostream>
#include <vector>

int main() {
    int len;
    std::cin >> len;
    std::cout << len << "=len\n";
    std::vector<int> *tab1 = new std::vector<int>( len );
    for (int a = 0; a < len; a += 1)
    {
        std::cin >> tab1->at(a);
    }
    for (int i = 0; i < len; i += 1)
        std::cout << i << "=>" << tab1->at(i) << "\n";
    std::cin >> len;
    std::vector<std::vector<int> *> *tab2 = new std::vector<std::vector<int> *>( len - 1 );
    for (int b = 0; b < len - 1; b += 1)
    {
        std::vector<int> *c = new std::vector<int>( len );
        for (int d = 0; d < len; d += 1)
        {
            std::cin >> c->at(d);
        }
        tab2->at(b) = c;
    }
    for (int i = 0; i < len - 1; i += 1)
    {
        for (int j = 0; j < len; j += 1)
            std::cout << tab2->at(i)->at(j) << " ";
        std::cout << "\n";
    }
}


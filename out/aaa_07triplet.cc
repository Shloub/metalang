#include <iostream>
#include <vector>

int main() {
    int c, b, a;
    for (int i = 1; i <= 3; i += 1)
    {
        std::cin >> a >> b >> c;
        std::cout << "a = " << a << " b = " << b << "c =" << c << "\n";
    }
    std::vector<int> *l = new std::vector<int>( 10 );
    for (int d = 0; d < 10; d += 1)
    {
        std::cin >> l->at(d);
    }
    for (int j = 0; j <= 9; j += 1)
        std::cout << l->at(j) << "\n";
}


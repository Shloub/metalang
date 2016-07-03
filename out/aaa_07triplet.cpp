#include <iostream>
#include <vector>

int main() {
    int c, b, a;
    for (int i = 1; i <= 3; i += 1)
    {
        std::cin >> a >> b >> c;
        std::cout << "a = " << a << " b = " << b << "c =" << c << "\n";
    }
    std::vector<int> l( 10 );
    for (int d = 0; d <= 9; d += 1)
    {
        std::cin >> l[d];
    }
    for (int j = 0; j <= 9; j += 1)
        std::cout << l[j] << "\n";
}


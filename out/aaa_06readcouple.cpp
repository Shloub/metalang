#include <iostream>
#include <vector>

int main() {
    int b, a;
    for (int i = 1; i <= 3; i += 1)
    {
        std::cin >> a >> b;
        std::cout << "a = " << a << " b = " << b << "\n";
    }
    std::vector<int> l( 10 );
    for (int c = 0; c <= 9; c += 1)
    {
        std::cin >> l[c];
    }
    for (int j = 0; j <= 9; j += 1)
        std::cout << l[j] << "\n";
}


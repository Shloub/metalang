#include <iostream>
#include <vector>

int main(void) {
    int b, a;
    for (int i = 1; i <= 3; i += 1)
    {
        std::cin >> a >> b;
        std::cout << "a = " << a << " b = " << b << "\n";
    }
    std::vector<int> l( 10 );
    for (int c = 0; c < 10; c += 1)
    {
        std::cin >> l[c];
    }
    for (int j = 0; j <= 9; j += 1)
        std::cout << l[j] << "\n";
    return 0;
}


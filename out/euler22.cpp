#include <iostream>
#include <vector>

int score() {
    int len;
    char c;
    std::cin >> std::skipws >> len;
    int sum = 0;
    for (int i = 1; i <= len; i += 1)
    {
        std::cin >> c >> std::noskipws;
        sum += (int)(c) - (int)('A') + 1;
        /*		print c print " " print sum print " " */
    }
    return sum;
}


int main() {
    int n;
    int sum = 0;
    std::cin >> n >> std::noskipws;
    for (int i = 1; i <= n; i += 1)
        sum += i * score();
    std::cout << sum << "\n";
}


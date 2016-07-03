#include <iostream>
#include <vector>
#include <algorithm>

int main(void) {
    std::cout << std::min({2, 3, 4}) << " " << std::min({2, 4, 3}) << " " << std::min({3, 2, 4}) << " " << std::min({3, 4, 2}) << " " << std::min({4, 2, 3}) << " " << std::min({4, 3, 2}) << "\n";
    return 0;
}


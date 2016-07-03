#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::cout << std::min({1, 2, 3, 4}) << " " << std::min({1, 2, 4, 3}) << " " << std::min({1, 3, 2, 4}) << " " << std::min({1, 3, 4, 2}) << " " << std::min({1, 4, 2, 3}) << " " << std::min({1, 4, 3, 2}) << "\n" << std::min({2, 1, 3, 4}) << " " << std::min({2, 1, 4, 3}) << " " << std::min({2, 3, 1, 4}) << " " << std::min({2, 3, 4, 1}) << " " << std::min({2, 4, 1, 3}) << " " << std::min({2, 4, 3, 1}) << "\n" << std::min({3, 1, 2, 4}) << " " << std::min({3, 1, 4, 2}) << " " << std::min({3, 2, 1, 4}) << " " << std::min({3, 2, 4, 1}) << " " << std::min({3, 4, 1, 2}) << " " << std::min({3, 4, 2, 1}) << "\n" << std::min({4, 1, 2, 3}) << " " << std::min({4, 1, 3, 2}) << " " << std::min({4, 2, 1, 3}) << " " << std::min({4, 2, 3, 1}) << " " << std::min({4, 3, 1, 2}) << " " << std::min({4, 3, 2, 1}) << "\n";
}


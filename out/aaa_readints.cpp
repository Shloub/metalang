#include <iostream>
#include <vector>

template <typename T> std::vector<std::vector<T>> read_matrix(int l, int c) {
    std::vector<std::vector<T>> matrix(l, std::vector<T>(c));
    for (std::vector<T>& line : matrix)
        for (T& elem : line)
            std::cin >> elem;
    return matrix;
}

int main() {
    int len;
    std::cin >> len;
    std::cout << len << "=len\n";
    std::vector<int> tab1(len);
    for (int a = 0; a < len; a++)
    {
        std::cin >> tab1[a];
    }
    for (int i = 0; i < len; i++)
      std::cout << i << "=>" << tab1[i] << "\n";
    std::cin >> len;
    std::vector<std::vector<int>> tab2 = read_matrix<int>(len - 1, len);
    for (int i = 0; i <= len - 2; i ++)
    {
        for (int j = 0; j < len; j++)
          std::cout << tab2[i][j] << " ";
        std::cout << "\n";
    }
}


#include <iostream>
#include <vector>

template <typename T> std::vector<std::vector<T>> read_matrix(int l, int c) {
    std::vector<std::vector<T>> matrix(l, std::vector<T>(c));
    for (std::vector<T>& line : matrix)
        for (T& elem : line)
            std::cin >> elem;
    return matrix;
}

int min2_(int a, int b) {
    if (a < b)
      return a;
    else
      return b;
}


int main() {
    int y, x;
    std::cin >> x >> y;
    std::vector<std::vector<int>> tab = read_matrix<int>(y, x);
    for (int ix = 1; ix < x; ix++)
      for (int iy = 1; iy < y; iy++)
        if (tab[iy][ix] == 1)
      tab[iy][ix] =
      min2_(min2_(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) + 1;
    for (int jy = 0; jy < y; jy++)
    {
        for (int jx = 0; jx < x; jx++)
          std::cout << tab[jy][jx] << " ";
        std::cout << "\n";
    }
}


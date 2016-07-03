#include <iostream>
#include <vector>

template <typename T> std::vector<std::vector<T>> read_matrix(int l, int c) {
    std::vector<std::vector<T>> matrix(l, std::vector<T>(c));
    for (std::vector<T>& line : matrix)
        for (T& elem : line)
            std::cin >> elem;
    return matrix;
}

int programme_candidat(std::vector<std::vector<int>>& tableau, int x, int y) {
    int out0 = 0;
    for (int i = 0; i < y; i += 1)
        for (int j = 0; j < x; j += 1)
            out0 += tableau[i][j] * (i * 2 + j);
    return out0;
}


int main(void) {
    int taille_y, taille_x;
    std::cin >> taille_x >> taille_y;
    std::vector<std::vector<int>> tableau = read_matrix<int>(taille_y, taille_x);
    std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
    return 0;
}


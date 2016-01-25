#include <iostream>
#include <vector>

template <typename T> std::vector<std::vector<T>> read_matrix(int x, int y) {
  std::vector<std::vector<T>> matrix(y, std::vector<T>(x));
  std::cin >> std::skipws;
  for (std::vector<T>& line : matrix)
    for (T& elem : line)
      std::cin >> elem;
  return matrix;
}

int programme_candidat(std::vector<std::vector<char>>& tableau, int taille_x, int taille_y) {
  int out0 = 0;
  for (int i = 0; i < taille_y; i++)
  {
    for (int j = 0; j < taille_x; j++)
    {
      out0 += (int)(tableau[i][j]) * (i + j * 2);
      std::cout << tableau[i][j];
    }
    std::cout << "--\n";
  }
  return out0;
}


int main() {
  int taille_y, taille_x;
  std::cin >> taille_x >> std::skipws >> taille_y;
  std::vector<std::vector<char>> tableau = read_matrix<char>(taille_x, taille_y);
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
}


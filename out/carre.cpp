#include <iostream>
#include <vector>
template <typename T> std::vector<std::vector<T> > read_matrix(int x, int y){
  std::vector<std::vector<T> > matrix(y);
  for (int i = 0; i < y; i++)
  {
    std::vector<T>& line = matrix[i];
    line.resize(x);
    for (int j = 0; j < x; j++)
    {
        std::cin >> line[j] >> std::skipws;
    }
  }
  return matrix;
}
int min2_(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}


int main(){
  int y, x;
  std::cin >> x >> std::skipws >> y;
  std::vector<std::vector<int > > tab = read_matrix<int>(x, y);
  for (int ix = 1 ; ix < x; ix++)
    for (int iy = 1 ; iy < y; iy++)
      if (tab[iy][ix] == 1)
    tab[iy][ix] =
    min2_(min2_(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) + 1;
  for (int jy = 0 ; jy < y; jy++)
  {
    for (int jx = 0 ; jx < x; jx++)
      std::cout << tab[jy][jx] << " ";
    std::cout << "\n";
  }
  return 0;
}


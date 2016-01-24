#include <iostream>
#include <vector>
int min2_(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}


int main(){
  int y, x;
  std::cin >> x >> std::skipws >> y;
  std::vector<std::vector<int > > tab(y);
  for (int d = 0 ; d < y; d++)
  {
    std::vector<int > e(x);
    for (int f = 0 ; f < x; f++)
    {
      std::cin >> e[f] >> std::skipws;
    }
    tab[d] = e;
  }
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


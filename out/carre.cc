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
  std::vector<std::vector<int> *> *tab = new std::vector<std::vector<int> *>( y );
  for (int d = 0 ; d < y; d++)
  {
    std::vector<int> *e = new std::vector<int>( x );
    for (int f = 0 ; f < x; f++)
    {
      std::cin >> e->at(f) >> std::skipws;
    }
    tab->at(d) = e;
  }
  for (int ix = 1 ; ix < x; ix++)
    for (int iy = 1 ; iy < y; iy++)
      if (tab->at(iy)->at(ix) == 1)
    tab->at(iy)->at(ix) =
    min2_(min2_(tab->at(iy)->at(ix - 1), tab->at(iy - 1)->at(ix)), tab->at(iy - 1)->at(ix - 1)) + 1;
  for (int jy = 0 ; jy < y; jy++)
  {
    for (int jx = 0 ; jx < x; jx++)
      std::cout << tab->at(jy)->at(jx) << " ";
    std::cout << "\n";
  }
  return 0;
}


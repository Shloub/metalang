#include <iostream>
#include <vector>
int read_int(){
  int out_ = 0;
  std::cin >> out_ >> std::skipws;
  return out_;
}

std::vector<int > read_int_line(int n){
  std::vector<int > tab( n );
  for (int i = 0 ; i < n; i++)
  {
    int t = 0;
    std::cin >> t >> std::skipws;
    tab.at(i) = t;
  }
  return tab;
}

std::vector<std::vector<int > > read_int_matrix(int x, int y){
  std::vector<std::vector<int > > tab( y );
  for (int z = 0 ; z < y; z++)
  {
    int b = x;
    std::vector<int > c( b );
    for (int d = 0 ; d < b; d++)
    {
      int e = 0;
      std::cin >> e >> std::skipws;
      c.at(d) = e;
    }
    std::vector<int > a = c;
    tab.at(z) = a;
  }
  return tab;
}

int programme_candidat(std::vector<std::vector<int > >& tableau, int x, int y){
  int out_ = 0;
  for (int i = 0 ; i < y; i++)
    for (int j = 0 ; j < x; j++)
      out_ += tableau.at(i).at(j) * (i * 2 + j);
  return out_;
}


int main(){
  int g = 0;
  std::cin >> g >> std::skipws;
  int f = g;
  int taille_x = f;
  int k = 0;
  std::cin >> k >> std::skipws;
  int h = k;
  int taille_y = h;
  std::vector<std::vector<int > > tableau = read_int_matrix(taille_x, taille_y);
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
  return 0;
}


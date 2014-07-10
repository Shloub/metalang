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


int main(){
  int g = 0;
  std::cin >> g >> std::skipws;
  int f = g;
  int len = f;
  std::cout << len << "=len\n";
  int k = len;
  std::vector<int > l( k );
  for (int m = 0 ; m < k; m++)
  {
    int o = 0;
    std::cin >> o >> std::skipws;
    l.at(m) = o;
  }
  std::vector<int > h = l;
  std::vector<int > tab1 = h;
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>" << tab1.at(i) << "\n";
  }
  int q = 0;
  std::cin >> q >> std::skipws;
  int p = q;
  len = p;
  std::vector<std::vector<int > > tab2 = read_int_matrix(len, len - 1);
  for (int i = 0 ; i <= len - 2; i ++)
  {
    for (int j = 0 ; j < len; j++)
    {
      std::cout << tab2.at(i).at(j) << " ";
    }
    std::cout << "\n";
  }
  return 0;
}


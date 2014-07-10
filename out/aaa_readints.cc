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
    std::vector<int > b( x );
    for (int c = 0 ; c < x; c++)
    {
      int d = 0;
      std::cin >> d >> std::skipws;
      b.at(c) = d;
    }
    std::vector<int > a = b;
    tab.at(z) = a;
  }
  return tab;
}


int main(){
  int f = 0;
  std::cin >> f >> std::skipws;
  int e = f;
  int len = e;
  std::cout << len << "=len\n";
  std::vector<int > h( len );
  for (int k = 0 ; k < len; k++)
  {
    int l = 0;
    std::cin >> l >> std::skipws;
    h.at(k) = l;
  }
  std::vector<int > g = h;
  std::vector<int > tab1 = g;
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>" << tab1.at(i) << "\n";
  }
  int o = 0;
  std::cin >> o >> std::skipws;
  int m = o;
  len = m;
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


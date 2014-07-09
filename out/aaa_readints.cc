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
    tab.at(z) = read_int_line(x);
  return tab;
}


int main(){
  int len = read_int();
  std::cout << len << "=len\n";
  std::vector<int > tab1 = read_int_line(len);
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>" << tab1.at(i) << "\n";
  }
  len = read_int();
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


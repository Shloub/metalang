#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
std::vector<int > read_int_line(int n){
  std::vector<int > tab( n );
  for (int i = 0 ; i < n; i++)
  {
    int t = 0;
    scanf("%d", &t);
    scanf("%*[ \t\r\n]c", 0);
    tab.at(i) = t;
  }
  return tab;
}

std::vector<std::vector<int > > read_int_matrix(int x, int y){
  std::vector<std::vector<int > > tab( y );
  for (int z = 0 ; z < y; z++)
  {
    std::vector<int > out_ = read_int_line(x);
    scanf("%*[ \t\r\n]c", 0);
    tab.at(z) = out_;
  }
  return tab;
}


int main(void){
  std::vector<int > l0 = read_int_line(1);
  int len = l0.at(0);
  std::cout << len << "=len\n";
  std::vector<int > tab1 = read_int_line(len);
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>";
    int a = tab1.at(i);
    std::cout << a << "\n";
  }
  l0 = read_int_line(1);
  len = l0.at(0);
  std::vector<std::vector<int > > tab2 = read_int_matrix(len, len - 1);
  for (int i = 0 ; i <= len - 2; i ++)
  {
    for (int j = 0 ; j < len; j++)
    {
      int b = tab2.at(i).at(j);
      std::cout << b << " ";
    }
    std::cout << "\n";
  }
  return 0;
}


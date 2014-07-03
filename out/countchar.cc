#include <iostream>
#include <vector>
int nth(std::vector<char >& tab, char tofind, int len){
  int out_ = 0;
  for (int i = 0 ; i < len; i++)
    if (tab.at(i) == tofind)
    out_ ++;
  return out_;
}


int main(){
  int len = 0;
  std::cin >> len >> std::skipws;
  char tofind = '\000';
  std::cin >> tofind >> std::skipws;
  std::vector<char > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    char tmp = '\000';
    std::cin >> tmp >> std::noskipws;
    tab.at(i) = tmp;
  }
  int result = nth(tab, tofind, len);
  std::cout << result;
  return 0;
}


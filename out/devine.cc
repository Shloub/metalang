#include <iostream>
#include <vector>
bool devine_(int nombre, std::vector<int >& tab, int len){
  int min_ = tab.at(0);
  int max_ = tab.at(1);
  for (int i = 2 ; i < len; i++)
  {
    if (tab.at(i) > max_ || tab.at(i) < min_)
      return false;
    if (tab.at(i) < nombre)
      min_ = tab.at(i);
    if (tab.at(i) > nombre)
      max_ = tab.at(i);
    if (tab.at(i) == nombre && len != i + 1)
      return false;
  }
  return true;
}


int main(){
  int nombre = 0;
  std::cin >> nombre >> std::skipws;
  int len = 0;
  std::cin >> len >> std::skipws;
  std::vector<int > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = 0;
    std::cin >> tmp >> std::skipws;
    tab.at(i) = tmp;
  }
  bool a = devine_(nombre, tab, len);
  if (a)
    std::cout << "True";
  else
    std::cout << "False";
  return 0;
}


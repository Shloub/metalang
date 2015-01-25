#include <iostream>
#include <vector>
/*
  Ce test a été généré par Metalang.
*/
int result(int len, std::vector<int> * tab){
  std::vector<bool > *tab2 = new std::vector<bool>( len );
  for (int i = 0 ; i < len; i++)
    tab2->at(i) = false;
  for (int i1 = 0 ; i1 < len; i1++)
  {
    std::cout << tab->at(i1) << " ";
    tab2->at(tab->at(i1)) = true;
  }
  std::cout << "\n";
  for (int i2 = 0 ; i2 < len; i2++)
    if (!tab2->at(i2))
    return i2;
  return -1;
}


int main(){
  int b;
  std::cin >> b >> std::skipws;
  int len = b;
  std::cout << len << "\n";
  std::vector<int > *tab = new std::vector<int>( len );
  for (int e = 0 ; e < len; e++)
  {
    std::cin >> tab->at(e) >> std::skipws;
  }
  std::cout << result(len, tab) << "\n";
  return 0;
}


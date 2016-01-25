#include <iostream>
#include <vector>
/*
  Ce test a été généré par Metalang.
*/
int result(int len, std::vector<int> * tab){
  std::vector<bool> *tab2 = new std::vector<bool>( len );
  std::fill(tab2->begin(), tab2->end(), false);
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
  int len;
  std::cin >> len >> std::skipws;
  std::cout << len << "\n";
  std::vector<int> *tab = new std::vector<int>( len );
  for (int a = 0 ; a < len; a++)
  {
    std::cin >> tab->at(a) >> std::skipws;
  }
  std::cout << result(len, tab) << "\n";
  return 0;
}


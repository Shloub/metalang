#include <iostream>
#include <vector>

int main(){
  int len;
  std::cin >> len >> std::skipws;
  std::cout << len << "=len\n";
  std::vector<int > *tab1 = new std::vector<int>( len );
  for (int k = 0 ; k < len; k++)
  {
    std::cin >> tab1->at(k) >> std::skipws;
  }
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>" << tab1->at(i) << "\n";
  }
  std::cin >> len >> std::skipws;
  std::vector<std::vector<int> * > *tab2 = new std::vector<std::vector<int> *>( len - 1 );
  for (int s = 0 ; s < len - 1; s++)
  {
    std::vector<int > *ba = new std::vector<int>( len );
    for (int v = 0 ; v < len; v++)
    {
      std::cin >> ba->at(v) >> std::skipws;
    }
    tab2->at(s) = ba;
  }
  for (int i = 0 ; i <= len - 2; i ++)
  {
    for (int j = 0 ; j < len; j++)
    {
      std::cout << tab2->at(i)->at(j) << " ";
    }
    std::cout << "\n";
  }
  return 0;
}


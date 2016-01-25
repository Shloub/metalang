#include <iostream>
#include <vector>

int main(){
  int len;
  std::cin >> len >> std::skipws;
  std::cout << len << "=len\n";
  std::vector<int> *tab1 = new std::vector<int>( len );
  for (int a = 0 ; a < len; a++)
  {
    std::cin >> tab1->at(a) >> std::skipws;
  }
  for (int i = 0 ; i < len; i++)
    std::cout << i << "=>" << tab1->at(i) << "\n";
  std::cin >> len >> std::skipws;
  std::vector<std::vector<int> *> *tab2 = new std::vector<std::vector<int> *>( len - 1 );
  for (int b = 0 ; b < len - 1; b++)
  {
    std::vector<int> *c = new std::vector<int>( len );
    for (int d = 0 ; d < len; d++)
    {
      std::cin >> c->at(d) >> std::skipws;
    }
    tab2->at(b) = c;
  }
  for (int i = 0 ; i <= len - 2; i ++)
  {
    for (int j = 0 ; j < len; j++)
      std::cout << tab2->at(i)->at(j) << " ";
    std::cout << "\n";
  }
  return 0;
}

